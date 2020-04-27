import 'package:awsimagecaption/blocs/cloud_bloc.dart';
import 'package:bloc_pattern/bloc_pattern.dart';

List<Bloc> get appBlocs => [
  Bloc((i) => CloudBloc(i.get()))
];