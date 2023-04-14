import 'package:flutter/material.dart';

import '../CustomPaint/clock.dart';
import '../MainScreen/homepage.dart';
import '../Resueables/input_text_field.dart';
import '../Resueables/show_snack_bar.dart';
import '../SuperBase/superbase_auth.dart';
import 'login_screen.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _email.dispose();
    _password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    loginAuth() async{
      try{
        String result = await SuperBaseAuth().signUpAuthEmailPassword(_email.text.trim(), _password.text.trim());
        if(result == 'Success'){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyHomePage(),));
        }else{
          showSnackBar(context, result);
        }
      }catch(e){
        showSnackBar(context, e.toString());
      }
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             const SizedBox(
                height: 50,
              ),
              const Padding(
                padding:  EdgeInsets.all(10.0),
                child: Text(
                  'Todo Schedule',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                height: 200,
                width: 200,
                color: Colors.transparent,
                child: const CustomPaint(child: ClockView()),
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                child: Row(
                  children: const [
                    Text(
                      'Create an account',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer()
                  ],
                ),
              ),
              Center(
                child: Container(
                  height: 300,
                  width: 350,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      InputTextField(hint: 'Email', isObscured: false, icons: Icon(Icons.mail), textInputType: TextInputType.emailAddress, controller: _email,),
                      InputTextField(hint: 'Password', isObscured: true, icons: Icon(Icons.password), textInputType: TextInputType.visiblePassword, controller: _password,),
                      ElevatedButton(onPressed: loginAuth, child: const Text('Sign Up')),
                      Row(children: [Spacer(), TextButton(onPressed: (){}, child: Text('Sign up with phone number'))],),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
