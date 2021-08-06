import 'package:flutter/material.dart';
import 'package:good_wallet/datamodels/user/statistics/money_transfer_statistics.dart';
import 'package:good_wallet/datamodels/user/statistics/monthly_donation.dart';
import 'package:good_wallet/datamodels/user/statistics/supported_project_statistics.dart';
import 'package:good_wallet/datamodels/user/statistics/user_statistics.dart';
import 'package:good_wallet/utils/currency_formatting_helpers.dart';
import 'package:good_wallet/utils/date_helpers.dart';
import 'package:good_wallet/utils/ui_helpers.dart';
import 'package:stacked_services/stacked_services.dart';

class StatsDialog extends StatelessWidget {
  final DialogRequest request;
  final Function(DialogResponse) completer;
  const StatsDialog({Key? key, required this.request, required this.completer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserStatistics userStats = request.data;
    final MoneyTransferStatistics transferStats =
        userStats.moneyTransferStatistics;
    final List<SupportedProjectStatistics>? supportedProjects =
        userStats.donationStatistics.when(
            (totalDonations, supportedProjects, monthlyDonations) =>
                supportedProjects,
            empty: (totalDonations, supportedProjects, monthlyDonations) =>
                null);
    final List<MonthlyDonation>? monthlyDonations = userStats.donationStatistics
        .when(
            (totalDonations, supportedProjects, monthlyDonations) =>
                monthlyDonations,
            empty: (totalDonations, supportedProjects, monthlyDonations) =>
                null);
    Map<String, num> supportedAreas = {};
    if (supportedProjects != null) {
      supportedProjects.forEach((e) {
        String area = e.projectInfo.area;
        if (supportedAreas.containsKey(area)) {
          supportedAreas[area] = supportedAreas[area]! + e.totalDonations;
        } else {
          supportedAreas[area] = e.totalDonations;
        }
      });
    }
    final subTitleStyle =
        textTheme(context).bodyText2!.copyWith(fontWeight: FontWeight.w600);

    return Dialog(
        insetPadding:
            const EdgeInsets.symmetric(horizontal: 40.0, vertical: 130),
        child: Padding(
          padding: const EdgeInsets.only(
              top: 10.0, left: 20.0, right: 20.0, bottom: 10.0),
          child: ListView(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.0),
              if (request.title != null)
                Text(request.title!, style: textTheme(context).headline4),
              if (request.title == null)
                Text("Your Impact", style: textTheme(context).headline4),
              verticalSpaceSmall,
              DonationStats(
                  userStats: userStats,
                  monthlyDonations: monthlyDonations,
                  supportedAreas: supportedAreas,
                  supportedProjects: supportedProjects),
              if (supportedProjects != null && supportedProjects.length > 0)
                verticalSpaceSmall,
              FundraisingStats(transferStats: transferStats),
              SizedBox(height: 50),
            ],
          ),
        ));
  }
}

class RaisedFundsStatsDialog extends StatelessWidget {
  final DialogRequest request;
  final Function(DialogResponse) completer;
  const RaisedFundsStatsDialog(
      {Key? key, required this.request, required this.completer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserStatistics userStats = request.data;
    final MoneyTransferStatistics transferStats =
        userStats.moneyTransferStatistics;
    final subTitleStyle =
        textTheme(context).bodyText2!.copyWith(fontWeight: FontWeight.w600);

    return Dialog(
        insetPadding:
            const EdgeInsets.symmetric(horizontal: 40.0, vertical: 220),
        child: Padding(
          padding: const EdgeInsets.only(
              top: 10.0, left: 20.0, right: 20.0, bottom: 10.0),
          child: ListView(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.0),
              if (request.title != null)
                Text(request.title!, style: textTheme(context).headline4),
              if (request.title == null)
                Text("Your Fundraising Activities",
                    style: textTheme(context).headline4),
              verticalSpaceSmall,
              FundraisingStats(
                transferStats: transferStats,
                showSubtitle: false,
              ),
              SizedBox(height: 50),
            ],
          ),
        ));
  }
}

class DonationStatsDialog extends StatelessWidget {
  final DialogRequest request;
  final Function(DialogResponse) completer;
  const DonationStatsDialog(
      {Key? key, required this.request, required this.completer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserStatistics userStats = request.data;
    final List<SupportedProjectStatistics>? supportedProjects =
        userStats.donationStatistics.when(
            (totalDonations, supportedProjects, monthlyDonations) =>
                supportedProjects,
            empty: (totalDonations, supportedProjects, monthlyDonations) =>
                null);
    final List<MonthlyDonation>? monthlyDonations = userStats.donationStatistics
        .when(
            (totalDonations, supportedProjects, monthlyDonations) =>
                monthlyDonations,
            empty: (totalDonations, supportedProjects, monthlyDonations) =>
                null);
    Map<String, num> supportedAreas = {};
    if (supportedProjects != null) {
      supportedProjects.forEach((e) {
        String area = e.projectInfo.area;
        if (supportedAreas.containsKey(area)) {
          supportedAreas[area] = supportedAreas[area]! + e.totalDonations;
        } else {
          supportedAreas[area] = e.totalDonations;
        }
      });
    }
    final subTitleStyle =
        textTheme(context).bodyText2!.copyWith(fontWeight: FontWeight.w600);

    return Dialog(
        insetPadding:
            const EdgeInsets.symmetric(horizontal: 40.0, vertical: 130),
        child: Padding(
          padding: const EdgeInsets.only(
              top: 10.0, left: 20.0, right: 20.0, bottom: 10.0),
          child: ListView(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.0),
              if (request.title != null)
                Text(request.title!, style: textTheme(context).headline4),
              if (request.title == null)
                Text("Your Impact", style: textTheme(context).headline4),
              verticalSpaceSmall,
              DonationStats(
                  userStats: userStats,
                  monthlyDonations: monthlyDonations,
                  supportedAreas: supportedAreas,
                  supportedProjects: supportedProjects),
              SizedBox(height: 50),
            ],
          ),
        ));
  }
}

class DonationStats extends StatelessWidget {
  const DonationStats({
    Key? key,
    required this.userStats,
    required this.monthlyDonations,
    required this.supportedAreas,
    required this.supportedProjects,
  }) : super(key: key);

  final UserStatistics userStats;
  final List<MonthlyDonation>? monthlyDonations;
  final Map<String, num> supportedAreas;
  final List<SupportedProjectStatistics>? supportedProjects;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Total Donations", style: textTheme(context).headline6),
        Text("${formatAmount(userStats.donationStatistics.totalDonations)}"),
        verticalSpaceSmall,
        if (monthlyDonations != null && monthlyDonations!.length > 0)
          Text("Monthly Streak", style: textTheme(context).headline6),
        if (monthlyDonations != null)
          ...monthlyDonations!
              .map((e) => Text(
                  "${getMonth(e.month as int)}: ${formatAmount(e.totalDonations)}"))
              .toList(),
        if (monthlyDonations != null && monthlyDonations!.length > 0)
          verticalSpaceSmall,
        if (supportedAreas.length > 0)
          Text("Supported Problem Areas", style: textTheme(context).headline6),
        if (supportedAreas.length > 0)
          ...supportedAreas.entries
              .map((e) => Text("${e.key}: ${formatAmount(e.value)}"))
              .toList(),
        if (supportedAreas.length > 0) verticalSpaceSmall,
        if (supportedProjects != null && supportedProjects!.length > 0)
          Text("Supported Projects", style: textTheme(context).headline6),
        if (supportedProjects != null)
          ...supportedProjects!
              .map((e) => Text(
                  "${e.projectInfo.name}: ${formatAmount(e.totalDonations)}"))
              .toList(),
      ],
    );
  }
}

class FundraisingStats extends StatelessWidget {
  final bool showSubtitle;
  const FundraisingStats({
    Key? key,
    required this.transferStats,
    this.showSubtitle = true,
  }) : super(key: key);

  final MoneyTransferStatistics transferStats;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showSubtitle)
          Text("Fundraising Activities", style: textTheme(context).headline6),
        Text("Total Raised: ${formatAmount(transferStats.totalRaised)}"),
        Text(
            "    Raised via Money Pool: ${formatAmount(transferStats.totalRaisedViaMoneyPool)}"),
        Text(
            "    Received from Friend: ${formatAmount(transferStats.totalRaisedViaPeer2Peer)}"),
        Text(
            "    Raised via Subsidiary Apps: ${formatAmount(transferStats.totalRaisedViaSubsidiaryApp)}"),
        Text(
            "Total Sent to Friends: ${formatAmount(transferStats.totalSentToPeers)}"),
      ],
    );
  }
}
