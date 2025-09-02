import 'package:avk/main.dart' as runner;
import 'package:avk/router/path_exporter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  String? envValue = '';
  try {
    // initialize dot env with the file name
    await dotenv.load(fileName: 'config');
    // get the `FLUTTER_ENVIRONMENT` value form the config file
    envValue = dotenv.env['FLUTTER_ENVIRONMENT'] ?? 'prod';
  }on Object catch (e) {
    // if any error print the error as log in the console
    logger.errorLog('config Init Exception --> $e');
  }

  // switch case to set the flavor based on config value
  switch (envValue) {
    case 'development':
      F.appFlavor = Flavor.dev;
    case 'stage':
      F.appFlavor = Flavor.stage;
    default:
      F.appFlavor = Flavor.prod;
  }

  unawaited(runner.main());
}
