import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mock_api_practice/feature/home/presentation/bloc/home_bloc.dart';
import 'package:mock_api_practice/feature/login/presentation/bloc/bloc.dart';
import 'package:mock_api_practice/feature/splash.dart';
import 'injection_container.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<LoginBloc>(create: (context)=>sl(),),
          BlocProvider<HomeBloc>(create: (context)=>sl())
        ],
        child: MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
          home: const SplashScreen(),
         ),
    );
  }
}


// import 'package:flutter/material.dart';
//
// void main() => runApp(const MyApp());
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: ReorderableListViewExample(),
//     );
//   }
// }
//
// class ReorderableListViewExample extends StatefulWidget {
//   const ReorderableListViewExample({super.key});
//
//   @override
//   _ReorderableListViewExampleState createState() => _ReorderableListViewExampleState();
// }
//
// class _ReorderableListViewExampleState extends State<ReorderableListViewExample> {
//   final List<String> _items = List<String>.generate(10, (index) => 'Item ${index + 1}');
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('ReorderableListView Example')),
//       body: ReorderableListView(
//         onReorder: _onReorder,
//         children: _items.map((item) => ListTile(
//           key: ValueKey(item),
//           title: Text(item),
//         )).toList(),
//       ),
//     );
//   }
//
//   void _onReorder(int oldIndex, int newIndex) {
//     setState(() {
//       if (newIndex > oldIndex) {
//         newIndex -= 1;
//       }
//       final String item = _items.removeAt(oldIndex);
//       _items.insert(newIndex, item);
//     });
//   }
// }
