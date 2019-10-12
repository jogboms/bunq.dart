library billing_contract_subscription;

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:bunq/src/utils/model.dart';
import 'package:bunq/src/utils/serializers.dart';

part 'BillingContractSubscription.g.dart';

abstract class BillingContractSubscription
    with ModelInterface
    implements Built<BillingContractSubscription, BillingContractSubscriptionBuilder> {
  BillingContractSubscription._();

  factory BillingContractSubscription([Function(BillingContractSubscriptionBuilder b) updates]) =
      _$BillingContractSubscription;

  @nullable
  @BuiltValueField(wireName: 'contract_date_end')
  DateTime get contractDateEnd;

  @nullable
  @BuiltValueField(wireName: 'contract_date_start')
  DateTime get contractDateStart;

  @BuiltValueField(wireName: 'contract_version')
  int get contractVersion;

  DateTime get created;

  int get id;

  String get status;

  @BuiltValueField(wireName: 'sub_status')
  String get subStatus;

  @BuiltValueField(wireName: 'subscription_type')
  String get subscriptionType;

  @BuiltValueField(wireName: 'subscription_type_downgrade')
  String get subscriptionTypeDowngrade;

  @nullable
  DateTime get updated;

  @override
  Map<String, dynamic> toMap() => serializers.serializeWith(BillingContractSubscription.serializer, this);

  static BillingContractSubscription fromJson(Map<String, dynamic> map) =>
      serializers.deserializeWith(BillingContractSubscription.serializer, map);

  static Serializer<BillingContractSubscription> get serializer => _$billingContractSubscriptionSerializer;
}
