import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/app/app.router.dart';
import 'package:good_wallet/datamodels/causes/concise_info/concise_project_info.dart';
import 'package:good_wallet/datamodels/causes/project.dart';
import 'package:good_wallet/datamodels/transfers/bookkeeping/recipient_info.dart';
import 'package:good_wallet/datamodels/transfers/bookkeeping/sender_info.dart';
import 'package:good_wallet/enums/money_source.dart';
import 'package:good_wallet/enums/transfer_type.dart';
import 'package:good_wallet/exceptions/firestore_api_exception.dart';
import 'package:good_wallet/services/projects/projects_service.dart';
import 'package:good_wallet/ui/views/common_viewmodels/projects_base_viewmodel.dart';
import 'package:good_wallet/utils/string_utils.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:good_wallet/utils/logger.dart';

class SingleProjectViewModel extends ProjectsBaseViewModel {
  final DialogService? _dialogService = locator<DialogService>();
  final NavigationService? _navigationService = locator<NavigationService>();
  final ProjectsService? _projectsService = locator<ProjectsService>();
  final SnackbarService? _snackbarService = locator<SnackbarService>();
  final log = getLogger("single_project_viewmodel.dart");

  String projectId;
  SingleProjectViewModel({required this.projectId});

  Project? project;
  Future initProject() async {
    setBusy(true);
    if (project == null) {
      try {
        project =
            await _projectsService!.getProjectWithId(projectId: projectId);
      } catch (e) {
        if (e is FirestoreApiException) {
          if (e.prettyDetails != null) {
            _snackbarService!.showSnackbar(message: e.prettyDetails!);
            await Future.delayed(Duration(seconds: 2));
            _navigationService!.back();
          }
        } else {
          rethrow;
        }
      }
    }
    if (project != null) setBusy(false);
  }

  void navigateToTransferFundAmountView(Project project) {
    final recipientInfo = RecipientInfo.donation(
      name: project.name,
      id: project.id,
      projectInfo: ConciseProjectInfo(
          name: project.name,
          id: project.id,
          area: project.area,
          imagePath: project.imageUrl,
          description: project.summary),
    );
    _navigationService!.navigateTo(Routes.transferFundsAmountView,
        arguments: TransferFundsAmountViewArguments(
            senderInfo: SenderInfo(moneySource: MoneySource.GoodWallet),
            type: TransferType.User2Project,
            recipientInfo: recipientInfo));
  }

  Future showAmountTooHighDialog(String donationAmount) async {
    await _dialogService!.showConfirmationDialog(
      title: 'Donation Amount Too High',
      description:
          'You cannot donate \$ $donationAmount with just \$ ${userStats.currentBalance / 100} in your account.',
    );
  }

  void navigateBack() {
    _navigationService!.back();
  }
}
