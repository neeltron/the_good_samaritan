import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';

Future<Album> createAlbum(String title, heading, desc, reward) async {
  final response = await http.get(
    Uri.parse('https://the-good-samaritan-api.neeltron.repl.co/input?name='+title+'&heading='+heading+'&desc='+desc+'&reward='+reward),
  );
  print(response.body);
  if (response.statusCode == 200) {
    return Album.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to create album.');
  }
}
Future<Album> fetchAlbum() async {
  final response = await http
      .get(Uri.parse('https://the-good-samaritan-api.neeltron.repl.co/output'));

  if (response.statusCode == 200) {
    return Album.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load album');
  }
}

class Album {
  final String name;
  final String heading;
  final String desc;
  final String reward;

  Album({required this.name, required this.heading, required this.desc, required this.reward});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      name: json['name'],
      heading: json['heading'],
      desc: json['desc'],
      reward: json['reward'],
    );
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'The Good Samaritan',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(title: 'The Good Samaritan'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class SecondRoute extends StatelessWidget {
  const SecondRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("The Good Samaritan"),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.all(25),
              child: FlatButton(
                child: const Text('I\'m a Volunteer', style: TextStyle(fontSize: 20.0),),
                color: Colors.green,
                textColor: Colors.white,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const VolunteerRoute()),
                  );
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.all(25),
              child: FlatButton(
                child: const Text('I\'m Looking for Volunteers', style: TextStyle(fontSize: 20.0),),
                color: Colors.green,
                textColor: Colors.white,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FindVolunteerForm()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class VolunteerRoute extends StatelessWidget {
  const VolunteerRoute({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("The Good Samaritan"),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            Image.asset('assets/vol.png'),
            const ListTile(
              leading: Icon(Icons.album),
              title: Text('Help us Plant 1000 Trees'),
              subtitle: Text('We will be gathering near the central park to plant 1000 trees.\nReward: Tee and Environment Swag'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                const SizedBox(width: 8),
                TextButton(
                  child: const Text('Volunteer!'),
                  onPressed: () { fetchAlbum(); },
                ),
                const SizedBox(width: 8),
              ],
            ),
            Image.asset('assets/vol.png'),
            const ListTile(
              leading: Icon(Icons.album),
              title: Text('Help me move to the nearby apartment'),
              subtitle: Text('I need help to move heavy things in a nearby apartment.\nReward: \$25'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                const SizedBox(width: 8),
                TextButton(
                  child: const Text('Volunteer!'),
                  onPressed: () { fetchAlbum(); },
                ),
                const SizedBox(width: 8),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class FindVolunteerForm extends StatelessWidget {
  const FindVolunteerForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Find Volunteers';
    return MaterialApp(
      title: appTitle,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text(appTitle),
        ),
        body: const MyCustomForm(),
      ),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  const MyCustomForm({Key? key}) : super(key: key);

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  final TextEditingController _controller3 = TextEditingController();
  final TextEditingController _controller4 = TextEditingController();
  Future<Album>? _futureAlbum;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          TextFormField(
              controller: _controller,
              decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Entity Name',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _controller2,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Heading',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          TextFormField(
            maxLines: 8,
            controller: _controller3,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Work Description',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _controller4,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Reward',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Processing Data')),
                  );
                  setState(() {
                    _futureAlbum = createAlbum(_controller.text, _controller2.text, _controller3.text, _controller4.text);
                  });
                }
              },
              child: const Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
  FutureBuilder<Album> buildFutureBuilder() {
    return FutureBuilder<Album>(
      future: _futureAlbum,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(snapshot.data!.name);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return const CircularProgressIndicator();
      },
    );
  }
}



class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Username',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(25),
              child: FlatButton(
                child: const Text('Log in', style: TextStyle(fontSize: 20.0),),
                color: Colors.green,
                textColor: Colors.white,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SecondRoute()),
                  );
                },
              ),
            ),

          ],
        ),
      ),

    );
  }
}
