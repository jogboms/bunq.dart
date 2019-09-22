library user;

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:bunq/src/models/Account.dart';
import 'package:bunq/src/models/UserPerson.dart';
import 'package:bunq/src/utils/model.dart';
import 'package:bunq/src/utils/serializers.dart';

part 'User.g.dart';

abstract class User with ModelInterface implements Built<User, UserBuilder> {
  User._();

  factory User([updates(UserBuilder b)]) = _$User;

  @BuiltValueField(wireName: 'UserPerson')
  UserPerson get userPerson;

  @override
  Map<String, dynamic> toMap() => serializers.serializeWith(User.serializer, this);

  static User fromJson(Map<String, dynamic> map) => serializers.deserializeWith(User.serializer, map);

  static Serializer<User> get serializer => _$userSerializer;
}
