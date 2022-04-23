import 'package:flutter/material.dart';

class HomeScreenItem extends StatelessWidget {
  const HomeScreenItem(
      {Key? key,
      required this.image,
      required this.title,
      required this.navigatorHandler})
      : super(key: key);

  final String image;
  final String title;
  final navigatorHandler;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return GestureDetector(
      onTap: navigatorHandler,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 14),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Container(
            height: isPortrait ? size.height * 0.30 : size.height * 0.8,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: ExactAssetImage(image),
              fit: BoxFit.fill,
            )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: isPortrait ? size.height * 0.05 : size.height * 0.09,
                  width: size.width,
                  decoration: const BoxDecoration(
                    color: Colors.black87,
                  ),
                  child: Center(
                    child: Text(
                      title,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
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
