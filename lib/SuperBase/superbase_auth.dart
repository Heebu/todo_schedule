import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_todo/Resueables/show_snack_bar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';



class SuperBaseAuth {
  final supabase = Supabase.instance.client.auth;

  //Sign up with email and password
   signUpAuthEmailPassword(String email, String password, BuildContext context) async{


   if(email.toString().isNotEmpty || password.toString().isNotEmpty || (email.toString().isNotEmpty && password.toString().isNotEmpty)) {
      try {
        final AuthResponse res = await supabase.signUp(
          email: email,
          password: password,
        );
        final Session? session = res.session;
        final User? user = res.user;

        Navigator.pop(context);
      } catch (e) {
        showSnackBar(context, e.toString());

      }
    }else{
     showSnackBar(context, 'Please fill in the text fields');
   }
  }

  //Sign in with email and password
  signInEmailPassword(String email, String password, BuildContext context, Widget routePage) async{
    String result = 'An unexpected error occurred';

    if(email.toString().isNotEmpty || password.toString().isNotEmpty || (email.toString().isNotEmpty && password.toString().isNotEmpty)) {
      try {
        final AuthResponse res = await supabase.signInWithPassword(
          email: email,
          password: password,
        );
        final Session? session = res.session;
        final User? user = res.user;
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => routePage,));
      } catch (e) {
        showSnackBar(context, e.toString());
      }
    }else{
      showSnackBar(context, 'Please fill in the text fields');
    }
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

  //verification otp with email link
  Future<String> verifyOTPLink(String email) async{
    String result = 'An unexpected error occurred';

    if(email.toString().isNotEmpty) {
      try {
        final AuthResponse res = await supabase.verifyOTP(
          type: OtpType.magiclink,
         email: email,
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

  //verification otp (still in progress...)
  Future<String> verifyOTP(String phoneNumber) async{
    String result = 'An unexpected error occurred';

    if(phoneNumber.toString().isNotEmpty || phoneNumber.toString().length >= 12) {
      try {
        final AuthResponse res = await supabase.verifyOTP(
          type: OtpType.magiclink,
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
  forgotPassword(String email, BuildContext context) async{
    if(email.toString().isNotEmpty) {
      try {
         await supabase.resetPasswordForEmail(email);
        Navigator.pop(context);
        showSnackBar(context, 'A reset link has been sent to $email');
      } catch (e) {
        showSnackBar(context, e.toString());
      }
    }else{
      showSnackBar(context, 'Please fill in the text field');
    }
  }

//Sign Out
  signOut(BuildContext context) async{
      try {
        await supabase.signOut();
        Navigator.pop(context);
      } catch (e) {
        showSnackBar(context, e.toString());
    }
  }
}