import '../models/model.dart';
import 'api_service.dart';
import 'mock_data.dart';

/// Mock implementation of PlaceService for testing.
class MockPlaceService implements PlaceService {
  @override
  Future<List<Place>> fetchPlaces() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 3000));
    // Return mock data
    return dummyList;
  }
}
