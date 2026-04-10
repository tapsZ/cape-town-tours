import 'package:equatable/equatable.dart';
import '../../models/tour.dart';
import '../../models/guide.dart';
import '../../models/section_image.dart';

abstract class CapeToursState extends Equatable {
  const CapeToursState();

  @override
  List<Object?> get props => [];
}

class CapeToursInitial extends CapeToursState {}

class CapeToursLoading extends CapeToursState {}

class CapeToursLoaded extends CapeToursState {
  final List<Tour> tours;
  final List<Guide> guides;
  final List<SectionImage> heroImages;
  final SectionImage? ctaSectionImage;

  const CapeToursLoaded({
    required this.tours,
    required this.guides,
    this.heroImages = const [],
    this.ctaSectionImage,
  });

  @override
  List<Object?> get props => [tours, guides, heroImages, ctaSectionImage];
}

class CapeToursError extends CapeToursState {
  final String message;

  const CapeToursError(this.message);

  @override
  List<Object?> get props => [message];
}
