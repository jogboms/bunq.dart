library customer;

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:bunq/src/utils/model.dart';
import 'package:bunq/src/utils/serializers.dart';

part 'Customer.g.dart';

abstract class Customer with ModelInterface implements Built<Customer, CustomerBuilder> {
  Customer._();

  factory Customer([updates(CustomerBuilder b)]) = _$Customer;

  @BuiltValueField(wireName: 'billing_account_id')
  int get billingAccountId;

  DateTime get created;

  int get id;

  @BuiltValueField(wireName: 'invoice_notification_preference')
  String get invoiceNotificationPreference;

  DateTime get updated;

  @override
  Map<String, dynamic> toMap() => serializers.serializeWith(Customer.serializer, this);

  static Customer fromJson(Map<String, dynamic> map) => serializers.deserializeWith(Customer.serializer, map);

  static Serializer<Customer> get serializer => _$customerSerializer;
}
