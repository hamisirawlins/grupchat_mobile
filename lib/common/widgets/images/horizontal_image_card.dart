import 'package:flutter/material.dart';

class HorizontalImageCard extends StatelessWidget {
  final String text;
  final String image;
  final bool isNetworkImage;
  final VoidCallback? onPressed;
  const HorizontalImageCard({
    super.key,
    required this.text,
    required this.image,
    required this.isNetworkImage,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 10 / 6,
      child: Container(
        margin: const EdgeInsets.only(right: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: isNetworkImage
              ? DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(image),
                )
              : DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(image),
                ),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
                begin: Alignment.bottomRight,
                stops: const [
                  0.1,
                  0.9
                ],
                colors: [
                  Colors.black.withOpacity(.8),
                  Colors.black.withOpacity(0)
                ]),
          ),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.4),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Row(
                children: [
                  Text(
                    text.replaceRange(15, text.length, '...'),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Spacer(),
                  GestureDetector(
                      onTap: () {},
                      child: const Icon(Icons.more_vert, color: Colors.white)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
