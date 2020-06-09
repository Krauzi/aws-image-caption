import 'dart:io';

import 'package:awsimagecaption/datasource/ec2_caption.dart';
import 'package:awsimagecaption/repositories/aws_repository.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';

class Ec2Bloc extends BlocBase {
  final Ec2Repository _ec2Repository;

  Ec2Bloc(this._ec2Repository);

  PublishSubject<Object> _captionSubject = PublishSubject();
  Stream<Object> get captionObservable => _captionSubject.stream;

  PublishSubject<bool> _loadingCaptionSubject = PublishSubject();
  Stream<bool> get loadingCaptionObservable => _loadingCaptionSubject.stream;

  Future getEc2Caption(File file) async {
    _loadingCaptionSubject.add(true);
    _ec2Repository.getEc2Caption(file)
        .then(_onCaptionSuccess)
        .catchError(_onCaptionError);
  }

  Future _onCaptionSuccess(Object caption) async {
    _loadingCaptionSubject.add(false);
    _captionSubject.add(caption);
  }

  Future _onCaptionError(e) async {
    _loadingCaptionSubject.add(false);
    _captionSubject.addError(e);
  }

  @override
  void dispose() {
    super.dispose();
    _captionSubject.close();
    _loadingCaptionSubject.close();
  }
}