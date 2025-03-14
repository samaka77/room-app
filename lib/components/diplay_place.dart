import 'dart:convert';

import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:room_app/provider/favorite_provider.dart';
import 'package:room_app/screens/place_details_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DisplayPlace extends StatefulWidget {
  const DisplayPlace({super.key});

  @override
  State<DisplayPlace> createState() => _DisplayPlaceState();
}

class _DisplayPlaceState extends State<DisplayPlace> {
  final SupabaseClient supabase = Supabase.instance.client;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final favoriteProvider = Provider.of<FavoriteProvider>(context);
    return StreamBuilder(
      stream: supabase.from('place').stream(primaryKey: ['id']),
      builder: (context, streamSnapshot) {
        if (streamSnapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (!streamSnapshot.hasData || streamSnapshot.data!.isEmpty) {
          return Center(child: Text("No places available"));
        }

        final places = streamSnapshot.data as List<dynamic>;

        return ListView.builder(
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: places.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final place = places[index];

            // تأكيد أن imageUrls هو List<String>
            final List<String> imageUrls =
                place['imageUrls'] is String
                    ? List<String>.from(jsonDecode(place['imageUrls']))
                    : List<String>.from(place['imageUrls'] ?? []);
                        final String placeId = place['id'].toString(); // تأكد أن ID هو String
            final bool isFavorite = favoriteProvider.isExist(placeId); // التحقق من حالة المفضلة

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PlaceDetailsScreen(place: place),
                    ),
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: SizedBox(
                            height: 375,
                            width: double.infinity,
                            child: AnotherCarousel(
                              images:
                                  imageUrls
                                      .map((url) => NetworkImage(url))
                                      .toList(),
                              dotSize: 6,
                              indicatorBgPadding: 5,
                              dotBgColor: Colors.transparent,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 20,
                          left: 15,
                          right: 15,
                          child: Row(
                            children: [
                              place['isActive'] == true
                                  ? Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(40),
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 15,
                                        vertical: 5,
                                      ),
                                      child: Text(
                                        "GuestFavorite",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  )
                                  : SizedBox(width: size.width * 0.03),
                              Spacer(),
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  Icon(
                                    Icons.favorite_outline_rounded,
                                    size: 34,
                                    color: Colors.white,
                                  ),

                                  InkWell(
                                    onTap: () {
                                      favoriteProvider.toggleFavorite(placeId);
                                    },
                                    child: Icon( 
                                      Icons.favorite,
                                      
                                      size: 30,
                                      color: isFavorite ? Colors.red:
                                     
                                       Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        VendorProfile(place),
                      ],
                    ),
                    SizedBox(height: size.height * 0.01),
                    Row(
                      children: [
                        Text(
                          place['address'],
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                        Spacer(),
                        Icon(Icons.star),
                        SizedBox(width: 5),
                        Text(place['rating'].toString()),
                      ],
                    ),
                    Text(
                      'Stay with ${place['vendor']}, ${place['vendorProfession']}',
                      style: TextStyle(color: Colors.black54, fontSize: 16.5),
                    ),
                    SizedBox(height: size.height * 0.007),
                    RichText(
                      text: TextSpan(
                        text: '\$${place['price']}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 16,
                        ),

                        children: [
                          TextSpan(
                            text: 'night',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: size.height * 0.025),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Positioned VendorProfile(place) {
    return Positioned(
      bottom: 11,
      left: 10,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
            child: Image.asset(
              "images/book_cover.png",
              height: 60,
              width: 60,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 10,
            left: 10,
            child: CircleAvatar(
              backgroundImage: NetworkImage(place['vendorProfile']),
            ),
          ),
        ],
      ),
    );
  }
}
