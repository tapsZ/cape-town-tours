import 'package:equatable/equatable.dart';

class Tour extends Equatable {
  final String id;
  final String title;
  final String description;
  final String imagePath;
  final List<String> galleryImages;
  final List<String> highlights;
  final List<String> included;
  final List<String> whatToBring;
  final String duration;
  final String groupSize;
  final String slug;
  final double priceFrom;
  final double rating;
  final int reviewCount;
  final bool isMostPopular;
  final String category;

  const Tour({
    required this.id,
    required this.title,
    required this.description,
    required this.imagePath,
    required this.highlights,
    required this.slug,
    required this.priceFrom,
    this.galleryImages = const [],
    this.included = const [],
    this.whatToBring = const [],
    this.duration = 'Full Day',
    this.groupSize = 'Small Groups',
    this.rating = 4.8,
    this.reviewCount = 0,
    this.isMostPopular = false,
    this.category = 'Adventure',
  });

  @override
  List<Object?> get props => [id, title, slug];
}

class Testimonial extends Equatable {
  final String name;
  final String country;
  final String text;
  final double rating;
  final String tourSlug;

  const Testimonial({
    required this.name,
    required this.country,
    required this.text,
    required this.tourSlug,
    this.rating = 5.0,
  });

  @override
  List<Object?> get props => [name, country, tourSlug];
}
