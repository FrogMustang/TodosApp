import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_app/bloc/todos_bloc.dart';
import 'package:todos_app/utils.dart';
import 'package:todos_app/widgets/home_screen.dart';

void main() async {
  await setUpGetIt();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<TodosBloc>()
        ..add(
          const AllTodosFetched(),
        ),
      child: const MaterialApp(
        title: 'Todos App',
        home: HomeScreen(),
      ),
    );
  }
}
