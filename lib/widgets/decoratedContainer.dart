import 'package:e_learning_app/screens/users/bar.dart';
import 'package:flutter/material.dart';

class DecoratedContainer extends StatelessWidget {
  final String image;
  final Color headColor;
  final Color bodyColor;
  final String subName;
  final Widget child;
  DecoratedContainer(
      {@required this.image,
      @required this.headColor,
      @required this.bodyColor,
      @required this.subName,
      @required this.child});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          height: size.height * .36,
          width: size.width,
          decoration: BoxDecoration(
              color: headColor,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(70),
              )),
          child: Column(
            children: [
              SizedBox(
                height: size.height * .05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios_rounded,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 40, 0),
                    child: Text(
                      subName,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: size.height * .26,
                      width: size.width * .4,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(30)),
                          image: DecorationImage(
                            image: AssetImage(image),
                          )),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        Stack(
          children: [
            Container(
              height: size.height * .2,
              width: size.width,
              color: headColor,
            ),
            Container(
              child: child,
              height: size.height * .64,
              width: size.width,
              decoration: BoxDecoration(
                  color: bodyColor,
                  borderRadius:
                      BorderRadius.only(topLeft: Radius.circular(90))),
            ),
          ],
        )
      ],
    );
  }
}
