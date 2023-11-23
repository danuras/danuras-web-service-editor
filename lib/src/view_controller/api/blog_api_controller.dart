import 'dart:io';

import 'package:danuras_web_service_editor/src/view_controller/controller.dart';
import 'package:danuras_web_service_editor/src/model/auth.dart';
import 'package:danuras_web_service_editor/src/model/endpoint.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class BlogApiController extends BaseController {
  Future<http.Response> create(
    String title,
    String datePublished,
    String author,
    String text,
    String link,
    File? imageUrl,
  ) async {
    var uri = Uri.parse('${EndPoint.value}blog/create');
    var request = http.MultipartRequest('POST', uri);
    request.headers['Authorization'] = 'Bearer ${Auth.accessToken}';
    request.fields['title'] = title;
    request.fields['date_published'] = datePublished;
    request.fields['author'] = author;
    request.fields['text'] = text;
    request.fields['link'] = link;
    if (imageUrl != null) {
      var streamLi = http.ByteStream.fromBytes(
        await imageUrl.readAsBytes(),
      );
      // get file length
      var lengthLi = await imageUrl.length();
      var multipartFile = http.MultipartFile(
        'image_url',
        streamLi,
        lengthLi,
        filename: basename(imageUrl.path),
      );

      // add file to multipart
      request.files.add(multipartFile);
    }

    var hasil = await request.send();

    http.Response response = await http.Response.fromStream(hasil);

    return response;
  }

  Future<http.Response> update(
    int blogId,
    String title,
    String datePublished,
    String author,
    String text,
    String link,
    File? imageUrl,
  ) async {
    var uri = Uri.parse('${EndPoint.value}blog/update');
    var request = http.MultipartRequest('POST', uri);
    request.headers['Authorization'] = 'Bearer ${Auth.accessToken}';
    request.fields['blog_id'] = blogId.toString();
    request.fields['title'] = title;
    request.fields['date_published'] = datePublished;
    request.fields['author'] = author;
    request.fields['text'] = text;
    request.fields['link'] = link;
    if (imageUrl != null) {
      var streamLi = http.ByteStream.fromBytes(
        await imageUrl.readAsBytes(),
      );
      // get file length
      var lengthLi = await imageUrl.length();
      var multipartFile = http.MultipartFile(
        'image_url',
        streamLi,
        lengthLi,
        filename: basename(imageUrl.path),
      );

      // add file to multipart
      request.files.add(multipartFile);
    }

    var hasil = await request.send();

    http.Response response = await http.Response.fromStream(hasil);

    return response;
  }

  Future<http.Response> delete(int id) async {
    var uri = Uri.parse('${EndPoint.value}blog/delete/$id');
    final response = await http.delete(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${Auth.accessToken}',
      },
    );
    return response;
  }

  Future<http.Response> show() async {
    var uri = Uri.parse('${EndPoint.value}blog/show');
    final response = await http.get(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${Auth.accessToken}',
      },
    );
    return response;
  }
}
