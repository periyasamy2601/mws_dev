import 'package:avk/router/path_exporter.dart';

/// Handles authentication-related operations.
///
/// This controller extends [AuthServices] to use its API methods
/// and adds logic specific to authentication state and validation.
class AuthController extends AuthServices {

  /// login using project id email and password
  Future<MetaEntity?> loginController(Map<String,dynamic> body)async{
    final MetaEntity response =  await loginRepo(body);
    if(_isSuccessState(response)){
      return response;
    }else{
      return null;
    }
  }


 /// register a user using given details
  Future<bool> registerOrResetPasswordController(Map<String,dynamic> body)async{
    final MetaEntity response =  await registerOrResetPasswordService(body);
    if(_isSuccessState(response)){
      return response.error == null;
    }else{
      return false;
    }
  }

 ///validate user based on email and project
  Future<MetaEntity?> validateUserController(Map<String,dynamic> body)async{
    final MetaEntity response =  await validateUserService(body);
    if(_isSuccessState(response)){
      return response;
    }else{
      return null;
    }
  }

 ///send otp to user email id
  Future<bool> sendOtpController(Map<String,dynamic> body)async{
    final MetaEntity response =  await sendOtpService(body);
    if(_isSuccessState(response)){
      return response.error == null;
    }else{
      return false;
    }
  }

 ///verify the otp we send to the user email
  Future<MetaEntity?> verifyOtpController(Map<String,dynamic> body)async{
    final MetaEntity response =  await verifyOtpService(body);
    if(_isSuccessState(response)){
      return response;
    }else{
      return null;
    }
  }


  /// Checks if a given statusCode] represents a success response.
  ///
  /// Considers HTTP 200 (OK) and 201 (Created) as successful responses.
  bool _isSuccessState(MetaEntity response) => <int>[200, 201,404,400].contains(response.statusCode);
}
