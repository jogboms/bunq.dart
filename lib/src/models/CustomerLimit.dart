library customerLimit;

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:bunq/src/utils/model.dart';
import 'package:bunq/src/utils/serializers.dart';

part 'CustomerLimit.g.dart';

abstract class CustomerLimit with ModelInterface implements Built<CustomerLimit, CustomerLimitBuilder> {
  CustomerLimit._();

  factory CustomerLimit([updates(CustomerLimitBuilder b)]) = _$CustomerLimit;

  @nullable
  @BuiltValueField(wireName: 'limit_amount_monthly')
  String get limitAmountMonthly;

  @nullable
  @BuiltValueField(wireName: 'limit_card_credit_mastercard')
  int get limitCardCreditMastercard;

  @BuiltValueField(wireName: 'limit_card_debit_maestro')
  int get limitCardDebitMaestro;

  @BuiltValueField(wireName: 'limit_card_debit_maestro_virtual_subscription')
  int get limitCardDebitMaestroVirtualSubscription;

  @BuiltValueField(wireName: 'limit_card_debit_maestro_virtual_total')
  int get limitCardDebitMaestroVirtualTotal;

  @BuiltValueField(wireName: 'limit_card_debit_mastercard')
  int get limitCardDebitMastercard;

  @BuiltValueField(wireName: 'limit_card_debit_mastercard_virtual_subscription')
  int get limitCardDebitMastercardVirtualSubscription;

  @BuiltValueField(wireName: 'limit_card_debit_mastercard_virtual_total')
  int get limitCardDebitMastercardVirtualTotal;

  @BuiltValueField(wireName: 'limit_card_debit_replacement')
  int get limitCardDebitReplacement;

  @BuiltValueField(wireName: 'limit_card_debit_wildcard')
  int get limitCardDebitWildcard;

  @BuiltValueField(wireName: 'limit_card_replacement')
  int get limitCardReplacement;

  @BuiltValueField(wireName: 'limit_card_wildcard')
  int get limitCardWildcard;

  @BuiltValueField(wireName: 'limit_monetary_account')
  int get limitMonetaryAccount;

  @BuiltValueField(wireName: 'limit_monetary_account_remaining')
  int get limitMonetaryAccountRemaining;

  @nullable
  @BuiltValueField(wireName: 'spent_amount_monthly')
  String get spentAmountMonthly;

  @override
  Map<String, dynamic> toMap() => serializers.serializeWith(CustomerLimit.serializer, this);

  static CustomerLimit fromJson(Map<String, dynamic> map) => serializers.deserializeWith(CustomerLimit.serializer, map);

  static Serializer<CustomerLimit> get serializer => _$customerLimitSerializer;
}
