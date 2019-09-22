class Endpoints {
  Endpoints._();

  static const String _base = "v1";

  static const String installations = "$_base/installation";
  static const String devices = "$_base/device-server";
  static const String sessions = "$_base/session-server";
  static const String accounts = "$_base/user/{{ID}}/monetary-account";
  static const String users = "$_base/user";
}
