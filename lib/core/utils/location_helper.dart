import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationHelper {
  // Check if location services are enabled
  static Future<bool> isLocationServiceEnabled() async {
    return await Geolocator.isLocationServiceEnabled();
  }

  // Check location permission status
  static Future<LocationPermission> checkPermission() async {
    return await Geolocator.checkPermission();
  }

  // Request location permission
  static Future<LocationPermission> requestPermission() async {
    // First, check if we need to request permission
    var status = await Permission.location.status;
    
    if (status.isDenied) {
      // Request the permission
      status = await Permission.location.request();
      
      if (status.isPermanentlyDenied) {
        // The user opted to never see the permission request dialog again
        // You might want to show a dialog explaining why the permission is needed
        // and direct the user to the app settings
        return LocationPermission.deniedForever;
      }
    }
    
    return await Geolocator.requestPermission();
  }

  // Get current position
  static Future<Position?> getCurrentPosition() async {
    try {
      // Check if location services are enabled
      final isEnabled = await isLocationServiceEnabled();
      if (!isEnabled) {
        // Location services are disabled
        return null;
      }

      // Check and request permission
      var permission = await checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await requestPermission();
        if (permission == LocationPermission.denied) {
          // Permissions are denied
          return null;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        // Permissions are denied forever
        return null;
      }

      // Get current position
      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
    } catch (e) {
      // Handle any errors
      return null;
    }
  }

  // Get address from coordinates
  static Future<String?> getAddressFromCoordinates(
    double latitude, 
    double longitude,
  ) async {
    try {
      final placemarks = await placemarkFromCoordinates(latitude, longitude);
      
      if (placemarks.isEmpty) return null;
      
      final place = placemarks.first;
      
      // Format the address
      final addressParts = <String>[];
      
      if (place.street != null && place.street!.isNotEmpty) {
        addressParts.add(place.street!);
      }
      
      if (place.subLocality != null && place.subLocality!.isNotEmpty) {
        addressParts.add(place.subLocality!);
      }
      
      if (place.locality != null && place.locality!.isNotEmpty) {
        addressParts.add(place.locality!);
      }
      
      if (place.administrativeArea != null && place.administrativeArea!.isNotEmpty) {
        addressParts.add(place.administrativeArea!);
      }
      
      if (place.postalCode != null && place.postalCode!.isNotEmpty) {
        addressParts.add(place.postalCode!);
      }
      
      if (place.country != null && place.country!.isNotEmpty) {
        addressParts.add(place.country!);
      }
      
      return addressParts.join(', ');
    } catch (e) {
      return null;
    }
  }

  // Get coordinates from address
  static Future<Position?> getCoordinatesFromAddress(String address) async {
    try {
      final locations = await locationFromAddress(address);
      
      if (locations.isEmpty) return null;
      
      return Position(
        latitude: locations.first.latitude,
        longitude: locations.first.longitude,
        timestamp: DateTime.now(),
        accuracy: 0,
        altitude: 0,
        heading: 0,
        speed: 0,
        speedAccuracy: 0,
        altitudeAccuracy: 0,
        headingAccuracy: 0,
      );
    } catch (e) {
      return null;
    }
  }

  // Calculate distance between two coordinates in kilometers
  static double calculateDistance(
    double startLatitude,
    double startLongitude,
    double endLatitude,
    double endLongitude,
  ) {
    return Geolocator.distanceBetween(
      startLatitude,
      startLongitude,
      endLatitude,
      endLongitude,
    ) / 1000; // Convert meters to kilometers
  }

  // Check if location is within a certain radius (in kilometers)
  static bool isWithinRadius({
    required double centerLat,
    required double centerLng,
    required double pointLat,
    required double pointLng,
    required double radiusKm,
  }) {
    final distance = calculateDistance(
      centerLat,
      centerLng,
      pointLat,
      pointLng,
    );
    
    return distance <= radiusKm;
  }

  // Get the bearing between two points in degrees
  static double getBearing(
    double startLatitude,
    double startLongitude,
    double endLatitude,
    double endLongitude,
  ) {
    return Geolocator.bearingBetween(
      startLatitude,
      startLongitude,
      endLatitude,
      endLongitude,
    );
  }

  // Get the compass direction from degrees
  static String getCompassDirection(double degrees) {
    const directions = ['N', 'NNE', 'NE', 'ENE', 'E', 'ESE', 'SE', 'SSE', 'S', 'SSW', 'SW', 'WSW', 'W', 'WNW', 'NW', 'NNW'];
    final index = ((degrees + 11.25) % 360 / 22.5).floor();
    return directions[index % 16];
  }

  // Get the approximate travel time in minutes
  static int getTravelTimeInMinutes(
    double distanceKm, 
    double speedKmH, // average speed in km/h
  ) {
    if (speedKmH <= 0) return 0;
    return (distanceKm / speedKmH * 60).round();
  }
}
