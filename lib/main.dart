import 'package:bloc_example/bloc_example/bloc/example_bloc.dart';
import 'package:bloc_example/bloc_example/bloc_freezed/example_freezed_bloc.dart';
import 'package:bloc_example/bloc_example/example_bloc_page.dart';
import 'package:bloc_example/bloc_example/example_freezed_bloc_page.dart';
import 'package:bloc_example/contacts/list/bloc/contact_list_bloc.dart';
import 'package:bloc_example/contacts/list/contacts_list_page.dart';
import 'package:bloc_example/home/home_page.dart';
import 'package:bloc_example/repositories/contacts_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => ContactsRepository(),
      child: Builder(
        builder: (context) {
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
              '/example_freezed': (_) => BlocProvider(
                create: (context) =>
                    ExampleFreezedBloc()..add(ExampleFreezedEvent.findNames()),
                child: ExampleFreezedBlocPage(),
              ),
              '/contacts_list': (_) => BlocProvider(
                create: (_) => ContactListBloc(
                  repository: context.read<ContactsRepository>(),
                )..add(const ContactListEvent.findAll()),
                child: ContactsListPage(),
              ),
            },
            home: const HomePage(),
          );
        },
      ),
    );
  }
}
