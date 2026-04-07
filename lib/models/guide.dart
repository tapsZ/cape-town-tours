import 'package:equatable/equatable.dart';

class Guide extends Equatable {
  final String id;
  final String name;
  final String experience;
  final String imagePath;
  final String twitterUrl;
  final String facebookUrl;
  final String linkedinUrl;

  const Guide({
    required this.id,
    required this.name,
    required this.experience,
    required this.imagePath,
    this.twitterUrl = '#',
    this.facebookUrl = '#',
    this.linkedinUrl = '#',
  });

  @override
  List<Object?> get props => [id, name];
}
