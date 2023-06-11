import 'package:flutter/cupertino.dart';

class Lectures {
  String id;
  String name;
  String duration;
  String link;
  String sub;
  Lectures(
      {@required this.id,
      @required this.duration,
      @required this.link,
      @required this.sub,
      @required this.name});
}
