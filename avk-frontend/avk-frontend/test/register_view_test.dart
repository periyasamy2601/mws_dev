import 'package:avk/router/path_exporter.dart'; // Adjust this to your real import
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Fake & Mock Classes
class FakeBuildContext extends Fake implements BuildContext {}
class MockValidationHelper extends Mock implements ValidationHelper {}
class MockAppConstants extends Mock implements AppConstants {}
class MockRegexHelper extends Mock implements RegexHelper {}
class MockDialogHelper extends Mock implements DialogHelper {}
class MockRouteHelper extends Mock implements RouteHelper {}
class MockNoInternetBloc extends Mock implements NoInternetBloc {}

void main() {
  late MockValidationHelper mockValidationHelper;
  late MockAppConstants mockAppConstants;
  late MockRegexHelper mockRegexHelper;
  late MockDialogHelper mockDialogHelper;
  late MockRouteHelper mockRouteHelper;
  late MockNoInternetBloc mockNoInternetBloc;

  final GetIt getIt = GetIt.instance;

  setUpAll(() {
    registerFallbackValue(FakeBuildContext());
    registerFallbackValue(countries.firstWhere((Country c) => c.code == 'IN'));
  });

  setUp(() {
    mockValidationHelper = MockValidationHelper();
    mockAppConstants = MockAppConstants();
    mockRegexHelper = MockRegexHelper();
    mockDialogHelper = MockDialogHelper();
    mockRouteHelper = MockRouteHelper();
    mockNoInternetBloc = MockNoInternetBloc();

    getIt..registerSingleton<ValidationHelper>(mockValidationHelper)
    ..registerSingleton<AppConstants>(mockAppConstants)
    ..registerSingleton<RegexHelper>(mockRegexHelper)
    ..registerSingleton<DialogHelper>(mockDialogHelper)
    ..registerSingleton<RouteHelper>(mockRouteHelper)
    ..registerSingleton<NoInternetBloc>(mockNoInternetBloc);

    // Provide reasonable defaults
    when(() => mockAppConstants.fieldLimit32).thenReturn(32);
    when(() => mockAppConstants.fieldLimit100).thenReturn(100);
    when(() => mockRegexHelper.inputTextFormatters).thenReturn(<TextInputFormatter>[]);
    when(() => mockRegexHelper.organizationTextFormatters).thenReturn(<TextInputFormatter>[]);
    when(() => mockRegexHelper.inputMobileNumberFormatters).thenReturn(<TextInputFormatter>[]);
    when(() => mockRegexHelper.inputPasswordFormatters).thenReturn(<TextInputFormatter>[]);
    when(() => mockNoInternetBloc.state).thenReturn(NoInternetInitial());
    when(() => mockNoInternetBloc.stream).thenAnswer((_) => const Stream<NoInternetState>.empty());

    // By default, validators return `null` (no error)
    when(() => mockValidationHelper.firstNameValidator(any(), any())).thenReturn(null);
    when(() => mockValidationHelper.organizationValidator(any(), any())).thenReturn(null);
    when(() => mockValidationHelper.designationValidator(any(), any())).thenReturn(null);
    when(() => mockValidationHelper.checkIsEmptyValidator(any(), any(), any())).thenReturn(null);
    when(() => mockValidationHelper.registrationConfirmPasswordValidator(any(), any(), any())).thenReturn(null);
    when(() => mockDialogHelper.showRegisterSuccessDialog(any(), any())).thenAnswer((_) async => true);
  });

  tearDown(getIt.reset);

  Widget createWidgetUnderTest() {
    return BlocProvider<NoInternetBloc>.value(
      value: mockNoInternetBloc,
      child: MaterialApp(
        localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        home: const RegisterView(),
      ),
    );
  }

  testWidgets('form validates successfully when all fields are filled', (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest());

    // Fill in all required fields
    await tester.enterText(find.widgetWithText(TextFormField, 'First Name'), 'Jo');
    await tester.enterText(find.widgetWithText(TextFormField, 'Mobile Number'), '9345591179');
    // await tester.enterText(find.widgetWithText(TextFormField, 'Organisation Name'), 'OpenAI');
    // await tester.enterText(find.widgetWithText(TextFormField, 'Designation'), 'Engineer');
    await tester.enterText(find.widgetWithText(TextFormField, 'New Password'), 'pass1234');
    await tester.enterText(find.widgetWithText(TextFormField, 'Confirm Password'), 'pass134');

    // Submit the form
    await tester.tap(find.text('Save & Continue'));
    await tester.pumpAndSettle();

    // Make sure no error messages appear
    expect(find.text('This field is required'), findsNWidgets(2));
    expect(find.text('First Name must have at least 3 characters'), findsOne);
    expect(find.text('Passwords do not match'), findsOne);
  });
  testWidgets('form submits successfully when all validations pass', (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest());

    await tester.enterText(find.widgetWithText(TextFormField, 'First Name'), 'John');
    await tester.enterText(find.widgetWithText(TextFormField, 'Organisation Name'), 'OpenAI');
    await tester.enterText(find.widgetWithText(TextFormField, 'Mobile Number'), '9345591179');
    await tester.enterText(find.widgetWithText(TextFormField, 'Designation'), 'Engineer');
    await tester.enterText(find.widgetWithText(TextFormField, 'New Password'), 'pass1234');
    await tester.enterText(find.widgetWithText(TextFormField, 'Confirm Password'), 'pass1234');

    await tester.tap(find.text('Save & Continue'));
    await tester.pumpAndSettle();

    verify(() => mockDialogHelper.showRegisterSuccessDialog(any(), any())).called(1);
  });
}
