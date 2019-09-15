library dailyLimitWithoutConfirmationLogin;

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:bunq/src/utils/model.dart';
import 'package:bunq/src/utils/serializers.dart';

part 'DailyLimitWithoutConfirmationLogin.g.dart';

abstract class DailyLimitWithoutConfirmationLogin
    with ModelInterface
    implements Built<DailyLimitWithoutConfirmationLogin, DailyLimitWithoutConfirmationLoginBuilder> {
  DailyLimitWithoutConfirmationLogin._();

  factory DailyLimitWithoutConfirmationLogin([updates(DailyLimitWithoutConfirmationLoginBuilder b)]) =
      _$DailyLimitWithoutConfirmationLogin;

  String get currency;

  String get value;

  @override
  Map<String, dynamic> toMap() => serializers.serializeWith(DailyLimitWithoutConfirmationLogin.serializer, this);

  static DailyLimitWithoutConfirmationLogin fromJson(Map<String, dynamic> map) =>
      serializers.deserializeWith(DailyLimitWithoutConfirmationLogin.serializer, map);

  static Serializer<DailyLimitWithoutConfirmationLogin> get serializer =>
      _$dailyLimitWithoutConfirmationLoginSerializer;
}
