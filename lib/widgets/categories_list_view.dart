import 'package:flutter/material.dart';

class CategoriesListView extends StatelessWidget {
  const CategoriesListView({super.key});

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.only(
              right: index == 4 ? 0 : 17,
              left: index == 0 ? 0 : 17,
              top: 8,
              bottom: 8,
            ),
            child: GestureDetector(
              onTap: () {},
              child: CategoriesListViewItem(
                image: categories[index]['image'],
                color: categories[index]['color'],
                title: categories[index]['title'],
              ),
            ),
          );
        },
      ),
    );
  }
}

class CategoriesListViewItem extends StatelessWidget {
  const CategoriesListViewItem({
    super.key,
    required this.image,
    required this.color,
    required this.title,
  });
  final String image;
  final Color color;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: color, //Constants.primaryColor.withOpacity(.05),
          ),
          child: Image.asset(image),
        ),
        SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

List<Map<String, dynamic>> categories = [
  {
    'image': 'assets/images/food_service.png',
    'color': Color(0xfff2eefd),
    'title': 'Foods',
  },
  {
    'image': 'assets/images/Gift-Surprise.png',
    'color': Color(0xffcbddfb),
    'title': 'Gift',
  },
  {
    'image': 'assets/images/Spectacles.png',
    'color': Color(0xfffae0cf),
    'title': 'Fashion',
  },
  {
    'image': 'assets/images/Game_Controller.png',
    'color': Color(0xffdde1e8),
    'title': 'Gadget',
  },
  {
    'image': 'assets/images/WristWatch.png',
    'color': Color(0xfffdf1e3),
    'title': 'Accessory',
  },
];
