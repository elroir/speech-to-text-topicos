import 'package:flutter/material.dart';
import 'package:speech_recognition/speech_recognition.dart';
import 'package:speechtotext/models/document_model.dart';
import 'package:speechtotext/providers/natural_language_provider.dart';
import 'package:speechtotext/utils/widget_utils.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SpeechRecognition _speechRecognition;
  bool _isAvailable = false;
  bool _isListening = false;
  final _speechController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String resultText = "";
  DocumentModel documentModel = new DocumentModel();
  final naturalLanguage = new NaturalLanguageProvider();

  @override
  void initState() {
    super.initState();
    initSpeechRecognizer();
  }

  void initSpeechRecognizer(){
    _speechRecognition = SpeechRecognition();

    _speechRecognition.setAvailabilityHandler(
        (bool result) => setState(() => _isAvailable = result)
    );

    _speechRecognition.setRecognitionStartedHandler(
        () => setState(()=> _isListening = true)
    );

    _speechRecognition.setRecognitionResultHandler(
        (String speech) => setState(() => resultText = speech)
    );

    _speechRecognition.setRecognitionCompleteHandler(
            () => setState(()=> _isListening = false)
    );

    _speechRecognition.activate().then(
        (result) => setState (() => _isAvailable = result)
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
           // _createButtons(),
            SizedBox(height: 20.0,),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.width * 0.3,
              child: Text(resultText,style: TextStyle(fontSize: 16),),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.0),
                border: Border.all(),
              ),
            ),
            SizedBox(height: 20.0,width: 20.0,),
            crearInputMessage("mensaje","mensaje",_speechController,_speaking),
            FloatingActionButton(
              child: Icon(Icons.http),
              onPressed:() => naturalLanguage.cargarDatos(documentModel),
            )

          ],
        ),
      ),

    );
  }

// _getDatos() async {
//    setState(() {
//      resultText = naturalLanguage.cargarDatos(naturalLanguageModel);
//    });
//  }

  _speaking(){

  if(_isAvailable && !_isListening)
      _speechRecognition.listen(locale: "es_ES").then(
     (result) => print('$result')
      );
  else
    _speechRecognition.stop().then(
    (result) => setState(() => _isListening = result),
      );
  setState(() {
    resultText = _speechController.text;
    
  });

}
//  Widget _createButtons(){
//    return Row(
//      mainAxisAlignment: MainAxisAlignment.center,
//      children: <Widget>[
//
//
//        FloatingActionButton(
//            child: Icon(Icons.mic),
//            onPressed: _speaking,
//          ),
//
//        FloatingActionButton(
//          mini: true,
//          backgroundColor: Colors.red,
//          child: Icon(Icons.stop),
//          onPressed: (){
//            if (_isListening)
//              _speechRecognition.cancel().then(
//                    (result) => setState(() {
//                  _isListening = result;
//                  resultText = "";
//                }),
//              );
//          },
//        ),
//
//       ],
//     );
//  }
}
