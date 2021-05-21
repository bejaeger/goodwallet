class TransfersManagerException implements Exception {
  final String message;
  final String? devDetails;
  final String? prettyDetails;

  TransfersManagerException({
    required this.message,
    this.devDetails,
    this.prettyDetails,
  });

  @override
  String toString() {
    return 'TransfersManagerException (in-house exception): $message ${devDetails != null ? '- $devDetails' : ''}';
  }
}
