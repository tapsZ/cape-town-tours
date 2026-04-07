import 'package:equatable/equatable.dart';

class Tour extends Equatable {
  final String id;
  final String title;
  final String description;
  final String imagePath;
  final List<String> highlights;
  final String duration;
  final String groupSize;
  final String slug;

  const Tour({
    required this.id,
    required this.title,
    required this.description,
    required this.imagePath,
    required this.highlights,
    required this.slug,
    this.duration = 'Full Day',
    this.groupSize = 'Small Groups',
  });

  @override
  List<Object?> get props => [id, title, slug];
}
