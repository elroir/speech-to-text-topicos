import 'package:flutter/material.dart';
import 'package:speechtotext/utils/utils.dart' as utils;

  Widget crearInputString(String hintT,String labelT,TextEditingController controller) {

    return TextFormField(

      textCapitalization: TextCapitalization.words,
      controller: controller,
      decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0)
          ),
          hintText: hintT,
          labelText: labelT
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget crearInputNumeric(String HintT,String LabelT, double Valor,TextEditingController controller) {

    return TextFormField(
      controller: controller,
      textCapitalization: TextCapitalization.words,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0)
          ),
          hintText: HintT,
          labelText: LabelT
      ),
      onSaved: (value)=> Valor = double.parse(value),
      validator: (value) {
        if(utils.isNumeric(value)) {
          return null;
        } else {
          return 'Ingrese solo numeros';
        }
      },
    );
  }

Widget crearInputMessage(String hintT,String labelT,TextEditingController controller,Function func) {

  return  TextFormField(
    textCapitalization: TextCapitalization.words,
    controller: controller,
    decoration: InputDecoration(
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0)
      ),
      hintText: hintT,
      labelText: labelT,
      suffixIcon:Ink(
        decoration: const ShapeDecoration(
          color: Colors.lightBlue,
          shape: CircleBorder(),
        ),
        child: IconButton(
          icon: Icon(Icons.mic),
          color: Colors.white,
          onPressed: func,
        ),
      ),
    ),

  );


}

