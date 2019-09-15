library serializers;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/iso_8601_date_time_serializer.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:bunq/src/models/Address.dart';
import 'package:bunq/src/models/Alias.dart';
import 'package:bunq/src/models/Avatar.dart';
import 'package:bunq/src/models/BillingContract.dart';
import 'package:bunq/src/models/BillingContractSubscription.dart';
import 'package:bunq/src/models/Customer.dart';
import 'package:bunq/src/models/CustomerLimit.dart';
import 'package:bunq/src/models/DailyLimitWithoutConfirmationLogin.dart';
import 'package:bunq/src/models/Device.dart';
import 'package:bunq/src/models/DocumentAttachment.dart';
import 'package:bunq/src/models/Id.dart';
import 'package:bunq/src/models/Image.dart';
import 'package:bunq/src/models/Installation.dart';
import 'package:bunq/src/models/NotificationFilter.dart';
import 'package:bunq/src/models/ServerPublicKey.dart';
import 'package:bunq/src/models/Session.dart';
import 'package:bunq/src/models/Token.dart';
import 'package:bunq/src/models/UserPerson.dart';

part 'serializers.g.dart';

// ignore: unnecessary_const
@SerializersFor(const [
  Alias,
  Avatar,
  Address,
  BillingContract,
  BillingContractSubscription,
  Customer,
  CustomerLimit,
  DailyLimitWithoutConfirmationLogin,
  DocumentAttachment,
  Image,
  NotificationFilter,
  Token,
  UserPerson,
  Device,
  Session,
  Installation,
  ServerPublicKey,
  Id,
])
final Serializers serializers = (_$serializers.toBuilder()
      ..add(Iso8601DateTimeSerializer())
      ..addPlugin(StandardJsonPlugin()))
    .build();
