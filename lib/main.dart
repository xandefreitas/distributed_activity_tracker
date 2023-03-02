import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app.dart';
import 'common/bloc/activityBloc/activity_bloc.dart';

void main() {
  runApp(BlocProvider(
    create: (context) => ActivityBloc(),
    child: const App(),
  ));
}
