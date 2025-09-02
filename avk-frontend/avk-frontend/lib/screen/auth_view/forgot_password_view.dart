import 'package:avk/router/path_exporter.dart';

/// A view that handles the "Forgot Password" flow.
///
/// This screen allows the user to initiate the password reset process.
/// It takes a [BaseRouteEntity] to manage routing and navigation details.
class ForgotPasswordView extends StatefulWidget {
  /// Creates a [ForgotPasswordView] with the given [baseRouteEntity].
  ///
  /// [baseRouteEntity] contains routing information for navigating
  /// to and from this view.
  const ForgotPasswordView({required this.baseRouteEntity, super.key});

  /// The route configuration for this view.
  final BaseRouteEntity baseRouteEntity;

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (BuildContext context, AuthState state) {
        if(state is AuthSuccessState) {
          _handleSuccess(state);
        }
      },
      builder: (BuildContext context, AuthState state) {
        return BaseScaffold(
          child: AuthBaseWidget(
            label: context.getText().forgot_password_header,
            bottomButtonName: context.getText().send_otp,
            isBottomButtonLoading: state is AuthSuccessState && state.authStateEnum == AuthStateEnum.sendOtpLoading,
            bottomButtonTap:()=> _handleSendOtp(context),
            child: _forgotPasswordView(context),
          ),
        );
      },
    );
  }

  Future<void> _handleSendOtp(BuildContext context) async {
    context.read<AuthBloc>().add(SendOtpEvent(emailID: widget.baseRouteEntity.email??''));
  }

  Widget _forgotPasswordView(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: dimensions.spacingM,
      children: <Widget>[
        appSvg.otpIcon,
        Text(
          context.getText().forgot_password_content,
          style: context.getStyle().labelMedium,
          textAlign: TextAlign.center,
        ),
        Text(
          widget.baseRouteEntity.email ?? '',
          style: context.getStyle().titleSmall?.copyWith(
            color: context.getColor().primary,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
  void _handleSuccess(AuthSuccessState state) {
    if(state.authStateEnum == AuthStateEnum.sendOtpSuccess){
      unawaited(GetIt.I<RouteHelper>().pushNamed(
        routerKeys.verifyOtp,
        params: BaseRouteEntity(email: widget.baseRouteEntity.email??''),
      ));
    }
  }
}
