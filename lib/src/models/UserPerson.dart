library user_person;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:bunq/src/models/Address.dart';
import 'package:bunq/src/models/Alias.dart';
import 'package:bunq/src/models/Avatar.dart';
import 'package:bunq/src/models/BillingContract.dart';
import 'package:bunq/src/models/Customer.dart';
import 'package:bunq/src/models/CustomerLimit.dart';
import 'package:bunq/src/models/DocumentAttachment.dart';
import 'package:bunq/src/models/Money.dart';
import 'package:bunq/src/models/NotificationFilter.dart';
import 'package:bunq/src/utils/model.dart';
import 'package:bunq/src/utils/serializers.dart';

part 'UserPerson.g.dart';

abstract class UserPerson with ModelInterface implements Built<UserPerson, UserPersonBuilder> {
  UserPerson._();

  factory UserPerson([Function(UserPersonBuilder b) updates]) = _$UserPerson;

  @BuiltValueField(wireName: 'address_main')
  Address get addressMain;

  @BuiltValueField(wireName: 'address_postal')
  Address get addressPostal;

  BuiltList<Alias> get alias;

  Avatar get avatar;

  @BuiltValueField(wireName: 'billing_contract')
  BuiltList<BillingContract> get billingContract;

  @nullable
  @BuiltValueField(wireName: 'country_of_birth')
  String get countryOfBirth;

  DateTime get created;

  Customer get customer;

  @BuiltValueField(wireName: 'customer_limit')
  CustomerLimit get customerLimit;

  @BuiltValueField(wireName: 'daily_limit_without_confirmation_login')
  Money get dailyLimitWithoutConfirmationLogin;

  @BuiltValueField(wireName: 'date_of_birth')
  String get dateOfBirth;

  @BuiltValueField(wireName: 'display_name')
  String get displayName;

  @nullable
  @BuiltValueField(wireName: 'document_back_attachment')
  DocumentAttachment get documentBackAttachment;

  @nullable
  @BuiltValueField(wireName: 'document_country_of_issuance')
  String get documentCountryOfIssuance;

  @nullable
  @BuiltValueField(wireName: 'document_front_attachment')
  DocumentAttachment get documentFrontAttachment;

  @nullable
  @BuiltValueField(wireName: 'document_number')
  String get documentNumber;

  @nullable
  @BuiltValueField(wireName: 'document_status')
  String get documentStatus;

  @nullable
  @BuiltValueField(wireName: 'document_type')
  String get documentType;

  @BuiltValueField(wireName: 'first_name')
  String get firstName;

  @nullable
  @BuiltValueField(wireName: 'flarum_username')
  String get flarumUserPersonname;

  String get gender;

  int get id;

  @nullable
  @BuiltValueField(wireName: 'joint_membership')
  String get jointMembership;

  String get language;

  @BuiltValueField(wireName: 'last_name')
  String get lastName;

  @BuiltValueField(wireName: 'legal_name')
  String get legalName;

  @BuiltValueField(wireName: 'middle_name')
  String get middleName;

  String get nationality;

  @BuiltValueField(wireName: 'notification_filters')
  BuiltList<NotificationFilter> get notificationFilters;

  @nullable
  @BuiltValueField(wireName: 'pack_membership')
  String get packMembership;

  @BuiltValueField(wireName: 'place_of_birth')
  String get placeOfBirth;

  @nullable
  @BuiltValueField(wireName: 'premium_trial')
  String get premiumTrial;

  @BuiltValueField(wireName: 'public_nick_name')
  String get publicNickName;

  @BuiltValueField(wireName: 'public_uuid')
  String get publicUuid;

  String get region;

  @BuiltValueField(wireName: 'session_timeout')
  int get sessionTimeout;

  String get status;

  @BuiltValueField(wireName: 'sub_status')
  String get subStatus;

  @nullable
  @BuiltValueField(wireName: 'tax_resident')
  String get taxResident;

  @nullable
  DateTime get updated;

  @BuiltValueField(wireName: 'version_terms_of_service')
  String get versionTermsOfService;

  @override
  Map<String, dynamic> toMap() => serializers.serializeWith(UserPerson.serializer, this);

  static UserPerson fromJson(Map<String, dynamic> map) => serializers.deserializeWith(UserPerson.serializer, map);

  static Serializer<UserPerson> get serializer => _$userPersonSerializer;
}
