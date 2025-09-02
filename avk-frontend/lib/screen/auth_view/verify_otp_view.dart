import 'dart:async';

import 'package:avk/router/path_exporter.dart';
import 'package:pinput/pinput.dart';

/// A view that handles OTP (One-Time Password) verification.
///
/// This screen is typically shown after the user has initiated
/// a password reset, account registration, or login verification process.
/// It receives a [BaseRouteEntity] to maintain navigation context
/// and pass relevant data between screens.
class VerifyOtpView extends StatefulWidget {
  /// Creates a [VerifyOtpView] with the provided [baseRouteEntity].
  ///
  /// The [baseRouteEntity] is used to carry route-related information
  /// and may be required for completing the OTP verification flow.
  const VerifyOtpView({required this.baseRouteEntity, super.key});

  /// Navigation context and route data for the OTP verification process.
  final BaseRouteEntity baseRouteEntity;

  @override
  State<VerifyOtpView> createState() => _VerifyOtpViewState();
}

class _VerifyOtpViewState extends State<VerifyOtpView> {
  final TextEditingController _otpController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late AuthBloc _authBloc;

  final ValueNotifier<int> _timerNotifier = ValueNotifier(120);

  Timer? _timer;

  @override
  void initState() {
   _setTimer();
    _authBloc = BlocProvider.of(context);
    super.initState();
  }

  void _setTimer() {
     _timer = Timer.periodic(const Duration(seconds: 1), (Timer val){
      if(_timerNotifier.value > 0) {
        _timerNotifier.value = _timerNotifier.value -1;
      }else{
        _timer?.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timerNotifier.dispose();
    _otpController.dispose();
    _formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (BuildContext context, AuthState state) {
        if (state is AuthSuccessState) {
          _handleSuccess(state);
        }
      },
      builder: (BuildContext context, AuthState state) {
        return BaseScaffold(
          child: AuthBaseWidget(
            label: context.getText().verify_otp,
            bottomButtonName: context.getText().verify,
            isBottomButtonLoading:
                state is AuthSuccessState &&
                state.authStateEnum == AuthStateEnum.verifyOtpLoading,
            bottomButtonTap: () => _handleSendOtp(context),
            child: _forgotPasswordView(context, state),
          ),
        );
      },
    );
  }

  Future<void> _handleSendOtp(BuildContext context) async {
    _formKey.currentState?.validate();
    context.read<AuthBloc>().add(
      VerifyOtpEvent(
        emailID: widget.baseRouteEntity.email ?? '',
        otp: _otpController.text,
      ),
    );
  }

  Widget _forgotPasswordView(BuildContext context, AuthState state) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: dimensions.spacingM,
      children: <Widget>[
        appSvg.otpIcon,
        Text(
          context.getText().verify_otp_content,
          style: context.getStyle().labelMedium,
          textAlign: TextAlign.center,
        ),
        Form(
          key: _formKey,
          child: Pinput(
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly,
            ],
            controller:
                _otpController, // Bind the controller to manage the PIN input.
            validator: (String? value) => _validator(
              value,
              state,
            ), // Bind the validator function to validate the PIN.
            autofocus:
                true, // Automatically focus on the PIN input when the screen loads.
            length: 6, // The number of digits in the PIN (6 in this case).
            defaultPinTheme: PinTheme(
              decoration: BoxDecoration(
                border: Border.all(
                  color: context.getColor().onSurface,
                ), // Border color around each PIN digit.
                borderRadius: BorderRadius.circular(
                  dimensions.radiusXS,
                ), // Rounded corners for each PIN digit.
                color:
                    Colors.transparent, // Background color of each PIN field.
              ),
              width: 46, // Width of each PIN input field.
              height: 45, // Height of each PIN input field.
              textStyle: Theme.of(context).textTheme.displayMedium?.copyWith(
                fontSize: 24,
              ), // Customize the text style, here with a larger font size.
            ),
            errorTextStyle: const TextStyle(
              color: Colors.red, // Color of the error text (red in this case).
              fontWeight: FontWeight.w400, // Font weight for the error text.
            ),
            onCompleted: (String value) => unawaited(
              _handleSendOtp(context),
            ), // Trigger the completion callback once the PIN is fully entered.
          ),
        ),
        ValueListenableBuilder<int>(
          valueListenable: _timerNotifier,
          builder: (BuildContext context, int value, Widget? child) {
            return BaseButton(
              onTap: (){
                if(value <= 0){
                  _timer?.cancel();
                  _timerNotifier.value = 10;
                  _setTimer();
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 10,
                children: <Widget>[
                  Text(value <= 0 ? context.getText().dont_receive_otp: context.getText().resend_otp_in,style: context.getStyle().labelMedium,),
                  Text(value <= 0 ? context.getText().resend : value.toString(),style: context.getStyle().labelMedium,),
                ],
              ),
            );
          },
        )
      ],
    );
  }

  String? _validator(String? value, AuthState state) {
    if (state is AuthSuccessState &&
        state.authStateEnum == AuthStateEnum.verifyOtpError) {
      return context.getText().invalid_otp;
    }
    if (state is AuthSuccessState &&
        state.authStateEnum == AuthStateEnum.otpExpireError) {
      return context.getText().otp_expire_error;
    }
    return null;
  }

  void _handleSuccess(AuthSuccessState state) {
    if (<AuthStateEnum>[
      AuthStateEnum.verifyOtpError,
      AuthStateEnum.otpExpireError,
    ].contains(state.authStateEnum)) {
      unawaited(
        Future<dynamic>.delayed(const Duration(milliseconds: 200), () {
          _formKey.currentState?.validate();
          _authBloc.add(ChangeStateEvent());
        }),
      );
    } else if (state.authStateEnum == AuthStateEnum.verifyOtpSuccess) {
      _timer?.cancel();
      unawaited(
        GetIt.I<RouteHelper>().pushReplacementNamed(
          routerKeys.resetPassword,
          widget.baseRouteEntity,
        ),
      );
    }
  }
}
