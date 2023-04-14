import 'package:supabase_flutter/supabase_flutter.dart';



class SuperBaseAuth {
  final supabase = Supabase.instance.client.auth;

  //Sign up with email and password
  Future<String> signUpAuthEmailPassword(String email, String password) async{
    String result = 'An unexpected error occurred';

   if(email.toString().isNotEmpty || password.toString().isNotEmpty || (email.toString().isNotEmpty && password.toString().isNotEmpty)) {
      try {
        final AuthResponse res = await supabase.signUp(
          email: email,
          password: password,
        );
        final Session? session = res.session;
        final User? user = res.user;

        result = 'Success';
      } catch (e) {
        result = e.toString();
      }
    }else{
     result = 'Please fill in the text fields';
   }
    return result;
  }

  //Sign in with email and password
  Future<String> signInEmailPassword(String email, String password) async{
    String result = 'An unexpected error occurred';

    if(email.toString().isNotEmpty || password.toString().isNotEmpty || (email.toString().isNotEmpty && password.toString().isNotEmpty)) {
      try {
        final AuthResponse res = await supabase.signInWithPassword(
          email: email,
          password: password,
        );
        final Session? session = res.session;
        final User? user = res.user;

        result = 'Success';
      } catch (e) {
        result = e.toString();
      }
    }else{
      result = 'Please fill in the text fields';
    }
    return result;
  }

  //verification with phone number (still in progress...)
  Future<String> verifyPhoneNumber(String phoneNumber) async{
    String result = 'An unexpected error occurred';

    if(phoneNumber.toString().isNotEmpty && phoneNumber.toString().isNotEmpty) {
      try {
       await supabase.signInWithOtp(phone: phoneNumber, shouldCreateUser: true);
        result = 'Success';
      } catch (e) {
        result = e.toString();
      }
    }else{
      result = 'Please fill in the text fields';
    }
    return result;
  }

  //verification otp (still in progress...)
  Future<String> verifyOTP(String phoneNumber) async{
    String result = 'An unexpected error occurred';

    if(phoneNumber.toString().isNotEmpty || phoneNumber.toString().length >= 12) {
      try {
        final AuthResponse res = await supabase.verifyOTP(
          type: OtpType.sms,
          phone: phoneNumber,
          token: '',
        );
        final Session? session = res.session;
        final User? user = res.user;

        result = 'Success';
      } catch (e) {
        result = e.toString();
      }
    }else{
      result = 'Please fill in the text fields';
    }
    return result;
  }

//Forget Password
  Future<String> forgotPassword(String email) async{
    String result = 'An unexpected error occurred';

    if(email.toString().isNotEmpty) {
      try {
         await supabase.resetPasswordForEmail(email);
        result = 'Success';
      } catch (e) {
        result = e.toString();
      }
    }else{
      result = 'Please fill in the text fields';
    }
    return result;
  }

//Sign Out
  Future<String> signOut() async{
    String result = 'An unexpected error occurred';
      try {
         await supabase.signOut();
        result = 'Success';
      } catch (e) {
        result = e.toString();
      }
    return result;
  }


}