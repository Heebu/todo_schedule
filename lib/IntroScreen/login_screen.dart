import 'package:flutter/material.dart';
import 'package:my_todo/IntroScreen/signup_screen.dart';
import 'package:my_todo/MainScreen/homepage.dart';
import 'package:my_todo/Resueables/show_snack_bar.dart';
import '../CustomPaint/clock.dart';
import '../Resueables/input_text_field.dart';
import '../SuperBase/superbase_auth.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  State<LogInPage> createState() => _LogInPageState();
}

TextEditingController _email = TextEditingController();
TextEditingController _password = TextEditingController();

class _LogInPageState extends State<LogInPage> {
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
        String result = await SuperBaseAuth().signInEmailPassword(_email.text.trim(), _password.text.trim());
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
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: const Text(
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
                  children: [
                    Text(
                      'Login',
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
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      InputTextField(hint: 'Email', isObscured: false, icons: Icon(Icons.mail), textInputType: TextInputType.emailAddress, controller: _email,),
                      InputTextField(hint: 'Password', isObscured: true, icons: Icon(Icons.password), textInputType: TextInputType.visiblePassword, controller: _password,),
                       ElevatedButton(onPressed: loginAuth, child: Text('Login')),
                      Row(children: [TextButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpPage(),));
                      }, child: Text('Create an account', style: TextStyle(color: Colors.black),)), Spacer(), TextButton(onPressed: (){}, child: Text('Forgot Password?'))],),
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


