import 'package:flutter/material.dart';
import 'registration.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'pagr_one.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final keyApplicationId = '5fLGQknf4yahCduc47BW0CYKsl8Gzl4AWStpwm1S';
  final keyClientKey = '2Xakaim8KBSLS5UMgYmF6RIkz09oajUsXZzMtnH5';
  final keyParseServerUrl = 'https://parseapi.back4app.com';

  await Parse().initialize(keyApplicationId, keyParseServerUrl,
      clientKey: keyClientKey, autoSendSessionId: true);

  var firstObject = ParseObject('FirstClass')
    ..set(
        'message', 'Hey ! First message from Flutter. Parse is now connected');
  await firstObject.save();

  print('done');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Parse Server Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();
  String _username = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bond_Ex'),
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
                  'P2P 채권거래 플랫폼',
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 50.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your username';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _username = value!;
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your password';
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
                  child: Text('Login', style: TextStyle(fontSize: 18.0)),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();

                      final user = ParseUser(_username, _password, '');
                      final response = await user.login();

                      if (response.success) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Login Successful!')),
                        );
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => Pagr_One()),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(
                                  'Login Failed: ${response.error!.message}')),
                        );
                      }
                    }
                  },
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                  ),
                  child: Text('Go to Registration',
                      style: TextStyle(fontSize: 18.0)),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RegistrationPage()),
                    );
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

class Pagr_One extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pagr_One'), // 페이지의 타이틀을 설정할 수 있습니다.
      ),
      body: Center(
        child: Text('Welcome to Pagr_One!'),
      ),
    );
  }
}