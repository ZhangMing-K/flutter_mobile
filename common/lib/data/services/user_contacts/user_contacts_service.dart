import 'dart:convert';
import 'dart:io';

import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../iris_common.dart';

class UserContactService extends GetxService {
  UserContactService();
  IGraphqlProvider iGraphqlProvider = Get.find();

  Future<bool?> userContactSync(
      {required List<UserContactInput> userContacts}) async {
    const document = r'''
        mutation userContactsSync($input: UserContactSyncInput!) {
          userContactsSync(input: $input) {
            success
          }
        }
    ''';

    final args = userContacts.map((UserContactInput contact) => {
          'contactType': describeEnum(contact.contactType!),
          'contactValue': contact.contactValue,
          'firstName': contact.firstName,
          'lastName': contact.lastName
        });
    final Map<String, dynamic> input = {
      'userContacts': [...args]
    };

    final _options = iGraphqlProvider
        .createQueryOptions(document: document, variables: {'input': input});

    try {
      final res = await iGraphqlProvider.queryWithOptions(_options);
      if (res?.hasException ?? false) {
        debugPrint(res.toString());
        throw res!.exception!.linkException!.originalException;
      }

      final data = res?.data;
      if (data == null) {
        throw 'data null';
      }

      final bool? success = data['userContactsSync']['success'];
      return success;
    } catch (err) {
      rethrow;
      // return null;
    }
  }

  Future<bool?> userContactSyncBase64(
      {required List<UserContactInput> userContacts}) async {
    const document = r'''
        mutation userContactsSyncBase64($input: UserContactSyncBase64Input!) {
          userContactsSyncBase64(input: $input) {
            success
          }
        }
    ''';

    final args = userContacts.map((UserContactInput contact) => {
          'contactType': describeEnum(contact.contactType!),
          'contactValue': contact.contactValue,
          'firstName': contact.firstName,
          'lastName': contact.lastName
        });
    final String jsonUser = jsonEncode(args.toList());
    final List<int> bytes = utf8.encode(jsonUser);
    final String base = base64.encode(bytes);
    final Map<String, dynamic> input = {'userContactsBase64': base};

    final _options = iGraphqlProvider
        .createMutationOptions(document: document, variables: {'input': input});

    try {
      final res = await iGraphqlProvider.mutateWithOptions(_options);
      if (res.hasException) {
        throw res.exception?.linkException ??
            res.exception!.graphqlErrors[0].message;
      }
      if (res.data == null) {
        throw 'data null';
      }

      final bool? success = res.data!['userContactsSyncBase64']['success'];
      return success;
    } catch (err) {
      debugPrint(err.toString());
      //rethrow;
      return null;
    }
  }

  Future<UserContact?> sendContactInvite({int? userContactKey}) async {
    const document = r'''
      mutation sendContactInvite($input:UserContactSendInviteInput!) {
        userContactSendInvite(input:$input) {
          userContact{
            contactValue
          }
        }
      }
    ''';

    final Map<String, dynamic> input = {'userContactKey': userContactKey};

    final _options = iGraphqlProvider
        .createQueryOptions(document: document, variables: {'input': input});

    try {
      final res = await iGraphqlProvider.queryWithOptions(_options);
      if (res?.hasException ?? false) {
        debugPrint(res?.exception.toString());
      }

      final data = res?.data;
      if (data == null) {
        return null;
      }

      final contactData = data['userContactSendInvite']['userContact'];

      final UserContact contact = UserContact.fromJson(contactData);
      return contact;
    } catch (err) {
      return null;
    }
  }

  sendMessageToContact(
      {EXTERNAL_USER_CONTACT_TYPE? contactType,
      String? contactValue,
      required String message}) async {
    final String encodedMessage = Uri.encodeFull(message);
    if (contactType == EXTERNAL_USER_CONTACT_TYPE.PHONE) {
      sendSms(contactValue, encodedMessage);
    }

    if (contactType == EXTERNAL_USER_CONTACT_TYPE.EMAIL) {
      sendEmail(contactValue, encodedMessage);
    }
  }

  List<UserContactInput> transformContacts({required List<Contact> contacts}) {
    List<UserContactInput> userContacts = [];

    for (Contact contact in contacts) {
      // if (contact == null) break;

      final List<Item> contactPhones = contact.phones?.toList() ?? [];
      final List<Item> contactEmails = contact.emails?.toList() ?? [];

      for (var phoneNumber in contactPhones) {
        if (phoneNumber.value == null) {
          break;
        }

        final UserContactInput userContact = UserContactInput(
            contactType: EXTERNAL_USER_CONTACT_TYPE.PHONE,
            contactValue: phoneNumber.value,
            firstName: contact.givenName ?? '',
            lastName: contact.familyName ?? '');
        userContacts.add(userContact);
      }

      for (var email in contactEmails) {
        if (email.value == null) break;

        final UserContactInput userContact = UserContactInput(
            contactType: EXTERNAL_USER_CONTACT_TYPE.EMAIL,
            contactValue: email.value,
            firstName: contact.givenName ?? '',
            lastName: contact.familyName ?? '');
        userContacts.add(userContact);
      }
    }
    if (userContacts.length > 500) {
      userContacts = userContacts
          .where((element) =>
              element.contactType == EXTERNAL_USER_CONTACT_TYPE.PHONE)
          .toList();
    }

    return userContacts;
  }

  void call(String number, String encodedBody) {
    if (Platform.isIOS) launch('tel:$number&body=$encodedBody');

    if (Platform.isAndroid) launch('tel:$number?body=$encodedBody');
  }

  void sendSms(String? number, String encodedBody) {
    if (Platform.isIOS) launch('sms:$number&body=$encodedBody');

    if (Platform.isAndroid) launch('sms:$number?body=$encodedBody');
  }

  void sendEmail(String? email, String encodedBody) {
    if (Platform.isIOS) launch('mailto:$email&body=$encodedBody');

    if (Platform.isAndroid) launch('mailto:$email?body=$encodedBody');
  }
}
