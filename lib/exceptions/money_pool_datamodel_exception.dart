class MoneyPoolDataModelException implements Exception {
  final String message;
  final String? devDetails;
  final String? prettyDetails;

  MoneyPoolDataModelException({
    required this.message,
    this.devDetails,
    this.prettyDetails,
  });

  @override
  String toString() {
    return 'MoneyPoolDataModelException (in-house exception): $message ${devDetails != null ? '- $devDetails' : ''}';
  }
}
