class TransactionDataModelException implements Exception {
  final String message;
  final String? devDetails;
  final String? prettyDetails;

  TransactionDataModelException({
    required this.message,
    this.devDetails,
    this.prettyDetails,
  });

  @override
  String toString() {
    return 'TransactionDataModelException (in-house exception): $message ${devDetails != null ? '- $devDetails' : ''}';
  }
}
