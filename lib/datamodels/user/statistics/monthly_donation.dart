import 'package:freezed_annotation/freezed_annotation.dart';

part 'monthly_donation.freezed.dart';
part 'monthly_donation.g.dart';

@freezed
class MonthlyDonation with _$MonthlyDonation {
  factory MonthlyDonation({
    required DateTime month,
    required num totalDonations,
  }) = _MonthlyDonation;

  factory MonthlyDonation.fromJson(Map<String, dynamic> json) =>
      _$MonthlyDonationFromJson(json);
}
