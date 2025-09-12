import 'package:intl/intl.dart';

class Formatters {
  // Date formatters
  static final DateFormat _dateFormat = DateFormat('MMM d, y');
  static final DateFormat _dateTimeFormat = DateFormat('MMM d, y HH:mm');
  static final DateFormat _timeFormat = DateFormat('HH:mm');
  static final DateFormat _apiDateFormat = DateFormat('yyyy-MM-dd');
  static final DateFormat _apiDateTimeFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'");

  // Format date to display format (e.g., "Jan 1, 2023")
  static String formatDate(DateTime? date) {
    if (date == null) return '';
    return _dateFormat.format(date);
  }

  // Format date and time to display format (e.g., "Jan 1, 2023 14:30")
  static String formatDateTime(DateTime? dateTime) {
    if (dateTime == null) return '';
    return _dateTimeFormat.format(dateTime);
  }

  // Format time to display format (e.g., "14:30")
  static String formatTime(DateTime? time) {
    if (time == null) return '';
    return _timeFormat.format(time);
  }

  // Format date to API format (e.g., "2023-01-01")
  static String formatDateForApi(DateTime? date) {
    if (date == null) return '';
    return _apiDateFormat.format(date);
  }

  // Format date and time to API format (e.g., "2023-01-01T14:30:00Z")
  static String formatDateTimeForApi(DateTime? dateTime) {
    if (dateTime == null) return '';
    return _apiDateTimeFormat.format(dateTime);
  }

  // Parse date from API format
  static DateTime? parseApiDate(String? dateString) {
    if (dateString == null || dateString.isEmpty) return null;
    try {
      return _apiDateFormat.parse(dateString);
    } catch (e) {
      return null;
    }
  }

  // Parse date and time from API format
  static DateTime? parseApiDateTime(String? dateTimeString) {
    if (dateTimeString == null || dateTimeString.isEmpty) return null;
    try {
      return _apiDateTimeFormat.parse(dateTimeString, true).toLocal();
    } catch (e) {
      return null;
    }
  }

  // Format currency (e.g., "$1,234.56")
  static String formatCurrency(double? amount, {String symbol = '₹'}) {
    if (amount == null) return '$symbol0.00';
    final format = NumberFormat.currency(
      symbol: symbol,
      decimalDigits: 2,
    );
    return format.format(amount);
  }

  // Format large numbers (e.g., "1.2K", "3.4M")
  static String formatNumber(int number) {
    if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    } else {
      return number.toString();
    }
  }

  // Format phone number (e.g., "(123) 456-7890")
  static String formatPhoneNumber(String phoneNumber) {
    // Remove all non-digit characters
    final digits = phoneNumber.replaceAll(RegExp(r'\D'), '');
    
    if (digits.length == 10) {
      return '(${digits.substring(0, 3)}) ${digits.substring(3, 6)}-${digits.substring(6)}';
    } else if (digits.length == 11) {
      return '${digits.substring(0, 1)} (${digits.substring(1, 4)}) ${digits.substring(4, 7)}-${digits.substring(7)}';
    } else {
      return phoneNumber; // Return original if format doesn't match
    }
  }

  // Format credit card number (e.g., "**** **** **** 1234")
  static String formatCreditCardNumber(String cardNumber, {bool obfuscate = true}) {
    final digits = cardNumber.replaceAll(RegExp(r'\D'), '');
    
    if (digits.length < 4) {
      return cardNumber;
    }
    
    final lastFour = digits.substring(digits.length - 4);
    
    if (obfuscate) {
      return '•••• •••• •••• $lastFour';
    } else {
      // Format with spaces for better readability
      final buffer = StringBuffer();
      for (int i = 0; i < digits.length; i++) {
        if (i > 0 && i % 4 == 0) {
          buffer.write(' ');
        }
        buffer.write(digits[i]);
      }
      return buffer.toString();
    }
  }

  // Format time duration (e.g., "2h 30m")
  static String formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    
    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else if (minutes > 0) {
      return '${minutes}m ${seconds}s';
    } else {
      return '${seconds}s';
    }
  }

  // Truncate text with ellipsis
  static String truncateWithEllipsis(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    }
    return '${text.substring(0, maxLength)}...';
  }

  // Format file size (e.g., "2.5 MB")
  static String formatFileSize(int bytes, {int decimals = 1}) {
    if (bytes <= 0) return '0 B';
    const units = ['B', 'KB', 'MB', 'GB', 'TB'];
    final digitGroups = (bytes == 0) ? 0 : (log(bytes) / log(1024)).floor();
    return '${(bytes / pow(1024, digitGroups)).toStringAsFixed(decimals)} ${units[digitGroups]}';
  }

  // Format social media numbers (e.g., "1.2K", "3.4M")
  static String formatSocialNumber(int number) {
    if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    } else {
      return number.toString();
    }
  }

  // Format percentage (e.g., "25.5%")
  static String formatPercentage(double value, {int decimalPlaces = 1}) {
    return '${(value * 100).toStringAsFixed(decimalPlaces)}%';
  }

  // Format address components into a single line
  static String formatAddress({
    String? street,
    String? city,
    String? state,
    String? postalCode,
    String? country,
  }) {
    final parts = <String>[];
    
    if (street != null && street.isNotEmpty) parts.add(street);
    if (city != null && city.isNotEmpty) parts.add(city);
    
    final stateZip = <String>[];
    if (state != null && state.isNotEmpty) stateZip.add(state);
    if (postalCode != null && postalCode.isNotEmpty) stateZip.add(postalCode);
    
    if (stateZip.isNotEmpty) {
      parts.add(stateZip.join(' '));
    }
    
    if (country != null && country.isNotEmpty) parts.add(country);
    
    return parts.join(', ');
  }
}

double log(num x) => log(x);
double pow(num x, num exponent) => x * exponent;
