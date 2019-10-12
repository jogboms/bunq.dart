library money;

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:bunq/src/utils/model.dart';
import 'package:bunq/src/utils/serializers.dart';

part 'Money.g.dart';

abstract class Money with ModelInterface implements Built<Money, MoneyBuilder> {
  Money._();

  factory Money([Function(MoneyBuilder b) updates]) = _$Money;

  String get currency;

  String get value;

  @override
  Map<String, dynamic> toMap() => serializers.serializeWith(Money.serializer, this);

  static Money fromJson(Map<String, dynamic> map) => serializers.deserializeWith(Money.serializer, map);

  static Serializer<Money> get serializer => _$moneySerializer;
}
