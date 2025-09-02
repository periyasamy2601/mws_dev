import 'package:avk/router/path_exporter.dart';

class AccessDeniedView extends StatefulWidget {
  const AccessDeniedView({super.key});

  @override
  State<AccessDeniedView> createState() => _AccessDeniedViewState();
}

class _AccessDeniedViewState extends State<AccessDeniedView> {
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(child: Center(child: Text('Access Denied',style: context.getStyle().displayMedium,)));
  }
}
