import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String hint, label;
  Widget icon;
  final Function onSaved;
  String _errorMsg(String str) {
    switch (hint) {
      case 'account@gmail.com':
        return 'Enter Your Email Please';
      case 'Password':
        return 'Please Enter your password';
      case 'Mohamed Ayman':
        return 'Please Enter Your name';
    }
  }

  MyTextField(
      {@required this.hint,
      @required this.label,
      @required this.icon,
      @required this.onSaved});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * .1,
      width: size.width,
      child: TextFormField(
        obscureText: hint == 'Password' ? true : false,
        validator: (value) {
          if (value.isEmpty) {
            return _errorMsg(hint);
          }
        },
        onSaved: onSaved,
        decoration: InputDecoration(
            fillColor: Colors.blue[900],
            focusColor: Colors.blue[900],
            hoverColor: Colors.blue[900],
            hintText: hint,
            labelText: label,
            prefixIcon: icon,
            border: InputBorder.none,
            focusedErrorBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            errorBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 3, color: Colors.red),
                borderRadius: BorderRadius.circular(10.0)),
            focusedBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            enabledBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
      ),
    );
  }
}

class MyTextForm extends StatelessWidget {
  final Function onSaved;
  final String label;
  String onError(String str) {
    switch (label) {
      case 'Lecture Name':
        return 'Enter Lecture name';
      case 'Subject':
        return 'Enter Subject\'s Name';
      case 'Duration':
        return 'Enter Lecture\'s Duration';
      case 'Quiz Number':
        return 'Enter the number of the quiz';
      case 'Add question':
        return 'Add the Question please';
      case 'Answer':
        return 'Enter the answer of the question';
      case 'First Choose':
        return 'add the first choose';
      case 'Second Choose':
        return 'add the second choose';
      case 'Third Choose':
        return 'add the third choose';
    }
  }

  MyTextForm({@required this.label, @required this.onSaved});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 5, 30, 10),
      child: TextFormField(
          validator: (value) {
            if (value.isEmpty) {
              return onError(label);
            }
          },
          onSaved: onSaved,
          keyboardType: label == 'Number of questions' || label == 'Quiz Number'
              ? TextInputType.number
              : TextInputType.name,
          decoration: InputDecoration(
            labelText: label,
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  20,
                ),
                borderSide: BorderSide(color: Colors.red)),
            focusedBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            enabledBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          )),
    );
  }
}
