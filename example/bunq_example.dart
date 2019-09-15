import 'package:bunq/bunq.dart';

main() async {
  Bunq.init(
    apiKey: "sandbox_4e8084e646ce20d5ce30ded6dd1827fedf946209291003057cc63da4",
    production: false,
//    useLogger: true,
  );

  final l = await Installations().install();

  print(l.data);

  final j = await Devices().register(l.data.token.token);

  print(j.data);

  final k = await Sessions().start(l.data.token.token, l.data.id.id);

  print(k.data);
}
