import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:room_app/provider/favorite_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class WithlistScreen extends StatelessWidget {
  const WithlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FavoriteProvider>(context);
    final favoriteItem = provider.favorites;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Edit',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),

                Text(
                  'Wishlists',
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                favoriteItem.isEmpty
                    ? Text(
                      'No Favorites items yet',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                    : SizedBox(
                      height: MediaQuery.of(context).size.height * 0.68,
                      child: GridView.builder(
                        itemCount: favoriteItem.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                        ),
                        itemBuilder: (context, index) {
                          String favoriteId = favoriteItem[index];
                          return FutureBuilder(
                            future:
                                Supabase.instance.client
                                    .from('place')
                                    .select()
                                    .eq('id', favoriteId)
                                    .single(),

                            builder: (context, snapShot) {
                              if (snapShot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              if (snapShot.hasError ||
                                  !snapShot.hasData ||
                                  snapShot.data == null) {
                                return Center(
                                  child: Text('Error loading favorites'),
                                );
                              }
                              var favoriteItem =
                                  snapShot.data as Map<String, dynamic>;
                              return Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                          favoriteItem['image'],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 8,
                                    right: 8,
                                    child: InkWell(
                                      onTap: () {
                                        provider.isExist(favoriteId);
                                      },
                                      child: Icon(
                                        Icons.favorite,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 8,
                                    left: 8,
                                    right: 8,
                                    child: Container(
                                      color: Colors.black.withOpacity(0.5),
                                      padding: EdgeInsets.all(4),
                                      child: Text(
                                        favoriteItem['title'],
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
