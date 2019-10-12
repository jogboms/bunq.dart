library account;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:bunq/src/models/Alias.dart';
import 'package:bunq/src/models/Avatar.dart';
import 'package:bunq/src/models/MonetaryAccountProfile.dart';
import 'package:bunq/src/models/Money.dart';
import 'package:bunq/src/models/NotificationFilter.dart';
import 'package:bunq/src/models/SaveId.dart';
import 'package:bunq/src/models/Setting.dart';
import 'package:bunq/src/utils/model.dart';
import 'package:bunq/src/utils/serializers.dart';

part 'Account.g.dart';

abstract class Account with ModelInterface implements Built<Account, AccountBuilder> {
  Account._();

  factory Account([Function(AccountBuilder b) updates]) = _$Account;

  BuiltList<Alias> get alias;

  @nullable
  @BuiltValueField(wireName: "all_auto_save_id")
  BuiltList<SaveId> get allAutoSaveId;

  @nullable
  @BuiltValueField(wireName: "auto_save_id")
  int get autoSaveId;

  Avatar get avatar;

  Money get balance;

  @BuiltValueField(wireName: "connected_cards")
  BuiltList<Object> get connectedCards;

  String get country;

  DateTime get created;

  String get currency;

  @BuiltValueField(wireName: "daily_limit")
  Money get dailyLimit;

  @BuiltValueField(wireName: "daily_spent")
  Money get dailySpent;

  String get description;

  int get id;

  @nullable
  @BuiltValueField(wireName: "monetary_account_profile")
  MonetaryAccountProfile get monetaryAccountProfile;

  @BuiltValueField(wireName: "notification_filters")
  BuiltList<NotificationFilter> get notificationFilters;

  @BuiltValueField(wireName: "overdraft_limit")
  Money get overdraftLimit;

  @BuiltValueField(wireName: "public_uuid")
  String get publicUuid;

  @nullable
  @BuiltValueField(wireName: "savings_goal")
  Money get savingsGoal;

  @nullable
  @BuiltValueField(wireName: "savings_goal_progress")
  String get savingsGoalProgress;

  Setting get setting;

  String get status;

  @BuiltValueField(wireName: "sub_status")
  String get subStatus;

  String get timezone;

  @nullable
  DateTime get updated;

  @BuiltValueField(wireName: "user_id")
  int get userId;

  @override
  Map<String, dynamic> toMap() => serializers.serializeWith(Account.serializer, this);

  static Account fromJson(Map<String, dynamic> map) => serializers.deserializeWith(Account.serializer, map);

  static Serializer<Account> get serializer => _$accountSerializer;
}
