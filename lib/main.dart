import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:smart_vendor/blocs/bloc_themes.dart';
import 'package:smart_vendor/screens/cadastro/cadastro_categorias.dart';
import 'package:smart_vendor/screens/cadastro/cadastro_mesas.dart';
import 'package:smart_vendor/screens/cadastro/cadastro_produtos.dart';

import 'blocs/bloc_categorias.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  // Create the initialization Future outside of `build`:
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //   title: 'Smart Vendor',
    //   theme: ThemeData(
    //     primarySwatch: Colors.blue,
    //   ),
    //   home: const MyHomePage(title: 'Smart Vendor'),
    // );
    return BlocProvider(
      blocs: [
        Bloc((i) => BlocThemes()),
        Bloc((i) => BlocCategorias()),
      ],
      dependencies: const [],
      child: const RootPage(),
    );
  }
}

class RootPage extends StatefulWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  final blocThemes = BlocProvider.getBloc<BlocThemes>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: blocThemes.outTheme,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return Container();
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'InfolineV3',
            theme: blocThemes.currentTheme(),
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('pt', 'BR'),
            ],
            home: MyHomePage(title: 'Smart Vendor'));
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
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
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              margin: EdgeInsets.zero,
              padding: EdgeInsets.zero,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image:
                          AssetImage('images/drawer_header_background.png'))),
              child: Stack(
                children: const [
                  Positioned(
                      bottom: 12.0,
                      left: 16.0,
                      child: Text("Smart Vendor",
                          style: TextStyle(fontSize: 20, color: Colors.white)))
                ],
              ),
            ),
            ListTile(
                title: const Text(
                  "Cadastro de Mesas",
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ListarMesasPage()));
                }),
            ListTile(
                title: const Text(
                  "Cadastro de Categorias",
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ListarCategoriasPage()));
                }),
            ListTile(
                title: const Text(
                  "Cadastro de Produtos",
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ListarProdutosPage()));
                }),
            // const Divider(),
            // const ListTile(
            //   title: Text("Home"),
            // ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Quantas vezes já foi no babão?:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
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
