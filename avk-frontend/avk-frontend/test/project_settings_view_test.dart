import 'package:avk/router/path_exporter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class FakeBuildContext extends Fake implements BuildContext {}

class MockValidationHelper extends Mock implements ValidationHelper {}

class MockAppConstants extends Mock implements AppConstants {}

class MockRegexHelper extends Mock implements RegexHelper {}

class MockRouteHelper extends Mock implements RouteHelper {}

class MockNoInternetBloc extends Mock implements NoInternetBloc {}

class MockProjectSettingsBloc extends Mock implements ProjectSettingsBloc {}

void main() {
  late MockValidationHelper mockValidationHelper;
  late MockAppConstants mockAppConstants;
  late MockRegexHelper mockRegexHelper;
  late MockRouteHelper mockRouteHelper;
  late MockNoInternetBloc mockNoInternetBloc;
  late MockProjectSettingsBloc mockProjectSettingsBloc;

  final GetIt getIt = GetIt.instance;

  setUpAll(() {
    registerFallbackValue(FakeBuildContext());
  });

  setUp(() {
    mockValidationHelper = MockValidationHelper();
    mockAppConstants = MockAppConstants();
    mockRegexHelper = MockRegexHelper();
    mockRouteHelper = MockRouteHelper();
    mockNoInternetBloc = MockNoInternetBloc();
    mockProjectSettingsBloc = MockProjectSettingsBloc();

    getIt
      ..registerSingleton<ValidationHelper>(mockValidationHelper)
      ..registerSingleton<AppConstants>(mockAppConstants)
      ..registerSingleton<RegexHelper>(mockRegexHelper)
      ..registerSingleton<RouteHelper>(mockRouteHelper)
      ..registerSingleton<ProjectSettingsBloc>(mockProjectSettingsBloc)
      ..registerSingleton<NoInternetBloc>(mockNoInternetBloc);

    // Provide reasonable defaults
    when(() => mockAppConstants.fieldLimit32).thenReturn(32);
    when(
      () => mockRegexHelper.inputPasswordFormatters,
    ).thenReturn(<TextInputFormatter>[]);
    when(() => mockNoInternetBloc.state).thenReturn(NoInternetInitial());
    when(() => mockProjectSettingsBloc.state).thenReturn(
      ProjectSettingsResponseState(
        stateEnum: ProjectSettingsStateEnum.success,
        projectSettingsEntity: ProjectSettingsEntity(),
        roleList: const <RoleEntity>[],
        zoneList: const <TreeNode<UserName>>[],
      ),
    );

    when(() => mockProjectSettingsBloc.stream).thenAnswer(
          (_) => Stream.value(
        ProjectSettingsResponseState(
          stateEnum: ProjectSettingsStateEnum.success,
          projectSettingsEntity: ProjectSettingsEntity()..id = 'has_id',
          roleList: const <RoleEntity>[],
          zoneList: const <TreeNode<UserName>>[],
        ),
      ),
    );

    // By default, validators return `null` (no error)
    when(
      () => mockValidationHelper.checkIsEmptyValidator(any(), any(), any()),
    ).thenReturn(null);
    when(
      () => mockValidationHelper.registrationConfirmPasswordValidator(
        any(),
        any(),
        any(),
      ),
    ).thenReturn(null);
  });

  tearDown(getIt.reset);

  Widget createWidgetUnderTest() {
    return BlocProvider<ProjectSettingsBloc>.value(
      value: mockProjectSettingsBloc,
      child: BlocProvider<NoInternetBloc>.value(
        value: mockNoInternetBloc,
        child: MaterialApp(
          localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          home: const ProjectSettingsView(),
        ),
      ),
    );
  }

  testWidgets('project_details validation', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(createWidgetUnderTest());

    await tester.enterText(
      find.widgetWithText(TextFormField, 'Project Name'),
      '1',
    );
    final Finder submitButtonFinder = find.byKey(
      const Key('project_details_submit_button'),
    );
    await tester.tap(submitButtonFinder);
    await tester.pumpAndSettle();

    // Expect no validation errors
    // expect(find.text('This field is required'), findsNWidgets(2));
    expect(find.text('Project name must have at least 2 characters'), findsOne);
  });
  testWidgets('units  validation', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(createWidgetUnderTest());


    await tester.enterText(
      find.byKey(const Key('pressure_min_range'),),
      '',
    );
    await tester.enterText(
      find.byKey(const Key('pressure_max_range'),),
      '',
    );
    await tester.enterText(
      find.byKey(const Key('level_min_range'),),
      '',
    );
    await tester.enterText(
      find.byKey(const Key('level_max_range'),),
      '',
    );
    await tester.enterText(
      find.byKey(const Key('chlorine_min_range'),),
      '',
    );
    await tester.enterText(
      find.byKey(const Key('chlorine_max_range'),),
      '',
    );
    await tester.ensureVisible(find.byKey(const Key('units_submit_button')));
    final Finder submitButtonFinder = find.byKey(
      const Key('units_submit_button'),
    );
    await tester.tap(submitButtonFinder);
    await tester.pumpAndSettle();

    // Expect no validation errors
    // expect(find.text('This field is required'), findsNWidgets(2));
    expect(find.text('Please enter a value'), findsNWidgets(6));
  });
}
