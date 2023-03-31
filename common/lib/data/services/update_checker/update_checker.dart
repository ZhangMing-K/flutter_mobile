import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html/parser.dart' show parse;
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../shared/widgets/full_screen_version.dart';

class UpdateCheckerService extends GetxService {
  /// An optional value that can override the default packageName when
  /// attempting to reach the Apple App Store. This is useful if your app has
  /// a different package name in the App Store.
  final String? iOSId;

  /// An optional value that can override the default packageName when
  /// attempting to reach the Google Play Store. This is useful if your app has
  /// a different package name in the Play Store.
  final String? androidId;

  UpdateCheckerService({
    this.androidId,
    this.iOSId,
  });

  /// This checks the version status, then displays a platform-specific alert
  /// with buttons to dismiss the update alert, or go to the app store.
  Future<void> checkUpdate() async {
    final VersionStatus? versionStatus = await getVersionStatus();
    if (versionStatus != null && versionStatus.canUpdate) {
      Get.to(() => FullScreenVersion(
            changelog: versionStatus.releaseNotes ?? '',
            onSkip: () {
              showUpdateDialog(
                  versionStatus: versionStatus,
                  dialogTitle: 'Warning!',
                  dismissButtonText: 'Skip Anyway',
                  dismissAction: () {
                    Get.back(closeOverlays: true);
                  },
                  dialogText:
                      'Skipping the update may result in missing features or malfunctioning in the app. Are you sure you want to skip the update?');
            },
            onUpdate: () {
              _launchAppStore(versionStatus.appStoreLink);
            },
          ));
    }
  }

  /// This checks the version status and returns the information. This is useful
  /// if you want to display a custom alert, or use the information in a different
  /// way.
  Future<VersionStatus?> getVersionStatus() async {
    final packageInfo = await PackageInfo.fromPlatform();
    if (GetPlatform.isIOS) {
      return _getiOSStoreVersion(packageInfo);
    } else if (GetPlatform.isAndroid) {
      return _getAndroidStoreVersion(packageInfo);
    } else {
      debugPrint('The target platform is not yet supported');
    }
    return null;
  }

  /// Shows the user a platform-specific alert about the app update. The user
  /// can dismiss the alert or proceed to the app store.
  ///
  /// To change the appearance and behavior of the update dialog, you can
  /// optionally provide [dialogTitle], [dialogText], [updateButtonText],
  /// [dismissButtonText], and [dismissAction] parameters.
  Future<void> showUpdateDialog({
    required VersionStatus versionStatus,
    String dialogTitle = 'Update Available',
    String? dialogText,
    String updateButtonText = 'Update',
    bool allowDismissal = true,
    String dismissButtonText = 'Maybe Later',
    VoidCallback? dismissAction,
  }) async {
    final dialogTitleWidget = Text(
      dialogTitle,
    );
    final dialogTextWidget = Text(
      dialogText ??
          'You can now update this app from ${versionStatus.localVersion} to ${versionStatus.storeVersion}',
    );

    final updateButtonTextWidget = Text(updateButtonText);

    final actions = <Widget>[
      if (GetPlatform.isAndroid)
        TextButton(
          child: updateButtonTextWidget,
          onPressed: () => updateAction(
              allowDismissal: allowDismissal, versionStatus: versionStatus),
        )
      else
        CupertinoDialogAction(
          child: updateButtonTextWidget,
          onPressed: () => updateAction(
              allowDismissal: allowDismissal, versionStatus: versionStatus),
        ),
    ];

    if (allowDismissal) {
      final dismissButtonTextWidget = Text(
        dismissButtonText,
        style: const TextStyle(
          color: Colors.red,
        ),
      );
      dismissAction = dismissAction ?? () => Get.back();
      actions.add(
        GetPlatform.isAndroid
            ? TextButton(
                onPressed: dismissAction,
                child: dismissButtonTextWidget,
              )
            : CupertinoDialogAction(
                onPressed: dismissAction,
                child: dismissButtonTextWidget,
              ),
      );
    }

    Get.dialog(
      WillPopScope(
          child: GetPlatform.isAndroid
              ? AlertDialog(
                  title: dialogTitleWidget,
                  content: dialogTextWidget,
                  actions: actions,
                )
              : CupertinoAlertDialog(
                  title: dialogTitleWidget,
                  content: dialogTextWidget,
                  actions: actions,
                ),
          onWillPop: () => Future.value(allowDismissal)),
      barrierDismissible: allowDismissal,
    );
  }

  void updateAction(
      {required VersionStatus versionStatus, required bool allowDismissal}) {
    _launchAppStore(versionStatus.appStoreLink);
    if (allowDismissal) {
      Get.back();
    }
  }

  /// Android info is fetched by parsing the html of the app store page.
  Future<VersionStatus?> _getAndroidStoreVersion(
      PackageInfo packageInfo) async {
    try {
      final id = androidId ?? packageInfo.packageName;
      final uri =
          Uri.https('play.google.com', '/store/apps/details', {'id': id});
      final response = await http.get(uri);
      if (response.statusCode != 200) {
        debugPrint('Can\'t find an app in the Play Store with the id: $id');
        return null;
      }
      final document = parse(response.body);

      final additionalInfoElements = document.getElementsByClassName('hAyfc');
      final versionElement = additionalInfoElements.firstWhere(
        (elm) => elm.querySelector('.BgcNfc')!.text == 'Current Version',
      );
      final storeVersion = versionElement.querySelector('.htlgb')!.text;

      final sectionElements = document.getElementsByClassName('W4P4ne');
      final releaseNotesElement = sectionElements.firstWhereOrNull(
        (elm) => elm.querySelector('.wSaTQd')!.text == 'What\'s New',
      );
      final releaseNotes = releaseNotesElement
          ?.querySelector('.PHBdkd')
          ?.querySelector('.DWPxHb')
          ?.text;

      return VersionStatus._(
        localVersion: packageInfo.version,
        storeVersion: storeVersion,
        appStoreLink: uri.toString(),
        releaseNotes: releaseNotes,
      );
    } catch (e) {
      return null;
    }
  }

  /// iOS info is fetched by using the iTunes lookup API, which returns a
  /// JSON document.
  Future<VersionStatus?> _getiOSStoreVersion(PackageInfo packageInfo) async {
    try {
      final id = iOSId ?? packageInfo.packageName;
      final parameters = {'bundleId': id};
      final uri = Uri.https('itunes.apple.com', '/lookup', parameters);
      final response = await http.get(uri);
      if (response.statusCode != 200) {
        debugPrint('Can\'t find an app in the App Store with the id: $id');
        return null;
      }
      final jsonObj = json.decode(response.body);
      return VersionStatus._(
        localVersion: packageInfo.version,
        storeVersion: jsonObj['results'][0]['version'],
        appStoreLink: jsonObj['results'][0]['trackViewUrl'],
        releaseNotes: jsonObj['results'][0]['releaseNotes'],
      );
    } catch (e) {
      return null;
    }
  }

  /// Launches the Apple App Store or Google Play Store page for the app.
  Future<void> _launchAppStore(String appStoreLink) async {
    debugPrint(appStoreLink);
    if (await canLaunch(appStoreLink)) {
      await launch(appStoreLink);
    } else {
      throw 'Could not launch appStoreLink';
    }
  }
}

/// Information about the app's current version, and the most recent version
/// available in the Apple App Store or Google Play Store.
class VersionStatus {
  /// The current version of the app.
  final String localVersion;

  /// The most recent version of the app in the store.
  final String storeVersion;

  /// A link to the app store page where the app can be updated.
  final String appStoreLink;

  /// The release notes for the store version of the app.
  final String? releaseNotes;

  VersionStatus._({
    required this.localVersion,
    required this.storeVersion,
    required this.appStoreLink,
    this.releaseNotes,
  });

  /// True if the there is a more recent version of the app in the store.
  // bool get canUpdate => localVersion.compareTo(storeVersion).isNegative;
  // version strings can be of the form xx.yy.zz (build)
  bool get canUpdate {
    // assume version strings can be of the form xx.yy.zz
    // this implementation correctly compares local 1.10.1 to store 1.9.4
    try {
      final localFields = localVersion.split('.');
      final storeFields = storeVersion.split('.');
      String localPad = '';
      String storePad = '';
      for (int i = 0; i < storeFields.length; i++) {
        localPad = localPad + localFields[i].padLeft(3, '0');
        storePad = storePad + storeFields[i].padLeft(3, '0');
      }
      // debugPrint('new_version canUpdate local $localPad store $storePad');
      if (localPad.compareTo(storePad) < 0) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return localVersion.compareTo(storeVersion).isNegative;
    }
  }
}
