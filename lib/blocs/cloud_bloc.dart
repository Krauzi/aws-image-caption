import 'package:awsimagecaption/repositories/cloud_repository.dart';
import 'package:bloc_pattern/bloc_pattern.dart';

class CloudBloc extends BlocBase {
  final CloudRepository _cloudRepository;

  CloudBloc(this._cloudRepository);
}