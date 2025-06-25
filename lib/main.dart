import 'package:bloc_example/bloc_example/bloc/example_bloc.dart';
import 'package:bloc_example/bloc_example/example_bloc_page.dart';
import 'package:bloc_example/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      routes: {
        '/example': (_) => BlocProvider(
          create: (_) => ExampleBloc()..add(ExampleFindNameEvent()),
          child: ExampleBlocPage(),
        ),
      },
      home: const HomePage(),
    );
  }
}
