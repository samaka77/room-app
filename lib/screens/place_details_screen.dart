import 'dart:convert';

import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:room_app/components/icon_button.dart';
import 'package:room_app/components/location_in_map.dart';
import 'package:room_app/provider/favorite_provider.dart';

import 'package:room_app/screens/star_rating_screen.dart';

class PlaceDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> place;

  const PlaceDetailsScreen({super.key, required this.place});

  @override
  State<PlaceDetailsScreen> createState() => _PlaceDetailsScreenState();
}

class _PlaceDetailsScreenState extends State<PlaceDetailsScreen> {
  int currentIndex = 0;

  List<NetworkImage> imageList = [];

  @override
  Widget build(BuildContext context) {
     final provider = Provider.of<FavoriteProvider>(context);
   

    if (widget.place['imageUrls'] is String) {
      List<dynamic> decodedList = jsonDecode(widget.place['imageUrls']);
      imageList =
          decodedList.map((url) => NetworkImage(url.toString())).toList();
    } else if (widget.place['imageUrls'] is List) {
      imageList =
          (widget.place['imageUrls'] as List<dynamic>)
              .map((url) => NetworkImage(url.toString()))
              .toList();
    }

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DetailImageandIcon(size, context,provider),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
              child: Column(
                children: [
                  Text(
                    widget.place['title'],
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: 25,
                      height: 1.2,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                  Text(
                    'Room in ${widget.place['address']}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    widget.place['bedAndBathroom'],
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
            widget.place['isActive'] == true
                ? RatingandStar()
                : RatingandStarFalse(),
            SizedBox(height: size.height * 0.02),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(),
                  PlacepropertyList(
                    size,
                    "https://static.vecteezy.com/system/resources/previews/018/923/486/original/diamond-symbol-icon-png.png",
                    "This is a rare find",
                    "${widget.place['vendor']}'s place is usually fully booked.",
                  ),
                  const Divider(),
                  PlacepropertyList(
                    size,
                    widget.place['vendorProfile'],
                    "Stay with ${widget.place['vendor']}",
                    "Superhost . ${widget.place['yearOfHostin']} years hosting",
                  ),
                  const Divider(),
                  PlacepropertyList(
                    size,
                    "https://cdn-icons-png.flaticon.com/512/6192/6192020.png",
                    "Room in a rental unit",
                    "Your own room in a home, pluse access\nto shared spaces.",
                  ),
                  PlacepropertyList(
                    size,
                    "https://cdn0.iconfinder.com/data/icons/co-working/512/coworking-sharing-17-512.png",
                    "Shared common spaces",
                    "You'll share parts of the home with the host,",
                  ),
                  PlacepropertyList(
                    size,
                    "https://img.pikbest.com/element_our/20230223/bg/102f90fb4dec6.png!w700wp",
                    "Shared bathroom",
                    "Your'll share the bathroom with others.",
                  ),
                  const Divider(),
                  SizedBox(height: size.height * 0.02),
                  const Text(
                    "About this place",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                  const Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit.\n Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                  ),
                  const Divider(),
                  const Text(
                    "Where  you'll be",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.place['address'],
                    style: const TextStyle(fontSize: 18),
                  ),
                  SizedBox(
                    height: 400,
                    width: size.width,
                    child: LocationInMap(place: widget.place),
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomSheet: priceAndReserve(size),
    );
  }

  Container priceAndReserve(Size size) {
    return Container(
      height: size.height * 0.1,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RichText(
                text: TextSpan(
                  text: "\$${widget.place['price']} ",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 18,
                  ),
                  children: const [
                    TextSpan(
                      text: "night",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                widget.place['date'],
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
          SizedBox(width: size.width * 0.3),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 15),
            decoration: BoxDecoration(
              color: Colors.pink,
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Text(
              "Reserve",
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding PlacepropertyList(Size size, image, title, subtitle) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15),
      child: Row(
        children: [
          Divider(),
          CircleAvatar(
            backgroundColor: Colors.white,
            backgroundImage: NetworkImage(image),
            radius: 29,
          ),
          SizedBox(width: size.width * 0.05),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
                ),
                Text(
                  subtitle,
                  softWrap: true,
                  overflow: TextOverflow.visible,
                  style: TextStyle(
                    fontSize: size.width * 0.0346,
                    color: Colors.grey.shade700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Padding RatingandStarFalse() => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 25),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.star),
        const SizedBox(width: 5),
        Text(
          '${widget.place['rating'].toString()}  .',
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        ),
        Text(
          '${widget.place['review'].toString()} reviews',
          style: TextStyle(
            fontSize: 17,
            decoration: TextDecoration.underline,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );

  Container RatingandStar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 13, vertical: 5),
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 15),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black26),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text(
                widget.place['rating'].toString(),
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  height: 1,
                ),
              ),
              StarRatingScreen(rating: widget.place['rating']),
            ],
          ),
          Stack(
            children: [
              Image.network(
                "https://wallpapers.com/images/hd/golden-laurel-wreathon-teal-background-k5791qxis5rtcx7w-k5791qxis5rtcx7w.png",
                height: 50,
                width: 130,
                color: Colors.amber,
              ),
              Positioned(
                left: 35,
                child: Text(
                  "Guest\nfavorite",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: [
              Text(
                widget.place['review'].toString(),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
              Text(
                'Reviews',
                style: TextStyle(
                  height: 0.7,
                  color: Colors.black,
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Stack DetailImageandIcon(Size size, BuildContext context, FavoriteProvider provider) {
    

    return Stack(
      children: [
        SizedBox(
          height: size.height * 0.35,
          child: AnotherCarousel(
            images: imageList,

            showIndicator: false,
            dotBgColor: Colors.transparent,
            onImageChange: (p0, p1) {
              setState(() {
                currentIndex = p1;
              });
            },
            autoplay: true,
            boxFit: BoxFit.cover,
          ),
        ),
        Positioned(
          bottom: 10,
          right: 20,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.black45,
            ),
            child: Text(
              "${currentIndex + 1} / ${(widget.place['imageUrls'] is String ? jsonDecode(widget.place['imageUrls']).length : (widget.place['imageUrls'] as List<dynamic>).length)}",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        Positioned(
          right: 0,
          left: 0,
          top: 25,
          child: Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: MyIconButton(icon: Icons.arrow_back_ios_new),
                ),
                SizedBox(width: size.width * 0.55),
                const MyIconButton(icon: Icons.share_outlined),
                const SizedBox(width: 20),
                InkWell(
                  onTap: () {
                    provider.toggleFavorite(widget.place.toString());
                  },
                  child: MyIconButton(
                    icon:
                        provider.isExist(widget.place.toString())
                            ? Icons.favorite
                            : Icons.favorite_border,
                    iconColor:
                        provider.isExist(widget.place.toString())
                            ? Colors.red
                            : Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
