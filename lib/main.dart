import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'layers/presentation/bloc/select_photo/select_photo_bloc.dart';
import 'layers/presentation/view/select_photo/select_photo_view.dart';

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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MultiBlocProvider(providers: [
        BlocProvider<SelectPhotoBloc>(
          create: (context) => SelectPhotoBloc(),
        ),

      ], child: const SelectPhotoView(),)
    );
  }
}
