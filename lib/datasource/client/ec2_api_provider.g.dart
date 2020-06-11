// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ec2_api_provider.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _Ec2ApiProvider implements Ec2ApiProvider {
  _Ec2ApiProvider(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    this.baseUrl ??= 'http://ec2-35-153-106-137.compute-1.amazonaws.com';
  }

  final Dio _dio;

  String baseUrl;

  @override
  getCaption(image) async {
    ArgumentError.checkNotNull(image, 'image');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(image?.toJson() ?? <String, dynamic>{});
    final Response<Map<String, dynamic>> _result = await _dio.request('/',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = Ec2Caption.fromJson(_result.data);
    return value;
  }
}
