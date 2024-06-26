class FirestoreApiException implements Exception {
  final String message;
  final String? devDetails;
  final String? prettyDetails;

  FirestoreApiException({
    required this.message,
    this.devDetails,
    this.prettyDetails,
  });

  @override
  String toString() {
    return 'FirestoreApiException (in-house exception): $message ${devDetails != null ? '- $devDetails' : ''}';
  }
}
