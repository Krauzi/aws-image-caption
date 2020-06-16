import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:awsimagecaption/datasource/client/ec2_api_provider.dart';
import 'package:awsimagecaption/datasource/ec2_caption.dart';
import 'package:awsimagecaption/datasource/ec2_image.dart';
import 'package:awsimagecaption/datasource/rekognition/rekognition.dart';
import 'package:awsimagecaption/datasource/rekognition_labels.dart';
import 'package:awsimagecaption/utils/aws_config.dart';

class Ec2Repository {

  Future<Ec2Caption> getEc2Caption(File file) async {
    String base64Image = base64.encode(await file.readAsBytes());
    return ec2Client.getCaption(Ec2Image(img: ",$base64Image"));
  }

  Future<RekognitionLabels> getRekognitionLabels(File file) async {
    Uint8List image = await file.readAsBytes();

    final credentials = AwsClientCredentials(
        accessKey: AwsConfig.ACCESS_KEY,
        secretKey: AwsConfig.SECRET_KEY,
        sessionToken: AwsConfig.SESSION_TOKEN
    );

    try {
      RekognitionLabels labels = RekognitionLabels();
      final service = Rekognition(region: AwsConfig.REGION, credentials: credentials);
      await service.detectLabels(image: Image(bytes: image), maxLabels: 8).then((value) {
        value.labels.forEach((element) {
          labels.labels += "${element.name}, ";
          labels.labelWithPercentage += "${element.name}, ${element.confidence.toStringAsFixed(2)}%\n";
        });
      });

      return labels;
    } catch(e) {
      return e;
    }
  }
}