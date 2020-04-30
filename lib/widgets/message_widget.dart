import 'package:flutter/material.dart';

class MessageWidget extends StatefulWidget {

  final Function onPressedMic; // es el metodo para el boton del micropfono
  final Function onPressedEnviar; //metodo para el boton de enviar
  final Color colorMicrofono; //color del icono del mic (por defecto rojo)
  final String ayuda; //el hint del text field
  final TextEditingController textController; //el controlador para el text field

  MessageWidget({@required this.onPressedMic,
                 @required this.onPressedEnviar,
                 this.colorMicrofono,
                 this.ayuda,
                 this.textController});

  @override
  _MessageWidgetState createState() => _MessageWidgetState();
}

class _MessageWidgetState extends State<MessageWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15.0),
      height: 61,
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(35.0),
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 3),
                      blurRadius: 5,
                      color: Colors.grey)
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: widget.textController,
                      decoration: InputDecoration(
                          hintText: widget.ayuda!=null ? widget.ayuda : 'Escriba algo..' ,
                          border: InputBorder.none),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send),
                    onPressed: widget.onPressedEnviar,
                  ),

                ],
              ),
            ),
          ),
          SizedBox(width: 15),
          Container(
            padding: const EdgeInsets.all(15.0),
            decoration: BoxDecoration(
                color: widget.colorMicrofono != null ? widget.colorMicrofono : Colors.red, shape: BoxShape.circle),
            child: InkWell(
              child: Icon(
                Icons.keyboard_voice,
                color: Colors.white,
              ),
              onTap: widget.onPressedMic
            ),
          )
        ],
      ),
    );
  }
}
