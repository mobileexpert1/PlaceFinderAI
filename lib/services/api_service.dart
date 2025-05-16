import '../models/model.dart';

/// Abstract service to fetch a list of places.
/// Can be implemented using real APIs or mock data.
abstract class PlaceService {
  /// Fetches a list of places
  Future<List<Place>> fetchPlaces();
}
