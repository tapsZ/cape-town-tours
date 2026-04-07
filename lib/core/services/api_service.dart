import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/tour.dart';
import '../../models/guide.dart';
import '../../models/booking_request.dart';

class ApiService {
  static const String baseUrl = 'https://server.essenceofsale.com/api/v1/public/cape-tours';

  Future<List<Tour>> getTours() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/tours'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Tour.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load tours');
      }
    } catch (e) {
      return [];
    }
  }

  Future<List<Guide>> getGuides() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/guides'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Guide.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load guides');
      }
    } catch (e) {
      return [];
    }
  }

  Future<Tour?> getTourById(String id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/tours/$id'));
      if (response.statusCode == 200) {
        return Tour.fromJson(json.decode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<Tour?> getTourBySlug(String slug) async {
    // Current backend might not support lookup by slug directly, 
    // but the website stores tours in state after getTours() call.
    return null; 
  }

  Future<bool> createBooking(BookingRequest request) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/bookings'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(request.toJson()),
      );
      return response.statusCode == 201;
    } catch (e) {
      return false;
    }
  }
}
