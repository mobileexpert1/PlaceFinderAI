import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/model.dart';
import '../../services/api_service.dart';
import '../../services/mock_place_service.dart';

/// Provides an instance of PlaceService (mock implementation for now)
final placeServiceProvider = Provider<PlaceService>((ref) {
  return MockPlaceService();
});

/// Fetches list of places using the provided PlaceService
final placeListProvider = FutureProvider<List<Place>>((ref) {
  final service = ref.watch(placeServiceProvider);
  return service.fetchPlaces();
});
