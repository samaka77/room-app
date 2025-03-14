

import 'dart:math';

import 'package:supabase_flutter/supabase_flutter.dart';
Future<void> uploadCategories(List<Category> categories) async {
  final SupabaseClient supabase = Supabase.instance.client;

  try {
    final List<Map<String, dynamic>> categoriesData = categories.map((category) {
      final String id = '${DateTime.now().millisecondsSinceEpoch}${Random().nextInt(1000)}';

      return category.toMap()..['id'] = id;
    }).toList();

    print("📌 البيانات قبل الإرسال: $categoriesData");

    final response = await supabase.from("category").insert(categoriesData);

    print(" تم رفع البيانات بنجاح!");
    print(" استجابة Supabase: $response");
  } catch (error) {
    print(" خطأ أثناء رفع البيانات: $error");
  }
}
class Category {
  final String title;
  final String image;

  Category({
    required this.title,
    required this.image,
  });
  // to upload data in firebase
  Map<String, dynamic> toMap() {
    return {
      'title': title ,
      'image': image ,
    };
  }
}

final List<Category> categoriesList = [
  Category(
    title: "Rooms",
    image: "https://cdn-icons-png.flaticon.com/512/6192/6192020.png",
  ),
  Category(
    title: "Icons",
    image: "https://cdn-icons-png.flaticon.com/512/734/734315.png",
  ),
  Category(
    title: "Surfing",
    image: "https://static.thenounproject.com/png/384446-200.png",
  ),
  Category(
    title: "Design",
    image: "https://cdn-icons-png.freepik.com/512/48/48781.png",
  ),
  Category(
    title: "Amazing views",
    image: "https://static.thenounproject.com/png/5027454-200.png",
  ),
  Category(
    title: "New",
    image: "https://www.iconpacks.net/icons/1/free-key-icon-920-thumb.png",
  ),
  Category(
    title: "Bed&breakfasts",
    image:
        "https://d1jj76g3lut4fe.cloudfront.net/processed/thumb/7u6sJOoAH6bp8v12g5.png?Expires=1695522574&Signature=J5jFmyAA3rmWw2JSbZbVtwYZohIGfqwBNZhgwqF4BHoW3QyJpe~b7CnD5EibDjVXe2u7nvjzpw6FBXr4ZriNZL4SYPtXNO6oVvsWl8noG73MAeEF~dd9ua2jAwqbqSeWuK~74UwHAy007o8Y~UFbOaI7DZg9fTESLv0MNhSLAWkZFN~ZVzuxt1~sF~eeHaWBAo-Nl-or8ysARgFeNQUvx6eqw8K-PVMR2IZsHFiSfXo~1CxzR6nKxBJW6eUuKWaH9t2S-hHqjQmMwKfGkhskDwCdLCuyuPghulKhjP12nEVH8A5S4lLy-3cNEYRt1l8LOC5U83hRqIsHFWR6EdAilQ__&Key-Pair-Id=K2YEDJLVZ3XRI",
  ),
  Category(
    title: "Houseboats",
    image: "https://cdn-icons-png.freepik.com/512/98/98527.png",
  ),
];