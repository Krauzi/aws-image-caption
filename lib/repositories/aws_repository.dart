import 'dart:convert';
import 'dart:io';

import 'package:awsimagecaption/datasource/client/ec2_api_provider.dart';
import 'package:awsimagecaption/datasource/ec2_caption.dart';
import 'package:awsimagecaption/datasource/ec2_image.dart';

class Ec2Repository {
  Future<Ec2Caption> getEc2Caption(File file) async {
    try{
      String base64Image = base64.encode(await file.readAsBytes());
      return ec2Client.getCaption(Ec2Image(img: ",$base64Image"));
    } catch(e) {
      print("Error $e");
    }
  }
}