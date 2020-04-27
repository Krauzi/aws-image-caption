import 'package:awsimagecaption/repositories/cloud_repository.dart';
import 'package:bloc_pattern/bloc_pattern.dart';

List<Dependency> get appDependencies => [
  Dependency((_) => CloudRepository())
];