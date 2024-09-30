import 'package:flutter/cupertino.dart';

class ReviewsTab extends StatelessWidget {
  final num movieId;

  const ReviewsTab({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Reviews for Movie ID: $movieId'));
  }
}

