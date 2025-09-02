import 'package:avk/main.dart' as runner;
import 'package:avk/router/path_exporter.dart';

void main() {
  F.appFlavor = Flavor.stage;
  unawaited(runner.main());
}
