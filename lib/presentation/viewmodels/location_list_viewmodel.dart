import 'package:desafio_fteam/domain/entities/location_entity.dart';
import 'package:desafio_fteam/domain/usecases/get_locations_usecase.dart';
import 'package:flutter/material.dart';

class LocationListViewModel extends ChangeNotifier {
  final GetLocationsUseCase getLocationsUseCase;

  LocationListViewModel({required this.getLocationsUseCase});

  final List<LocationEntity> _locations = [];
  List<LocationEntity> get locations => List.unmodifiable(_locations);

  int _page = 1;
  bool _isLoading = false;
  bool _hasMore = true;

  bool get isLoading => _isLoading;
  bool get hasMore => _hasMore;

  Future<void> loadLocations({bool loadMore = false}) async {
    if (_isLoading) return;
    if (!loadMore) {
      _page = 1;
      _hasMore = true;
      _locations.clear();
    } else if (!_hasMore) {
      return;
    }

    _isLoading = true;
    notifyListeners();

    try {
      final List<LocationEntity> result = await getLocationsUseCase(
        page: _page,
      );

      _locations.addAll(result);

      if (result.isEmpty) {
        _hasMore = false;
      } else {
        _page++;
      }
    } catch (e) {
      _hasMore = false;
    }

    _isLoading = false;
    notifyListeners();
  }
}
