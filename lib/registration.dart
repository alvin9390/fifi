import 'package:flutter/material.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  final keyApplicationId = '5fLGQknf4yahCduc47BW0CYKsl8Gzl4AWStpwm1S';
  final keyClientKey = '2Xakaim8KBSLS5UMgYmF6RIkz09oajUsXZzMtnH5';
  final keyParseServerUrl = 'https://parseapi.back4app.com';

  await Parse().initialize(keyApplicationId, keyParseServerUrl, clientKey: keyClientKey, autoSendSessionId: true);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Registration App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: RegistrationPage(),
    );
  }
}

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();

  String _username = '';
  String _password = '';

  Future<void> _registerUser() async {
    final user = ParseUser(_username, _password, _username);
    final response = await user.signUp();

    if (response.success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registration Successful!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registration Failed: ${response.error!.message}')),
      );
    }
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registration'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 50.0),
                Text(
                  'Create an Account',
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 30.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: '이메일',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a username';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _username = value!;
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: '비밀번호',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a password';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _password = value!;
                  },
                ),
                SizedBox(height: 30.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                  ),
                  child: Text('Register', style: TextStyle(fontSize: 18.0)),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      _registerUser();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

