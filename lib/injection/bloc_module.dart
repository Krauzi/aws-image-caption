import 'package:awsimagecaption/blocs/aws_bloc.dart';
import 'package:bloc_pattern/bloc_pattern.dart';

List<Bloc> get appBlocs => [
  Bloc((i) => Ec2Bloc(i.get()))
];