
import 'package:http/http.dart' as http;
import 'package:speechtotext/models/document_model.dart';

import 'dart:convert';


class NaturalLanguageProvider {


  final String _url = 'https://language.googleapis.com/v1/documents:analyzeEntities';
  final String _apikey= 'AIzaSyBj1Zm3YIRBUOCYAWWJPevwaNvy00KEi_w';


  Future<String> cargarDatos( DocumentModel nlp ) async{

    final url = '$_url?key=$_apikey';

    final resp = await http.post(url,body: jsonEncode({
      "document":{
        "type":"${nlp.type}",
        "content":"${nlp.content}"
      },
      "encodingType":"UTF8"
    }));

    final decodedData = json.decode(resp.body);
    print(decodedData);
    return decodedData.toString();

  }


}