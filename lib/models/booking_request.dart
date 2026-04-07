import 'package:equatable/equatable.dart';

class BookingRequest extends Equatable {
  final String tourId;
  final String customerName;
  final String customerEmail;
  final String customerPhone;
  final DateTime bookingDate;
  final int numberOfGuests;
  final String notes;

  const BookingRequest({
    required this.tourId,
    required this.customerName,
    required this.customerEmail,
    required this.customerPhone,
    required this.bookingDate,
    required this.numberOfGuests,
    this.notes = '',
  });

  Map<String, dynamic> toJson() {
    return {
      'tourId': tourId,
      'customerName': customerName,
      'customerEmail': customerEmail,
      'customerPhone': customerPhone,
      'bookingDate': bookingDate.toIso8601String().split('T')[0],
      'numberOfGuests': numberOfGuests,
      'notes': notes,
    };
  }

  @override
  List<Object?> get props => [
        tourId,
        customerName,
        customerEmail,
        customerPhone,
        bookingDate,
        numberOfGuests,
        notes,
      ];
}
