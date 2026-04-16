import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../../models/tour.dart';
import '../../models/guide.dart';
import '../../models/booking_request.dart';
import '../../models/section_image.dart';

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

  Future<List<SectionImage>> getSectionImages(String sectionKey) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/website-sections/$sectionKey'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => SectionImage.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load section images');
      }
    } catch (e) {
      return [];
    }
  }

  Future<Map<String, String>> getSettings() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/settings'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return data.map((key, value) => MapEntry(key, value.toString()));
      }
      return {};
    } catch (e) {
      return {};
    }
  }

  Future<bool> recordInterest(String tourId, {String? email}) async {
    try {
      final queryParams = email != null ? '?email=${Uri.encodeComponent(email)}' : '';
      final response = await http.post(
        Uri.parse('$baseUrl/tours/$tourId/interest$queryParams'),
      );
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  Future<Map<String, dynamic>> recordGeneralLike(String? turnstileToken) async {
    final uri = Uri.parse('$baseUrl/likes');
    try {
      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'turnstileToken': turnstileToken}),
      );
      debugPrint('API recordGeneralLike: ${response.statusCode} ${response.body}');
      if (response.statusCode == 200) {
        return json.decode(response.body) as Map<String, dynamic>;
      }
      return {
        'success': false,
        'message': 'Server returned ${response.statusCode}',
        'body': response.body,
      };
    } catch (e, st) {
      debugPrint('API recordGeneralLike error: $e\n$st');
      return {'success': false, 'message': 'Network error: $e'};
    }
  }

  Future<Map<String, dynamic>> subscribeWaitlist(String email, {String? source, String? turnstileToken}) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/waitlist'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': email,
          'source': source ?? 'HOMEPAGE_CTA',
          'turnstileToken': turnstileToken,
        }),
      );
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else if (response.statusCode == 429) {
        return {'success': false, 'message': 'Too many attempts. Please try again later.'};
      }
      return {'success': false};
    } catch (e) {
      return {'success': false};
    }
  }
}
