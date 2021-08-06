class GlobalGivingApiException implements Exception {
  final String message;
  final String? devDetails;
  final String? prettyDetails;

  GlobalGivingApiException({
    required this.message,
    this.devDetails,
    this.prettyDetails,
  });

  @override
  String toString() {
    return 'GlobalGivingApiException (in-house exception): $message ${devDetails != null ? '- $devDetails' : ''}';
  }
}
