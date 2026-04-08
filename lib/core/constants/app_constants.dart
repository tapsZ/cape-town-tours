import '../../models/tour.dart';

class AppConstants {
  static const List<String> heroImages = [
    'assets/images/Slide/slide-1.webp',
    'assets/images/Slide/slide-2.webp',
    'assets/images/Slide/slide-3.webp',
  ];

  static const List<Testimonial> testimonials = [
    Testimonial(
      name: 'Sarah Johnson',
      country: 'UK',
      text: 'The Cape Point tour was absolutely breathtaking. Our guide was knowledgeable and the views were unforgettable.',
      rating: 5.0,
      tourSlug: 'cape-point-tour',
    ),
    Testimonial(
      name: 'Michael Chen',
      country: 'USA',
      text: 'Fantastic wine tasting experience! Highly recommend the Stellenbosch tour for anyone visiting Cape Town.',
      rating: 4.8,
      tourSlug: 'winelands-tour',
    ),
    Testimonial(
      name: 'Emma Wilson',
      country: 'Australia',
      text: 'The Table Mountain hike was challenging but so rewarding. The guides made us feel safe and motivated throughout.',
      rating: 5.0,
      tourSlug: 'table-mountain-hike',
    ),
  ];
}
