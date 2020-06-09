import 'package:awsimagecaption/datasource/ec2_caption.dart';
import 'package:awsimagecaption/datasource/ec2_image.dart';
import 'package:awsimagecaption/utils/app_config.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'ec2_api_provider.g.dart';

final ec2Client = Ec2ApiProvider(Dio());

@RestApi(baseUrl: AppConfig.ec2BaseUrl)
abstract class Ec2ApiProvider {
  factory Ec2ApiProvider(Dio dio, {String baseUrl}) = _Ec2ApiProvider;

  @POST('/')
  Future<Ec2Caption> getCaption(@Body() Ec2Image image);
}