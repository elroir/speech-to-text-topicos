import 'package:flutter/material.dart';
import 'package:speech_recognition/speech_recognition.dart';
import 'package:speechtotext/models/document_model.dart';
import 'package:speechtotext/providers/natural_language_provider.dart';
import 'package:speechtotext/widgets/message_widget.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SpeechRecognition _speechRecognition;
  bool _isAvailable = false;
  bool _isListening = false;
  final _speechController = TextEditingController();
  String resultText = "";
  String response = '';
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
            () => setState((){_isListening = false;
            _speechController.text  = resultText;})
    );

    _speechRecognition.activate().then(
        (result) => setState (() => _isAvailable = result)
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('Lenguaje natural'),
        actions: <Widget>[
          FlatButton(
            child: Text('Ejemplo'),
            color: Colors.redAccent,
            onPressed: _example ,
          )
        ],
      ),
        body: ListView(
         children: <Widget>[
           _principal()
      ],

      ),
    );
  }

  _example() {
    naturalLanguage.cargarDatos(documentModel).then((String value){
      setState(() {
        response = value;
        print(response);
      });
    });

  }

  Widget _principal(){
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // _createButtons(),
          SizedBox(height: 20.0,),
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.6,
            child: ListView(
              children: <Widget>[
                Text(response,style: TextStyle(fontSize: 16),)
              ],
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6.0),
              border: Border.all(),
            ),
          ),
          SizedBox(height: 20.0,width: 20.0,),
          MessageWidget(
            textController: _speechController,
            onPressedMic: _speaking,
            onPressedEnviar: _getData,),
        ],
      ),

    );
  }
   _getData() {
    final data = DocumentModel(content: _speechController.text);
    naturalLanguage.cargarDatos(data).then((String value){
      setState(() {
        response = value;
        resultText = '';
        _speechController.text = '';
      });
    });

  }

  _speaking(){

  if(_isAvailable && !_isListening)
      _speechRecognition.listen(locale: "es_ES").then(
     (result) => resultText = result
      );
  else
    _speechRecognition.stop().then(
    (result) => setState(() => _isListening = result),
      );

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
