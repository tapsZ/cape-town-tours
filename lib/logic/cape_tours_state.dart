import 'package:equatable/equatable.dart';
import '../../models/tour.dart';
import '../../models/guide.dart';

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

  const CapeToursLoaded({required this.tours, required this.guides});

  @override
  List<Object?> get props => [tours, guides];
}

class CapeToursError extends CapeToursState {
  final String message;

  const CapeToursError(this.message);

  @override
  List<Object?> get props => [message];
}
