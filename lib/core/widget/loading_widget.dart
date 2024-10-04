import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Center(
        child: SizedBox(
          height: 50, // Small fixed height for the loader
          width: 50, // Small fixed width for the loader
          child: CircularProgressIndicator(
            color: Colors.black,
            strokeWidth: 4.0, // Optional: Adjust thickness of the loader
          ),
        ),
      ),
    );
  }
}
