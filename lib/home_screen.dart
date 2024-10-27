import 'package:flutter/material.dart';
import 'package:my_proj/components/category.dart';
import 'package:my_proj/components/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        backgroundColor: Colors.orange,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Hi Julia",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      "Today is a good day\nto learn something new!",
                      style: TextStyle(
                        color: Colors.black54,
                        wordSpacing: 2.5,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Column(
                  children: [
                    Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                        color: kpurple,
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Image.asset(
                        "assets/images/profile.png",
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Fun Learn",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: const Text(
                    "See More",
                    style: TextStyle(fontSize: 16, color: kblue),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            CategoryList(),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
