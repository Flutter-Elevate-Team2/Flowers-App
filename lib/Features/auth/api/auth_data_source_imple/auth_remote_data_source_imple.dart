import 'package:flowers_app/Features/auth/api/api_client/auth_api.dart';
import 'package:flowers_app/Features/auth/data/auth_data_source_contract/auth_remote_data_source_contract.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/constants/error_strings.dart';
import '../../data/models/forget_password/request/Forget_Password_Request.dart';
import '../../data/models/forget_password/request/Reset_Password_Request.dart';
import '../../data/models/forget_password/request/Verify_Password_Request.dart';
import '../../data/models/forget_password/responce/Forget_Password_Responce.dart';
import '../../data/models/forget_password/responce/Reset_Password_Responce.dart';
import '../../data/models/forget_password/responce/Verify_Password_Responce.dart';
@Injectable(as:AuthRemoteDataSourceContract)
class AuthRemoteDataSourceImple implements AuthRemoteDataSourceContract {
 final  AuthApi _authApi;
  AuthRemoteDataSourceImple(this._authApi);
  @override
  Future<BaseResponse<ForgetPasswordResponce>> forgetPassword(ForgetPasswordRequest request)async {
    try{
      final responce=await _authApi.forgetPassword(request);
      if(responce.message==ErrorStrings.success){
        return SuccessResponse(data: responce);
      }
      else {
        return ErrorResponse(errorMessage:ErrorStrings.firebaseUserNotFound);
      }
    }
     catch(error){
      return ErrorResponse(errorMessage:error.toString());
    }
  }

  @override
  Future<BaseResponse<ResetPasswordResponce>> resetPassword(ResetPasswordRequest request)async {
    try{
      final responce= await _authApi.resetPassword(request);
      if(responce.message==ErrorStrings.success){
        return SuccessResponse(data: responce);
        
      }
      else{
        return ErrorResponse(errorMessage:ErrorStrings.resetCodenotVerified);
      }
    }
    catch (error){
      return ErrorResponse(errorMessage: error.toString());
    }
  }

  @override
  Future<BaseResponse<VerifyPasswordResponce>> verifyPassword(VerifyPasswordRequest request) async{
   try{
     final responce =await _authApi.verifyPassword(request);
     if(responce.status==ErrorStrings.success){
       return SuccessResponse(data: responce);
       
     }
     else {
       return ErrorResponse(errorMessage: ErrorStrings.resetCodeInvalid);
     }
   }
   catch(error){
     return ErrorResponse(errorMessage: error.toString());
   }
  }
}
