import 'package:equatable/equatable.dart';

class SectionImage extends Equatable {
  final String url;
  final String? storageKey;
  final String? altText;
  final int displayOrder;

  const SectionImage({
    required this.url,
    this.storageKey,
    this.altText,
    required this.displayOrder,
  });

  factory SectionImage.fromJson(Map<String, dynamic> json) {
    return SectionImage(
      url: json['imageUrl'] ?? '',
      storageKey: json['storageKey'],
      altText: json['altText'],
      displayOrder: json['displayOrder'] ?? 0,
    );
  }

  @override
  List<Object?> get props => [url, storageKey, displayOrder];
}
