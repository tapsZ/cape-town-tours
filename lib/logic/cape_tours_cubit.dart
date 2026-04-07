import 'package:flutter_bloc/flutter_bloc.dart';
import '../core/services/api_service.dart';
import '../models/booking_request.dart';
import 'cape_tours_state.dart';

class CapeToursCubit extends Cubit<CapeToursState> {
  final ApiService _apiService;

  CapeToursCubit(this._apiService) : super(CapeToursInitial());

  Future<void> loadData() async {
    emit(CapeToursLoading());
    try {
      final tours = await _apiService.getTours();
      final guides = await _apiService.getGuides();

      emit(CapeToursLoaded(
        tours: tours,
        guides: guides,
      ));
    } catch (e) {
      emit(CapeToursError(e.toString()));
    }
  }

  Future<bool> createBooking(BookingRequest request) async {
    return await _apiService.createBooking(request);
  }
}
