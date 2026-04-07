import 'package:equatable/equatable.dart';

class Guide extends Equatable {
  final String id;
  final String name;
  final String experience;
  final String imagePath;
  final String bio;
  final List<String> languages;
  final String specialty;
  final bool isFeatured;

  const Guide({
    required this.id,
    required this.name,
    required this.experience,
    required this.imagePath,
    this.bio = '',
    this.languages = const ['English'],
    this.specialty = '',
    this.isFeatured = false,
  });

  @override
  List<Object?> get props => [id, name];
}
