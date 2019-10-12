library monetary_account;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:bunq/src/models/Account.dart';
import 'package:bunq/src/utils/model.dart';
import 'package:bunq/src/utils/serializers.dart';

part 'MonetaryAccount.g.dart';

abstract class MonetaryAccount with ModelInterface implements Built<MonetaryAccount, MonetaryAccountBuilder> {
  MonetaryAccount._();

  factory MonetaryAccount([Function(MonetaryAccountBuilder b) updates]) = _$MonetaryAccount;

  @BuiltValueField(wireName: 'MonetaryAccountBank')
  BuiltList<Account> get banks;

  @BuiltValueField(wireName: 'MonetaryAccountSavings')
  BuiltList<Account> get savings;

  @override
  Map<String, dynamic> toMap() => serializers.serializeWith(MonetaryAccount.serializer, this);

  static MonetaryAccount fromJson(Map<String, dynamic> map) =>
      serializers.deserializeWith(MonetaryAccount.serializer, map);

  static Serializer<MonetaryAccount> get serializer => _$monetaryAccountSerializer;
}
