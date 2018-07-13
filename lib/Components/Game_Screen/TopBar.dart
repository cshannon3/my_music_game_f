import 'package:flutter/material.dart';
import 'package:fluttery/framing.dart';


class TopBar extends StatefulWidget {

  final int timeElapsed;
  final int correct;
  final int cardsleft;
  final int cardnum;

  TopBar({
    this.timeElapsed,
    this.cardnum,
    this.correct,
    this.cardsleft,
  });
  @override
  _TopBarState createState() => new _TopBarState();
}

class _TopBarState extends State<TopBar> {

  @override
  Widget build(BuildContext context) {
    return new Container(
      decoration: BoxDecoration(
          border: Border(
            left: BorderSide(width: 2.0, color: Colors.grey[600]),
            right: BorderSide(width: 2.0, color: Colors.grey[600]),
            bottom: BorderSide(width: 2.0, color: Colors.grey[100]),
            top: BorderSide(width: 2.0, color: Colors.grey[600]),
          ),
          color: Colors.grey[400],
          boxShadow: [BoxShadow(
            color: Colors.black,
            blurRadius: 2.0,
          )
          ]
      ), // Box DEc

      padding: EdgeInsets.only(
          top: 10.0, right: 10.0, left: 10.0, bottom: 10.0),
      child: Container(
        height: 80.0,
        decoration: BoxDecoration(
            border: Border(
              left: BorderSide(width: 2.0, color: Colors.grey[600]),
              right: BorderSide(width: 2.0, color: Colors.grey[600]),
              bottom: BorderSide(width: 2.0, color: Colors.grey[100]),
              top: BorderSide(width: 2.0, color: Colors.grey[600]),
            ),
            color: Colors.grey[400],
            boxShadow: [BoxShadow(
              color: Colors.black,
              blurRadius: 2.0,
            )
            ]
        ), // Box DEc
        child: new Row(
          children: <Widget>[
           Container(
              height: 100.0,
              width: 150.0,
              child: RichText(
                overflow: TextOverflow.ellipsis,
                text: TextSpan(
                  text: "${widget.correct} / ${widget.cardnum}",
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 30.0,
                  ), // Text style
                ), // Text Span
                textAlign: TextAlign.center,
              ), //RichText
            ), // RCB
            
            new Expanded(
              child: Container(
                height: 100.0,
                width: 100.0,
                child: RichText(
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    text: widget.timeElapsed.toString(),
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 50.0,

                    ), // Text style
                  ), // Text Span
                  textAlign: TextAlign.center,
                ), //RichText
              ),
            ), // RCB
            Container(
              height: 100.0,
              width: 100.0,
              child: RichText(
                overflow: TextOverflow.ellipsis,
                text: TextSpan(
                  text: widget.cardsleft.toString(),
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 50.0,

                  ), // Text style
                ), // Text Span
                textAlign: TextAlign.center,
              ), //RichText
            ), // RCB
          ],
        ),
      ), // Container
    );
  }
}
