# mobile_app
mobile app for sample flutter

## Upload to Google Playstore
Build for prod use this command to create app bundle to deploy to google play store
```
flutter build appbundle --flavor prod --dart-define=flavor=prod
```


## Build Android
Make sure Android Studio is installed.
If you're using VS Code, install the Flutter extension it should automatically install the Dart extension.

![vs-code-flutter](https://user-images.githubusercontent.com/22156330/157772952-0505e235-1059-4af3-8536-b69c7c8980e6.png)

Make sure the Flutter SDK is added to your PATH.

For Windows:

![add-flutter-to-path](https://user-images.githubusercontent.com/22156330/157772821-c73bf99a-4e5a-4884-ac33-baaafbd675f1.png)

For Mac:

&lt;placeholder&gt;

Using the SDK Manager for Android Studio, add the following tools:

![install-command-line](https://user-images.githubusercontent.com/22156330/157773042-636f84de-e769-40b0-9f86-90c269d9faf6.png)

From the repo in a terminal window run `flutter doctor`:

![image](https://user-images.githubusercontent.com/22156330/157773211-eb7b7135-34ba-4702-a6a8-fbfeaf86a3e4.png)

You might need to accept the Android licenses, in which case run `flutter doctor --android-licenses` and then accept all of the license prompts


Open the Virtual Device Manager from Android Studio, create a new virtual device and launch it:

![image](https://user-images.githubusercontent.com/22156330/157773564-50c465c3-c173-4ec3-83f6-66d5ae93b514.png)

In the common, and mobile_app folders, run the `flutter pub get` command to restore packages.


From the VS Code debugger, select the appropriate build target and click the run button:

![image](https://user-images.githubusercontent.com/22156330/157773824-a1bebc0d-3019-45a6-9ea4-86745729b5f2.png)



## Build IOS

```
flutter build ipa  --bundle-sksl-path flutter_01.sksl.json --flavor prod --dart-define=flavor=prod
```

```
fvm flutter build ipa  --bundle-sksl-path flutter_01.sksl.json --flavor prod --dart-define=flavor=prod
```

## Build SKSL
```
flutter run --profile --cache-sksl --purge-persistent-cache --flavor prod --dart-define=flavor=prod
```

