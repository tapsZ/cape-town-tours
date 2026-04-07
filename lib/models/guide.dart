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

  factory Guide.fromJson(Map<String, dynamic> json) {
    List<String> parseCommaList(String? value) {
      if (value == null || value.isEmpty) return [];
      return value.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty).toList();
    }

    return Guide(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      experience: json['experience'] ?? '5+ years',
      imagePath: json['photoUrl'] ?? '',
      bio: json['bio'] ?? '',
      languages: parseCommaList(json['languages']),
      specialty: json['specialties'] ?? '',
      isFeatured: json['isFeatured'] ?? false,
    );
  }

  @override
  List<Object?> get props => [id, name];
}
