import 'package:equatable/equatable.dart';

class TourImage extends Equatable {
  final String url;
  final String? storageKey;

  const TourImage({required this.url, this.storageKey});

  @override
  List<Object?> get props => [url, storageKey];
}

class Tour extends Equatable {
  final String id;
  final String title;
  final String description;
  final String imagePath;
  final String? imageStorageKey;
  final List<TourImage> galleryImages;
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
  final String meetingPoint;
  final int maxCapacity;

  const Tour({
    required this.id,
    required this.title,
    required this.description,
    required this.imagePath,
    required this.highlights,
    required this.slug,
    required this.priceFrom,
    this.imageStorageKey,
    this.galleryImages = const [],
    this.included = const [],
    this.whatToBring = const [],
    this.duration = 'Full Day',
    this.groupSize = 'Small Groups',
    this.rating = 4.8,
    this.reviewCount = 0,
    this.isMostPopular = false,
    this.category = 'Adventure',
    this.meetingPoint = '',
    this.maxCapacity = 10,
  });

  factory Tour.fromJson(Map<String, dynamic> json) {
    final List<dynamic> imagesJson = json['images'] ?? [];
    final List<TourImage> images = imagesJson.map((img) => TourImage(
      url: img['url'] ?? '',
      storageKey: img['storageKey'],
    )).toList();

    final String mainImage = images.any((img) => img.url.isNotEmpty)
        ? images.firstWhere((img) => img.url.isNotEmpty).url
        : '';
    final String? mainImageKey = images.any((img) => img.url.isNotEmpty)
        ? images.firstWhere((img) => img.url.isNotEmpty).storageKey
        : null;

    List<String> parseCommaList(String? value) {
      if (value == null || value.isEmpty) return [];
      return value.split('\n').map((e) => e.trim()).where((e) => e.isNotEmpty).toList();
    }

    return Tour(
      id: json['id'] ?? '',
      title: json['name'] ?? '',
      description: json['description'] ?? '',
      imagePath: mainImage,
      imageStorageKey: mainImageKey,
      galleryImages: images,
      highlights: parseCommaList(json['highlights']),
      slug: json['slug'] ?? '',
      priceFrom: (json['price'] as num?)?.toDouble() ?? 0.0,
      included: parseCommaList(json['included']),
      whatToBring: parseCommaList(json['whatToBring']),
      duration: json['durationMinutes'] != null ? '${json['durationMinutes']} min' : 'Full Day',
      groupSize: json['groupSize'] ?? 'Small Groups',
      rating: (json['rating'] as num?)?.toDouble() ?? 4.8,
      reviewCount: json['reviewCount'] ?? 0,
      isMostPopular: json['isMostPopular'] ?? false,
      category: json['category'] ?? 'Adventure',
      meetingPoint: json['meetingPoint'] ?? '',
      maxCapacity: json['maxCapacity'] ?? 10,
    );
  }

  @override
  List<Object?> get props => [id, title, slug, imageStorageKey];
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
