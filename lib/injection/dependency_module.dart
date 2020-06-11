import 'package:awsimagecaption/repositories/aws_repository.dart';
import 'package:bloc_pattern/bloc_pattern.dart';

List<Dependency> get appDependencies => [
  Dependency((_) => Ec2Repository())
];