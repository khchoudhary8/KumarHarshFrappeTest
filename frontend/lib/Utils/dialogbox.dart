
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class BoxDeck extends StatefulWidget {
  double height, width;
  Color color;
  Text text;
  String link;
  Widget screen;
  BoxDeck({
    Key? key,
    required this.height,
    required this.width,
    required this.color,
    required this.text,
    required this.link,
    required this.screen,
  }) : super(key: key);

  @override
  State<BoxDeck> createState() => _BoxDeckState();
}

class _BoxDeckState extends State<BoxDeck> {

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return Container(
        height: 170,
        width: widget.width*0.42,

        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: widget.color, // background (button) color
            foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          ),

          ),
          onPressed: () {
            print(context.toString());
            // Navigator.pushNamed(context, widget.routeName);
            Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => widget.screen));
          },
          child: Column(children: [
            Container(
                height: 120,
                child: Padding(
                  padding: const EdgeInsets.all(28.0),
                  child: Image.asset(
                    widget.link,
                    fit: BoxFit.scaleDown,
                  ),
                )),
            Center(child: widget.text),
          ]),
        ),
      );
    });
  }
}
