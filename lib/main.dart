import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      //home: const MyHomePage(title: 'Flutter Demo Home Page'),
      //home: MyDynamicWidget(),
      //home: Test(),
      home: ProfilePage(),
    );
  }
}

class MyDynamicWidget extends StatefulWidget {
  @override
  MyDynamicWidgetState createState() => MyDynamicWidgetState();
}

class MyDynamicWidgetState extends State<MyDynamicWidget> {
  int counter = 0;

  void _incrementCounter() {
    setState(() {
      counter++;
    });
  }

  void _resetCounter() {
    setState(() {
      counter = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 150),
        Text('Counter: $counter'),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: _incrementCounter,
          child: Text('Increment'),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: _resetCounter,
          child: Text('Reset'),
        ),
      ],
    );
  }
}

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  TestState createState() => TestState();
}

class TestState extends State<Test> {
  Color backgroundColor = Colors.red;

  Map<String, bool> sportList = {
    "Football": false,
    "Basketball": false,
    "Tennis": false,
    "Handball": false,
    "Volleyball": false,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 150, right: 20, left: 20),
        child: generateCheckList(),
      ),
    );
  }

  Widget generateCheckList() {
    List<Widget> widgetSportList = [];

    sportList.forEach((label, value) {
      Widget rowItem = Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(label),
          Checkbox(
              value: value,
              onChanged: ((newValue) => setState(() {
                    sportList[label] = newValue ?? false;
                  })))
        ],
      );

      widgetSportList.add(rowItem);
    });

    return Column(children: widgetSportList);
  }
}

class Profile {
  String firstName;
  String lastName;
  int? age;
  double height;
  Gender gender;
  List<String> hobbies;
  String favoriteProgrammingLanguage;
  String secret;

  Profile({
    this.firstName = "",
    this.lastName = "",
    this.age,
    this.height = 0.0,
    this.gender = Gender.male,
    this.hobbies = const [],
    this.favoriteProgrammingLanguage = "",
    this.secret = "",
  });
}

enum Gender { male, female }

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  final ImagePicker picker = ImagePicker();
  XFile? image;
  List<int> ageList = List<int>.generate(150, (int index) => index);
  bool _isObscure = true;
  int _groupValue = 0;

  Future<void> pickImage(ImageSource source) async {
    try {
      final pickedFile = await picker.pickImage(source: source);
      if (pickedFile != null) {
        setState(() {
          image = pickedFile;
        });
      }
    } catch (e) {
      print('Error occurred while picking image: $e');
    }
  }

  Profile profile = Profile(firstName: "", lastName: "", secret: "", hobbies: []);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "Profile page",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(children: <Widget>[
            Card(
              clipBehavior: Clip.antiAlias,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                      leading: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 2,
                            color: Colors.pink,
                          ),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: CircleAvatar(
                          backgroundImage: FileImage(File(image?.path ?? "")),
                        ),
                      ),
                      title: Text(
                        profile.firstName + ' ' + profile.lastName,
                        // Utilisation de la variable firstName
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      trailing: Text(
                        profile.age.toString() + '/yo',
                        // Utilisation de la variable firstName
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Icon(
                          profile.gender == Gender.male
                              ? Icons.male
                              : Icons.female,
                          color: Colors.black,
                        ),
                        SizedBox(width: 10),
                        Text(profile.gender == Gender.male ? 'Homme' : 'Femme'),
                      ],
                    ),
                    const Row(
                      children: <Widget>[
                        Icon(
                          Icons.height,
                          color: Colors.black,
                        ),
                        SizedBox(width: 10),
                        Text('200cm'),
                      ],
                    ),
                    const Row(
                      children: <Widget>[
                        Icon(
                          Icons.sports_basketball_outlined,
                          color: Colors.black,
                        ),
                        SizedBox(width: 10),
                        Text('Basket'),
                      ],
                    ),
                    const Row(
                      children: <Widget>[
                        Icon(
                          Icons.code,
                          color: Colors.black,
                        ),
                        SizedBox(width: 10),
                        Text('Vue.Js'),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        const Icon(
                          Icons.fingerprint,
                          color: Colors.black,
                        ),
                        SizedBox(width: 10),
                        Text(
                          _isObscure ? '********' : profile.secret,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () => pickImage(ImageSource.camera),
                              child: const Icon(
                                Icons.browse_gallery,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () => pickImage(ImageSource.gallery),
                              child: const Icon(
                                Icons.camera_alt,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            },
                            child: const Text(
                              'Hide my secret',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Center(
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Prénom',
                ),
                onChanged: (value) => setState(() {
                  profile.firstName = value;
                }),
              ),
            ),
            Center(
              child: TextField(
                decoration: const InputDecoration(
                  labelText: 'Nom',
                ),
                onChanged: (value) => setState(() {
                  profile.lastName = value;
                }),
              ),
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Select your age: '),
                  DropdownButton<int>(
                    items: ageList.map((int value) {
                      return DropdownMenuItem<int>(
                        value: value,
                        child: Text(value.toString()),
                      );
                    }).toList(),
                    onChanged: (int? newValue) {
                      // Add your onChanged logic here
                      setState(() {
                        profile.age = newValue;
                      });
                    },
                    hint: Text('Select Age'),
                  ),
                ],
              ),
            ),
            Center(
              child: TextField(
                obscureText: _isObscure,
                decoration: InputDecoration(
                    labelText: 'Password',
                    // this button is used to toggle the password visibility
                    suffixIcon: IconButton(
                        icon: Icon(_isObscure
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            _isObscure = !_isObscure;
                          });
                        })),
                onChanged: (value) => setState(() {
                  profile.secret = value;
                }),
              ),
            ),
            SizedBox(height: 20),
            Center(
                child: Column(children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  child: Text("I'm …",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      )),
                ),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: RadioListTile<Gender>(
                      value: Gender.male,
                      title: Text("Male"),
                      groupValue:
                          _groupValue == 0 ? Gender.male : Gender.female,
                      onChanged: (Gender? value) {
                        setState(() {
                          _groupValue = value == Gender.male ? 0 : 1;
                          profile.gender = value!;
                        });
                      },
                      activeColor: Colors.lightBlue[900],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: RadioListTile<Gender>(
                      value: Gender.female,
                      title: Text("Female"),
                      groupValue:
                          _groupValue == 1 ? Gender.female : Gender.male,
                      onChanged: (Gender? value) {
                        setState(() {
                          _groupValue = value == Gender.male ? 0 : 1;
                          profile.gender = value!;
                        });
                      },
                      activeColor: Colors.lightBlue[900],
                    ),
                  ),
                ],
              ),
            ])),
            const SizedBox(height: 20),
            Center(
                child: Column(children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  child: const Text("I like to …",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      )),
                ),
              ),
              Column(
                children: <Widget>[
                  CheckboxListTile(
                    title: const Text("Play football"),
                    value: profile.hobbies.contains("Play football"),
                    onChanged: (bool? value) {
                      setState(() {
                        if (value!) {
                          profile.hobbies.add("Play football");
                        } else {
                          profile.hobbies.remove("Play football");
                        }
                      });
                    },
                    activeColor: Colors.lightBlue[900],
                  ),
                  CheckboxListTile(
                    title: const Text("Play basketball"),
                    value: profile.hobbies.contains("Play basketball"),
                    onChanged: (bool? value) {
                      setState(() {
                        if (value!) {
                          profile.hobbies.add("Play basketball");
                        } else {
                          profile.hobbies.remove("Play basketball");
                        }
                      });
                    },
                    activeColor: Colors.lightBlue[900],
                  ),
                ],
              ),
            ]))
          ]),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
