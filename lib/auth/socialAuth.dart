import 'package:flutter/material.dart';

class SocialIcons extends StatelessWidget {
  final Size size;
  
  final String name;
  final IconData? icon;
  final Color color;
  final double iconSize;
  const SocialIcons({super.key, required this.size, required this.name, required this.icon, required this.color, required this.iconSize});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.only(bottom: 15),
                child: Container(
                  width: size.width,
                  padding: EdgeInsets.symmetric(vertical: 11),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all()
                  ),
                  child: Row(children: [
                    SizedBox(width: size.width * 0.05,),
                    Icon(icon ,
                    color: color,
                    size: iconSize,
                    ),
                    SizedBox(width: size.width * 0.15,),
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500
                      )
                    ),
                    SizedBox(width: 10,)
                  ],),
                ),);
  }
}
