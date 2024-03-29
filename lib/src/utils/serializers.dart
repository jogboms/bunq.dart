library serializers;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/iso_8601_date_time_serializer.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:bunq/src/models/Account.dart';
import 'package:bunq/src/models/Address.dart';
import 'package:bunq/src/models/Alias.dart';
import 'package:bunq/src/models/Avatar.dart';
import 'package:bunq/src/models/BillingContract.dart';
import 'package:bunq/src/models/BillingContractSubscription.dart';
import 'package:bunq/src/models/Customer.dart';
import 'package:bunq/src/models/CustomerLimit.dart';
import 'package:bunq/src/models/Device.dart';
import 'package:bunq/src/models/DocumentAttachment.dart';
import 'package:bunq/src/models/Id.dart';
import 'package:bunq/src/models/Image.dart';
import 'package:bunq/src/models/Installation.dart';
import 'package:bunq/src/models/MonetaryAccount.dart';
import 'package:bunq/src/models/MonetaryAccountProfile.dart';
import 'package:bunq/src/models/Money.dart';
import 'package:bunq/src/models/NotificationFilter.dart';
import 'package:bunq/src/models/SaveId.dart';
import 'package:bunq/src/models/ServerPublicKey.dart';
import 'package:bunq/src/models/Session.dart';
import 'package:bunq/src/models/Setting.dart';
import 'package:bunq/src/models/Token.dart';
import 'package:bunq/src/models/User.dart';
import 'package:bunq/src/models/UserPerson.dart';

part 'serializers.g.dart';

@SerializersFor([
  Alias,
  Avatar,
  Address,
  BillingContract,
  BillingContractSubscription,
  Customer,
  CustomerLimit,
  Money,
  Account,
  DocumentAttachment,
  Image,
  NotificationFilter,
  Token,
  User,
  UserPerson,
  Device,
  Session,
  Setting,
  MonetaryAccount,
  MonetaryAccountProfile,
  Installation,
  ServerPublicKey,
  SaveId,
  Id,
])
final Serializers serializers = (_$serializers.toBuilder()
      ..add(Iso8601DateTimeSerializer())
      ..addPlugin(StandardJsonPlugin()))
    .build();
