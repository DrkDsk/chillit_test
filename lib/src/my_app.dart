import 'package:chillit_test/src/core/di/di.dart';
import 'package:chillit_test/src/features/home/ui/screens/home_screen.dart';
import 'package:chillit_test/src/features/login/ui/cubits/login_cubit.dart';
import 'package:chillit_test/src/features/tasks/ui/blocs/task_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => getIt<LoginCubit>()),
          BlocProvider(create: (context) => getIt<TaskBloc>()),
        ],
        child: HomeScreen(),
      ),
    );
  }
}
