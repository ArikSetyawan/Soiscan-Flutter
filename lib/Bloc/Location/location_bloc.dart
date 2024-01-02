import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:soiscan/Repositories/location_repository.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final LocationRepository _locationRepository = LocationRepository();
  LocationBloc() : super(LocationInitial()) {
    on<GetDeviceLocation>((event, emit) async {
      emit(LocationLoading());
      try {
        final Position position = await _locationRepository.getPosition();
        final List<Placemark> placemarks = await _locationRepository.getPlacemarks(position.latitude, position.longitude);
        final String address = "${placemarks.first.thoroughfare}, ${placemarks.first.subLocality}, ${placemarks.first.subAdministrativeArea}, ${placemarks.first.administrativeArea} (${position.latitude}, ${position.longitude})";
        emit(LocationLoaded(position: position, address: address));
      } catch (e) {
        emit(LocationError(message: e.toString()));
      }
    });
  }
}
