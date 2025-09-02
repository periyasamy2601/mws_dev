import 'package:avk/router/path_exporter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class FakeBuildContext extends Fake implements BuildContext {}

class MockValidationHelper extends Mock implements ValidationHelper {}

class MockAppConstants extends Mock implements AppConstants {}

class MockRegexHelper extends Mock implements RegexHelper {}

class MockRouteHelper extends Mock implements RouteHelper {}

class MockNoInternetBloc extends Mock implements NoInternetBloc {}

void main() {
  late MockValidationHelper mockValidationHelper;
  late MockAppConstants mockAppConstants;
  late MockRegexHelper mockRegexHelper;
  late MockRouteHelper mockRouteHelper;
  late MockNoInternetBloc mockNoInternetBloc;

  final GetIt getIt = GetIt.I;

  setUpAll(() {
    registerFallbackValue(FakeBuildContext());
  });

  setUp(() {
    mockValidationHelper = MockValidationHelper();
    mockAppConstants = MockAppConstants();
    mockRegexHelper = MockRegexHelper();
    mockRouteHelper = MockRouteHelper();
    mockNoInternetBloc = MockNoInternetBloc();

    getIt
      ..registerSingleton<ValidationHelper>(mockValidationHelper)
      ..registerSingleton<RegexHelper>(mockRegexHelper)
      ..registerSingleton<RouteHelper>(mockRouteHelper)
      ..registerSingleton<NoInternetBloc>(mockNoInternetBloc)
      ..registerSingleton<AppConstants>(mockAppConstants);

    when(() => mockAppConstants.fieldLimit32).thenReturn(32);
    when(() => mockAppConstants.fieldLimit100).thenReturn(100);
    when(() => mockAppConstants.isAdmin).thenReturn(true);
    when(() => mockRegexHelper.inputPasswordFormatters).thenReturn(<TextInputFormatter>[]);
    when(() => mockRegexHelper.inputEmailFormatters).thenReturn(<TextInputFormatter>[]);
    when(() => mockNoInternetBloc.state).thenReturn(NoInternetInitial());
    when(() => mockNoInternetBloc.stream).thenAnswer((_) => const Stream<NoInternetState>.empty());

    // By default, validators return `null` (no error)
    when(() => mockValidationHelper.emailValidator(any(), any())).thenReturn(null);
    when(() => mockValidationHelper.passwordValidator(any(), any())).thenReturn(null);

  });

  tearDown(getIt.reset);

  Widget createWidgetUnderTest(){
    return BlocProvider<NoInternetBloc>.value(
      value: mockNoInternetBloc,
      child: MaterialApp(
        localizationsDelegates:  const <LocalizationsDelegate<dynamic>>[
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        home: const LoginView(),
      ),
    );
  }

  testWidgets('form validation check for all fields', (WidgetTester tester)async{
    when(() => mockAppConstants.isAdmin).thenReturn(false);
    await tester.pumpWidget(createWidgetUnderTest());

    await tester.enterText(find.widgetWithText(TextFormField, 'Email ID'), 'email');
    // await tester.enterText(find.widgetWithText(Widget, 'Project Name'), 'email');
    await tester.enterText(find.widgetWithText(TextFormField, 'Password'), '');

    await tester.tap(find.text('Log In'));
    await tester.pumpAndSettle();

    // expect(find.text('Please enter your email ID'), findsOne);
    expect(find.text('Please select a project'), findsOne);
    expect(find.text('Please enter a valid email id'), findsOne);
    expect(find.text('Please enter the password'), findsOne);
  });

  testWidgets('check if project name is visible in mobile when not admin', (WidgetTester tester) async {
    when(() => mockAppConstants.isAdmin).thenReturn(false);

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pumpAndSettle();

    expect(find.text('Project Name'), findsOneWidget); // field should be visible
  });


}
