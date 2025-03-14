import 'package:flutter/material.dart';

class StarRatingScreen extends StatefulWidget {
  final double rating;
  const StarRatingScreen({super.key, required this.rating});

  @override
  State<StarRatingScreen> createState() => _StarRatingScreenState();
}

class _StarRatingScreenState extends State<StarRatingScreen> {
  Widget star(bool fill) {
    return Icon(
      Icons.star,
      size: 18,
      color: fill ? Colors.black : Colors.black26,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        if (index < (widget.rating).round()) {
          return star(true);
        } else {
          return star(false);
        }
      }),
    );
  }
}
