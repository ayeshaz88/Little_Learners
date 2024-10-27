import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_proj/draw_screen.dart';
import 'package:my_proj/knowledge_screen.dart';
import 'package:my_proj/read_screen.dart';

import '/model/product_model.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemCount: products.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 0.85),
        itemBuilder: (context, index) => CategoryCard(
              product: products[index],
            ));
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (product.title == "Reading") {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ReadScreen(),
            ),
          );
        }
        if (product.title == "General Knowledge") {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => KnowledgeScreen()),
          );
        }
        if (product.title == "Drawing") {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => DrawScreen()),
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFF71b8ff),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              product.image,
              width: 30,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              product.title,
              style: GoogleFonts.openSans(
                textStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              product.subtitle,
              style: GoogleFonts.openSans(
                textStyle: const TextStyle(
                  color: Colors.white38,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(
              height: 14,
            ),
            Text(
              product.event,
              style: GoogleFonts.openSans(
                textStyle: const TextStyle(
                  color: Colors.white70,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Items {
  final String title;
  final String subtitle;
  final String event;
  final String img;
  Items({
    required this.title,
    required this.subtitle,
    required this.event,
    required this.img,
  });
}
