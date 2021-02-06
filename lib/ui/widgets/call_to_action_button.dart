import 'package:flutter/material.dart';

class CallToActionButton extends StatelessWidget {
  final Function onTap;
  final String text;
  final Icon icon;
  final Color color;
  final bool leadingIcon;

  const CallToActionButton(
      {Key key,
      this.leadingIcon = true,
      this.onTap,
      this.text,
      this.icon,
      this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: color),
          //color: color,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              leadingIcon
                  ? icon != null
                      ? icon
                      : Container()
                  : Container(),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  text,
                  style: TextStyle(fontSize: 14, color: color),
                ),
              ),
              leadingIcon
                  ? Container()
                  : icon != null
                      ? icon
                      : Container(),
            ],
          ),
        ),
      ),
    );
  }
}

class CallToActionButtonRound extends StatelessWidget {
  final Function onPressed;
  final String text;
  final Icon icon;
  final Color color;

  const CallToActionButtonRound(
      {Key key, this.onPressed, this.text, this.icon, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 32,
          backgroundColor: color,
          child: IconButton(
            icon: icon,
            color: Colors.white,
            onPressed: onPressed,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(text,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey[800], fontSize: 15)),
        ),
      ],
    );
  }
}
