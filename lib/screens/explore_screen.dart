import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:room_app/components/diplay_place.dart';
import 'package:room_app/components/diplay_total_price.dart';

import 'package:room_app/components/search_bar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final SupabaseClient supabase = Supabase.instance.client;
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            SearchBarAndFilter(),
            CategoryItems(size),
            Expanded(child: SingleChildScrollView(child: Column(
              children: [
                DisplayTotalPrice(),
                 SizedBox(height: 15,),
                 DisplayPlace()
        
              ],
            ),))
            
          ],
        ),
      ),
     
     
    );
  }

  StreamBuilder<SupabaseStreamEvent> CategoryItems(Size size) {
    return StreamBuilder(
            stream: supabase.from('category').stream(primaryKey: ['id']),
            builder: (context, straemSnapshot) {
              if (straemSnapshot.hasData) {
                return Stack(
                  children: [
                    Positioned(
                      left: 0,
                      right: 0,
                      top: 80,
                      child: Divider(color: Colors.black12),
                    ),
                    SizedBox(
                      height: size.height * 0.12,
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        scrollDirection: Axis.horizontal,
                        itemCount: straemSnapshot.data!.length,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedIndex = index;
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.only(
                                top: 20,
                                right: 20,
                                left: 20,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    height: 32,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: Image.network(
                                      straemSnapshot.data![index]['image'],
                                      color:
                                          selectedIndex == index
                                              ? Colors.black
                                              : Colors.black45,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    straemSnapshot.data![index]['title'],
                                    style: TextStyle(
                                      fontSize: 13,
                                      color:
                                          selectedIndex == index
                                              ? Colors.black
                                              : Colors.black45,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Container(
                                    height: 3,
                                    width: 50,
                                    color:
                                        selectedIndex == index
                                            ? Colors.black
                                            : Colors.transparent,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              }
              return Center(child: CircularProgressIndicator());
            },
          );
  }
}
