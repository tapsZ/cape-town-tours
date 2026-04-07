import 'package:bloc_test/bloc_test.dart';
import 'package:cape_best_tours/core/services/api_service.dart';
import 'package:cape_best_tours/logic/cape_tours_cubit.dart';
import 'package:cape_best_tours/logic/cape_tours_state.dart';
import 'package:cape_best_tours/models/booking_request.dart';
import 'package:cape_best_tours/models/guide.dart';
import 'package:cape_best_tours/models/tour.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockApiService extends Mock implements ApiService {}

void main() {
  late ApiService apiService;
  late CapeToursCubit capeToursCubit;

  setUp(() {
    apiService = MockApiService();
    capeToursCubit = CapeToursCubit(apiService);
  });

  tearDown(() {
    capeToursCubit.close();
  });

  final mockTours = [
    const Tour(
      id: '1',
      title: 'Test Tour',
      description: 'Test Description',
      imagePath: 'test.jpg',
      highlights: ['Test'],
      slug: 'test-tour',
      priceFrom: 1000,
    ),
  ];

  final mockGuides = [
    const Guide(
      id: '1',
      name: 'Test Guide',
      experience: '5 years',
      imagePath: 'test.jpg',
    ),
  ];

  group('CapeToursCubit', () {
    test('initial state is CapeToursInitial', () {
      expect(capeToursCubit.state, isA<CapeToursInitial>());
    });

    blocTest<CapeToursCubit, CapeToursState>(
      'emits [CapeToursLoading, CapeToursLoaded] when loadData is successful',
      build: () {
        when(() => apiService.getTours()).thenAnswer((_) async => mockTours);
        when(() => apiService.getGuides()).thenAnswer((_) async => mockGuides);
        return capeToursCubit;
      },
      act: (cubit) => cubit.loadData(),
      expect: () => [
        isA<CapeToursLoading>(),
        isA<CapeToursLoaded>().having((s) => s.tours, 'tours', mockTours).having((s) => s.guides, 'guides', mockGuides),
      ],
    );

    blocTest<CapeToursCubit, CapeToursState>(
      'emits [CapeToursLoading, CapeToursError] when loadData fails',
      build: () {
        when(() => apiService.getTours()).thenThrow(Exception('API Error'));
        return capeToursCubit;
      },
      act: (cubit) => cubit.loadData(),
      expect: () => [
        isA<CapeToursLoading>(),
        isA<CapeToursError>(),
      ],
    );

    test('createBooking returns true when successful', () async {
      final request = BookingRequest(
        tourId: '1',
        customerName: 'Test',
        customerEmail: 'test@test.com',
        customerPhone: '123',
        bookingDate: DateTime.now(),
        numberOfGuests: 1,
      );
      registerFallbackValue(request);
      when(() => apiService.createBooking(any())).thenAnswer((_) async => true);

      final result = await capeToursCubit.createBooking(request);

      expect(result, isTrue);
      verify(() => apiService.createBooking(request)).called(1);
    });
  });
}
