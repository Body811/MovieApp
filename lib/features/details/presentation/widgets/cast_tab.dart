import 'package:flutter/cupertino.dart';

class CastTab extends StatelessWidget {
  final num movieId;

  const CastTab({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Cast for Movie ID: $movieId'));
  }
}
