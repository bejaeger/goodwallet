// Mocks generated by Mockito 5.0.12 from annotations
// in good_wallet/test/helpers/test_helpers.dart.
// Do not manually edit this file.

import 'dart:async' as _i15;

import 'package:cloud_firestore/cloud_firestore.dart' as _i10;
import 'package:firebase_auth/firebase_auth.dart' as _i11;
import 'package:flutter/material.dart' as _i24;
import 'package:good_wallet/apis/firestore_api.dart' as _i20;
import 'package:good_wallet/datamodels/causes/project.dart' as _i9;
import 'package:good_wallet/datamodels/money_pools/base/money_pool.dart' as _i5;
import 'package:good_wallet/datamodels/money_pools/payouts/money_pool_payout.dart'
    as _i18;
import 'package:good_wallet/datamodels/statistics/global_statistics.dart'
    as _i7;
import 'package:good_wallet/datamodels/transfers/bookkeeping/money_transfer_query_config.dart'
    as _i22;
import 'package:good_wallet/datamodels/transfers/money_transfer.dart' as _i21;
import 'package:good_wallet/datamodels/user/public_user_info.dart' as _i19;
import 'package:good_wallet/datamodels/user/statistics/supported_project_statistics.dart'
    as _i16;
import 'package:good_wallet/datamodels/user/statistics/user_statistics.dart'
    as _i6;
import 'package:good_wallet/datamodels/user/user.dart' as _i4;
import 'package:good_wallet/enums/user_status.dart' as _i14;
import 'package:good_wallet/exceptions/firestore_api_exception.dart' as _i8;
import 'package:good_wallet/services/money_pools/money_pools_service.dart'
    as _i17;
import 'package:good_wallet/services/user/user_service.dart' as _i13;
import 'package:logger/logger.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:rxdart/rxdart.dart' as _i3;
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart' as _i12;
import 'package:stacked_services/stacked_services.dart' as _i23;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

class _FakeLogger extends _i1.Fake implements _i2.Logger {}

class _FakeBehaviorSubject<T> extends _i1.Fake
    implements _i3.BehaviorSubject<T> {}

class _FakeUser extends _i1.Fake implements _i4.User {}

class _FakeMoneyPool extends _i1.Fake implements _i5.MoneyPool {}

class _FakeUserStatistics extends _i1.Fake implements _i6.UserStatistics {}

class _FakeGlobalStatistics extends _i1.Fake implements _i7.GlobalStatistics {}

class _FakeFirestoreApiException extends _i1.Fake
    implements _i8.FirestoreApiException {}

class _FakeProject extends _i1.Fake implements _i9.Project {}

class _FakeCollectionReference extends _i1.Fake
    implements _i10.CollectionReference {}

class _FakeDocumentReference extends _i1.Fake
    implements _i10.DocumentReference {}

class _FakeFirebaseAuth extends _i1.Fake implements _i11.FirebaseAuth {}

class _FakeFirebaseAuthenticationResult extends _i1.Fake
    implements _i12.FirebaseAuthenticationResult {}

/// A class which mocks [UserService].
///
/// See the documentation for Mockito's code generation for more information.
class MockUserService extends _i1.Mock implements _i13.UserService {
  @override
  _i2.Logger get log =>
      (super.noSuchMethod(Invocation.getter(#log), returnValue: _FakeLogger())
          as _i2.Logger);
  @override
  _i3.BehaviorSubject<_i14.UserStatus> get userStateSubject =>
      (super.noSuchMethod(Invocation.getter(#userStateSubject),
              returnValue: _FakeBehaviorSubject<_i14.UserStatus>())
          as _i3.BehaviorSubject<_i14.UserStatus>);
  @override
  set userStateSubject(
          _i3.BehaviorSubject<_i14.UserStatus>? _userStateSubject) =>
      super.noSuchMethod(
          Invocation.setter(#userStateSubject, _userStateSubject),
          returnValueForMissingStub: null);
  @override
  _i3.BehaviorSubject<_i6.UserStatistics> get userStatsSubject =>
      (super.noSuchMethod(Invocation.getter(#userStatsSubject),
              returnValue: _FakeBehaviorSubject<_i6.UserStatistics>())
          as _i3.BehaviorSubject<_i6.UserStatistics>);
  @override
  set userStatsSubject(
          _i3.BehaviorSubject<_i6.UserStatistics>? _userStatsSubject) =>
      super.noSuchMethod(
          Invocation.setter(#userStatsSubject, _userStatsSubject),
          returnValueForMissingStub: null);
  @override
  List<_i4.User> get friends => (super.noSuchMethod(Invocation.getter(#friends),
      returnValue: <_i4.User>[]) as List<_i4.User>);
  @override
  set friends(List<_i4.User>? _friends) =>
      super.noSuchMethod(Invocation.setter(#friends, _friends),
          returnValueForMissingStub: null);
  @override
  set userStreamSubscription(
          _i15.StreamSubscription<dynamic>? _userStreamSubscription) =>
      super.noSuchMethod(
          Invocation.setter(#userStreamSubscription, _userStreamSubscription),
          returnValueForMissingStub: null);
  @override
  _i4.User get currentUser =>
      (super.noSuchMethod(Invocation.getter(#currentUser),
          returnValue: _FakeUser()) as _i4.User);
  @override
  void setCurrentUser(_i4.User? user) =>
      super.noSuchMethod(Invocation.method(#setCurrentUser, [user]),
          returnValueForMissingStub: null);
  @override
  _i15.Future<void>? listenToAuthStateChanges() => (super.noSuchMethod(
      Invocation.method(#listenToAuthStateChanges, []),
      returnValueForMissingStub: Future<void>.value()) as _i15.Future<void>?);
  @override
  _i15.Future<void> authStateChangesOnDataCallback(_i11.User? user) =>
      (super.noSuchMethod(
              Invocation.method(#authStateChangesOnDataCallback, [user]),
              returnValue: Future<void>.value(),
              returnValueForMissingStub: Future<void>.value())
          as _i15.Future<void>);
  @override
  _i15.Future<dynamic> initializeCurrentUser(_i11.User? user) =>
      (super.noSuchMethod(Invocation.method(#initializeCurrentUser, [user]),
          returnValue: Future<dynamic>.value()) as _i15.Future<dynamic>);
  @override
  _i15.Future<_i4.User> createUser({_i4.User? user}) =>
      (super.noSuchMethod(Invocation.method(#createUser, [], {#user: user}),
              returnValue: Future<_i4.User>.value(_FakeUser()))
          as _i15.Future<_i4.User>);
  @override
  _i15.Future<dynamic> listenToUserSummaryStats({String? uid}) =>
      (super.noSuchMethod(
          Invocation.method(#listenToUserSummaryStats, [], {#uid: uid}),
          returnValue: Future<dynamic>.value()) as _i15.Future<dynamic>);
  @override
  _i15.Future<dynamic> updateUserSettings({dynamic userSettings}) =>
      (super.noSuchMethod(
          Invocation.method(
              #updateUserSettings, [], {#userSettings: userSettings}),
          returnValue: Future<dynamic>.value()) as _i15.Future<dynamic>);
  @override
  bool isFavoriteProject({String? projectId}) => (super.noSuchMethod(
      Invocation.method(#isFavoriteProject, [], {#projectId: projectId}),
      returnValue: false) as bool);
  @override
  _i15.Future<dynamic> addOrRemoveFavorite({String? projectId}) =>
      (super.noSuchMethod(
          Invocation.method(#addOrRemoveFavorite, [], {#projectId: projectId}),
          returnValue: Future<dynamic>.value()) as _i15.Future<dynamic>);
  @override
  List<_i16.SupportedProjectStatistics> getSupportedProjects() =>
      (super.noSuchMethod(Invocation.method(#getSupportedProjects, []),
              returnValue: <_i16.SupportedProjectStatistics>[])
          as List<_i16.SupportedProjectStatistics>);
  @override
  bool isFriend({String? uid}) =>
      (super.noSuchMethod(Invocation.method(#isFriend, [], {#uid: uid}),
          returnValue: false) as bool);
  @override
  _i15.Future<dynamic> addOrRemoveFriend({String? uid}) => (super.noSuchMethod(
      Invocation.method(#addOrRemoveFriend, [], {#uid: uid}),
      returnValue: Future<dynamic>.value()) as _i15.Future<dynamic>);
  @override
  _i15.Future<dynamic> listenToFriends() =>
      (super.noSuchMethod(Invocation.method(#listenToFriends, []),
          returnValue: Future<dynamic>.value()) as _i15.Future<dynamic>);
  @override
  _i15.Future<dynamic> updateFriends() =>
      (super.noSuchMethod(Invocation.method(#updateFriends, []),
          returnValue: Future<dynamic>.value()) as _i15.Future<dynamic>);
  @override
  _i15.Future<dynamic> handleLogoutEvent() =>
      (super.noSuchMethod(Invocation.method(#handleLogoutEvent, []),
          returnValue: Future<dynamic>.value()) as _i15.Future<dynamic>);
}

/// A class which mocks [MoneyPoolsService].
///
/// See the documentation for Mockito's code generation for more information.
class MockMoneyPoolsService extends _i1.Mock implements _i17.MoneyPoolsService {
  @override
  _i2.Logger get log =>
      (super.noSuchMethod(Invocation.getter(#log), returnValue: _FakeLogger())
          as _i2.Logger);
  @override
  List<_i5.MoneyPool> get moneyPools =>
      (super.noSuchMethod(Invocation.getter(#moneyPools),
          returnValue: <_i5.MoneyPool>[]) as List<_i5.MoneyPool>);
  @override
  set moneyPools(List<_i5.MoneyPool>? _moneyPools) =>
      super.noSuchMethod(Invocation.setter(#moneyPools, _moneyPools),
          returnValueForMissingStub: null);
  @override
  List<_i5.MoneyPool> get moneyPoolsInvitedTo =>
      (super.noSuchMethod(Invocation.getter(#moneyPoolsInvitedTo),
          returnValue: <_i5.MoneyPool>[]) as List<_i5.MoneyPool>);
  @override
  set moneyPoolsInvitedTo(List<_i5.MoneyPool>? _moneyPoolsInvitedTo) =>
      super.noSuchMethod(
          Invocation.setter(#moneyPoolsInvitedTo, _moneyPoolsInvitedTo),
          returnValueForMissingStub: null);
  @override
  _i3.BehaviorSubject<int> get numberInvitedMoneyPoolsSubject =>
      (super.noSuchMethod(Invocation.getter(#numberInvitedMoneyPoolsSubject),
              returnValue: _FakeBehaviorSubject<int>())
          as _i3.BehaviorSubject<int>);
  @override
  set numberInvitedMoneyPoolsSubject(
          _i3.BehaviorSubject<int>? _numberInvitedMoneyPoolsSubject) =>
      super.noSuchMethod(
          Invocation.setter(
              #numberInvitedMoneyPoolsSubject, _numberInvitedMoneyPoolsSubject),
          returnValueForMissingStub: null);
  @override
  Map<String, List<_i18.MoneyPoolPayout>> get moneyPoolPayouts =>
      (super.noSuchMethod(Invocation.getter(#moneyPoolPayouts),
              returnValue: <String, List<_i18.MoneyPoolPayout>>{})
          as Map<String, List<_i18.MoneyPoolPayout>>);
  @override
  set moneyPoolPayouts(
          Map<String, List<_i18.MoneyPoolPayout>>? _moneyPoolPayouts) =>
      super.noSuchMethod(
          Invocation.setter(#moneyPoolPayouts, _moneyPoolPayouts),
          returnValueForMissingStub: null);
  @override
  void init({String? uid}) =>
      super.noSuchMethod(Invocation.method(#init, [], {#uid: uid}),
          returnValueForMissingStub: null);
  @override
  _i15.Future<dynamic> listenToMoneyPoolsInvitedTo({String? uid}) =>
      (super.noSuchMethod(
          Invocation.method(#listenToMoneyPoolsInvitedTo, [], {#uid: uid}),
          returnValue: Future<dynamic>.value()) as _i15.Future<dynamic>);
  @override
  _i15.Future<dynamic> addInvitedUserToMoneyPool(
          {_i19.PublicUserInfo? userInfo, _i5.MoneyPool? moneyPool}) =>
      (super.noSuchMethod(
          Invocation.method(#addInvitedUserToMoneyPool, [],
              {#userInfo: userInfo, #moneyPool: moneyPool}),
          returnValue: Future<dynamic>.value()) as _i15.Future<dynamic>);
  @override
  _i15.Future<void>? listenToMoneyPools({String? uid}) => (super.noSuchMethod(
      Invocation.method(#listenToMoneyPools, [], {#uid: uid}),
      returnValueForMissingStub: Future<void>.value()) as _i15.Future<void>?);
  @override
  _i15.Stream<_i5.MoneyPool> getMoneyPoolStream({String? mpid}) =>
      (super.noSuchMethod(
              Invocation.method(#getMoneyPoolStream, [], {#mpid: mpid}),
              returnValue: Stream<_i5.MoneyPool>.empty())
          as _i15.Stream<_i5.MoneyPool>);
  @override
  _i15.Future<_i5.MoneyPool> createAndReturnMoneyPool(
          {_i5.MoneyPool? moneyPool}) =>
      (super.noSuchMethod(
              Invocation.method(
                  #createAndReturnMoneyPool, [], {#moneyPool: moneyPool}),
              returnValue: Future<_i5.MoneyPool>.value(_FakeMoneyPool()))
          as _i15.Future<_i5.MoneyPool>);
  @override
  _i15.Future<dynamic> acceptInvitation(
          String? uid, String? name, _i5.MoneyPool? moneyPool) =>
      (super.noSuchMethod(
          Invocation.method(#acceptInvitation, [uid, name, moneyPool]),
          returnValue: Future<dynamic>.value()) as _i15.Future<dynamic>);
  @override
  _i15.Future<dynamic> declineInvitation(
          String? uid, _i5.MoneyPool? moneyPool) =>
      (super.noSuchMethod(
          Invocation.method(#declineInvitation, [uid, moneyPool]),
          returnValue: Future<dynamic>.value()) as _i15.Future<dynamic>);
  @override
  _i15.Future<dynamic> getMoneyPool(String? mpid) =>
      (super.noSuchMethod(Invocation.method(#getMoneyPool, [mpid]),
          returnValue: Future<dynamic>.value()) as _i15.Future<dynamic>);
  @override
  _i15.Future<dynamic> deleteMoneyPool(String? mpid) =>
      (super.noSuchMethod(Invocation.method(#deleteMoneyPool, [mpid]),
          returnValue: Future<dynamic>.value()) as _i15.Future<dynamic>);
  @override
  void clearData() => super.noSuchMethod(Invocation.method(#clearData, []),
      returnValueForMissingStub: null);
}

/// A class which mocks [FirestoreApi].
///
/// See the documentation for Mockito's code generation for more information.
class MockFirestoreApi extends _i1.Mock implements _i20.FirestoreApi {
  @override
  _i2.Logger get log =>
      (super.noSuchMethod(Invocation.getter(#log), returnValue: _FakeLogger())
          as _i2.Logger);
  @override
  _i15.Future<void> createUser({_i4.User? user, _i6.UserStatistics? stats}) =>
      (super.noSuchMethod(
              Invocation.method(#createUser, [], {#user: user, #stats: stats}),
              returnValue: Future<void>.value(),
              returnValueForMissingStub: Future<void>.value())
          as _i15.Future<void>);
  @override
  _i15.Future<void> createUserInfo({_i4.User? user}) => (super.noSuchMethod(
      Invocation.method(#createUserInfo, [], {#user: user}),
      returnValue: Future<void>.value(),
      returnValueForMissingStub: Future<void>.value()) as _i15.Future<void>);
  @override
  _i15.Future<void> createUserStatistics(
          {String? uid, _i6.UserStatistics? stats}) =>
      (super.noSuchMethod(
              Invocation.method(
                  #createUserStatistics, [], {#uid: uid, #stats: stats}),
              returnValue: Future<void>.value(),
              returnValueForMissingStub: Future<void>.value())
          as _i15.Future<void>);
  @override
  _i15.Future<_i4.User?> getUser({String? uid}) =>
      (super.noSuchMethod(Invocation.method(#getUser, [], {#uid: uid}),
          returnValue: Future<_i4.User?>.value()) as _i15.Future<_i4.User?>);
  @override
  _i15.Future<_i6.UserStatistics> getUserSummaryStatistics({String? uid}) =>
      (super.noSuchMethod(
              Invocation.method(#getUserSummaryStatistics, [], {#uid: uid}),
              returnValue:
                  Future<_i6.UserStatistics>.value(_FakeUserStatistics()))
          as _i15.Future<_i6.UserStatistics>);
  @override
  _i15.Stream<_i6.UserStatistics> getUserSummaryStatisticsStream(
          {String? uid}) =>
      (super.noSuchMethod(
          Invocation.method(#getUserSummaryStatisticsStream, [], {#uid: uid}),
          returnValue:
              Stream<_i6.UserStatistics>.empty()) as _i15
          .Stream<_i6.UserStatistics>);
  @override
  _i15.Future<dynamic> updateUserData({_i4.User? user}) =>
      (super.noSuchMethod(Invocation.method(#updateUserData, [], {#user: user}),
          returnValue: Future<dynamic>.value()) as _i15.Future<dynamic>);
  @override
  _i15.Stream<_i4.User> getUserStream({String? uid}) =>
      (super.noSuchMethod(Invocation.method(#getUserStream, [], {#uid: uid}),
          returnValue: Stream<_i4.User>.empty()) as _i15.Stream<_i4.User>);
  @override
  _i15.Future<_i7.GlobalStatistics> getGlobalStatistics() =>
      (super.noSuchMethod(Invocation.method(#getGlobalStatistics, []),
              returnValue:
                  Future<_i7.GlobalStatistics>.value(_FakeGlobalStatistics()))
          as _i15.Future<_i7.GlobalStatistics>);
  @override
  _i15.Stream<List<_i21.MoneyTransfer>> getTransferDataStream(
          {_i22.MoneyTransferQueryConfig? config, String? uid}) =>
      (super.noSuchMethod(
              Invocation.method(
                  #getTransferDataStream, [], {#config: config, #uid: uid}),
              returnValue: Stream<List<_i21.MoneyTransfer>>.empty())
          as _i15.Stream<List<_i21.MoneyTransfer>>);
  @override
  _i8.FirestoreApiException throwNotSupportedException(
          _i22.MoneyTransferQueryConfig? config) =>
      (super.noSuchMethod(
              Invocation.method(#throwNotSupportedException, [config]),
              returnValue: _FakeFirestoreApiException())
          as _i8.FirestoreApiException);
  @override
  _i15.Stream<List<_i21.MoneyTransfer>> getCombinedMoneyTransfersStream(
          {_i10.Query? outgoing,
          _i10.Query? incoming,
          int? maxNumberReturns}) =>
      (super.noSuchMethod(
              Invocation.method(#getCombinedMoneyTransfersStream, [], {
                #outgoing: outgoing,
                #incoming: incoming,
                #maxNumberReturns: maxNumberReturns
              }),
              returnValue: Stream<List<_i21.MoneyTransfer>>.empty())
          as _i15.Stream<List<_i21.MoneyTransfer>>);
  @override
  _i15.Stream<List<_i5.MoneyPool>> getMoneyPoolsInvitedToStream(
          {String? uid}) =>
      (super.noSuchMethod(
              Invocation.method(#getMoneyPoolsInvitedToStream, [], {#uid: uid}),
              returnValue: Stream<List<_i5.MoneyPool>>.empty())
          as _i15.Stream<List<_i5.MoneyPool>>);
  @override
  _i15.Stream<List<_i5.MoneyPool>> getMoneyPoolsStream({String? uid}) =>
      (super.noSuchMethod(
              Invocation.method(#getMoneyPoolsStream, [], {#uid: uid}),
              returnValue: Stream<List<_i5.MoneyPool>>.empty())
          as _i15.Stream<List<_i5.MoneyPool>>);
  @override
  _i15.Stream<_i5.MoneyPool> getMoneyPoolStream({String? mpid}) =>
      (super.noSuchMethod(
              Invocation.method(#getMoneyPoolStream, [], {#mpid: mpid}),
              returnValue: Stream<_i5.MoneyPool>.empty())
          as _i15.Stream<_i5.MoneyPool>);
  @override
  _i15.Stream<List<_i18.MoneyPoolPayout>> getMoneyPoolPayoutsStream(
          {String? mpid}) =>
      (super.noSuchMethod(
              Invocation.method(#getMoneyPoolPayoutsStream, [], {#mpid: mpid}),
              returnValue: Stream<List<_i18.MoneyPoolPayout>>.empty())
          as _i15.Stream<List<_i18.MoneyPoolPayout>>);
  @override
  _i15.Future<dynamic> updateMoneyPool(_i5.MoneyPool? moneyPool) =>
      (super.noSuchMethod(Invocation.method(#updateMoneyPool, [moneyPool]),
          returnValue: Future<dynamic>.value()) as _i15.Future<dynamic>);
  @override
  _i15.Future<_i5.MoneyPool> createAndReturnMoneyPool(
          {_i5.MoneyPool? moneyPool}) =>
      (super.noSuchMethod(
              Invocation.method(
                  #createAndReturnMoneyPool, [], {#moneyPool: moneyPool}),
              returnValue: Future<_i5.MoneyPool>.value(_FakeMoneyPool()))
          as _i15.Future<_i5.MoneyPool>);
  @override
  _i15.Future<dynamic> getMoneyPool(String? mpid) =>
      (super.noSuchMethod(Invocation.method(#getMoneyPool, [mpid]),
          returnValue: Future<dynamic>.value()) as _i15.Future<dynamic>);
  @override
  _i15.Future<dynamic> deleteMoneyPool(String? moneyPoolId) =>
      (super.noSuchMethod(Invocation.method(#deleteMoneyPool, [moneyPoolId]),
          returnValue: Future<dynamic>.value()) as _i15.Future<dynamic>);
  @override
  _i15.Future<_i9.Project> getProjectWithId({String? id}) =>
      (super.noSuchMethod(Invocation.method(#getProjectWithId, [], {#id: id}),
              returnValue: Future<_i9.Project>.value(_FakeProject()))
          as _i15.Future<_i9.Project>);
  @override
  _i15.Stream<List<_i9.Project>> getProjectsStream({String? uid}) => (super
          .noSuchMethod(Invocation.method(#getProjectsStream, [], {#uid: uid}),
              returnValue: Stream<List<_i9.Project>>.empty())
      as _i15.Stream<List<_i9.Project>>);
  @override
  _i15.Future<dynamic> createProject({_i9.Project? project}) => (super
      .noSuchMethod(Invocation.method(#createProject, [], {#project: project}),
          returnValue: Future<dynamic>.value()) as _i15.Future<dynamic>);
  @override
  _i10.CollectionReference getUserStatisticsCollection({String? uid}) =>
      (super.noSuchMethod(
          Invocation.method(#getUserStatisticsCollection, [], {#uid: uid}),
          returnValue: _FakeCollectionReference()) as _i10.CollectionReference);
  @override
  _i10.DocumentReference getUserSummaryStatisticsDocument({String? uid}) =>
      (super.noSuchMethod(
          Invocation.method(#getUserSummaryStatisticsDocument, [], {#uid: uid}),
          returnValue: _FakeDocumentReference()) as _i10.DocumentReference);
}

/// A class which mocks [NavigationService].
///
/// See the documentation for Mockito's code generation for more information.
class MockNavigationService extends _i1.Mock implements _i23.NavigationService {
  @override
  String get previousRoute =>
      (super.noSuchMethod(Invocation.getter(#previousRoute), returnValue: '')
          as String);
  @override
  String get currentRoute =>
      (super.noSuchMethod(Invocation.getter(#currentRoute), returnValue: '')
          as String);
  @override
  _i24.GlobalKey<_i24.NavigatorState>? nestedNavigationKey(int? index) =>
      (super.noSuchMethod(Invocation.method(#nestedNavigationKey, [index]))
          as _i24.GlobalKey<_i24.NavigatorState>?);
  @override
  void config(
          {bool? enableLog,
          bool? defaultPopGesture,
          bool? defaultOpaqueRoute,
          Duration? defaultDurationTransition,
          bool? defaultGlobalState,
          String? defaultTransition}) =>
      super.noSuchMethod(
          Invocation.method(#config, [], {
            #enableLog: enableLog,
            #defaultPopGesture: defaultPopGesture,
            #defaultOpaqueRoute: defaultOpaqueRoute,
            #defaultDurationTransition: defaultDurationTransition,
            #defaultGlobalState: defaultGlobalState,
            #defaultTransition: defaultTransition
          }),
          returnValueForMissingStub: null);
  @override
  _i15.Future<T?>? navigateWithTransition<T>(_i24.Widget? page,
          {bool? opaque,
          String? transition = r'',
          Duration? duration,
          bool? popGesture,
          int? id,
          _i24.Curve? curve,
          _i23.Bindings? binding,
          bool? fullscreenDialog = false,
          bool? preventDuplicates = true,
          _i23.Transition? transitionClass}) =>
      (super.noSuchMethod(Invocation.method(#navigateWithTransition, [
        page
      ], {
        #opaque: opaque,
        #transition: transition,
        #duration: duration,
        #popGesture: popGesture,
        #id: id,
        #curve: curve,
        #binding: binding,
        #fullscreenDialog: fullscreenDialog,
        #preventDuplicates: preventDuplicates,
        #transitionClass: transitionClass
      })) as _i15.Future<T?>?);
  @override
  _i15.Future<T?>? replaceWithTransition<T>(_i24.Widget? page,
          {bool? opaque,
          String? transition = r'',
          Duration? duration,
          bool? popGesture,
          int? id,
          _i24.Curve? curve,
          _i23.Bindings? binding,
          bool? fullscreenDialog = false,
          bool? preventDuplicates = true,
          _i23.Transition? transitionClass}) =>
      (super.noSuchMethod(Invocation.method(#replaceWithTransition, [
        page
      ], {
        #opaque: opaque,
        #transition: transition,
        #duration: duration,
        #popGesture: popGesture,
        #id: id,
        #curve: curve,
        #binding: binding,
        #fullscreenDialog: fullscreenDialog,
        #preventDuplicates: preventDuplicates,
        #transitionClass: transitionClass
      })) as _i15.Future<T?>?);
  @override
  bool back<T>({T? result, int? id}) => (super.noSuchMethod(
      Invocation.method(#back, [], {#result: result, #id: id}),
      returnValue: false) as bool);
  @override
  void popUntil(_i24.RoutePredicate? predicate) =>
      super.noSuchMethod(Invocation.method(#popUntil, [predicate]),
          returnValueForMissingStub: null);
  @override
  void popRepeated(int? popTimes) =>
      super.noSuchMethod(Invocation.method(#popRepeated, [popTimes]),
          returnValueForMissingStub: null);
  @override
  _i15.Future<T?>? navigateTo<T>(String? routeName,
          {dynamic arguments,
          int? id,
          bool? preventDuplicates = true,
          Map<String, String>? parameters}) =>
      (super.noSuchMethod(Invocation.method(#navigateTo, [
        routeName
      ], {
        #arguments: arguments,
        #id: id,
        #preventDuplicates: preventDuplicates,
        #parameters: parameters
      })) as _i15.Future<T?>?);
  @override
  _i15.Future<T?>? navigateToView<T>(_i24.Widget? view,
          {dynamic arguments,
          int? id,
          bool? opaque,
          _i24.Curve? curve,
          _i23.Bindings? binding,
          Duration? duration,
          bool? fullscreenDialog = false,
          bool? popGesture,
          bool? preventDuplicates = true,
          _i23.Transition? transition}) =>
      (super.noSuchMethod(Invocation.method(#navigateToView, [
        view
      ], {
        #arguments: arguments,
        #id: id,
        #opaque: opaque,
        #curve: curve,
        #binding: binding,
        #duration: duration,
        #fullscreenDialog: fullscreenDialog,
        #popGesture: popGesture,
        #preventDuplicates: preventDuplicates,
        #transition: transition
      })) as _i15.Future<T?>?);
  @override
  _i15.Future<T?>? replaceWith<T>(String? routeName,
          {dynamic arguments,
          int? id,
          bool? preventDuplicates = true,
          Map<String, String>? parameters}) =>
      (super.noSuchMethod(Invocation.method(#replaceWith, [
        routeName
      ], {
        #arguments: arguments,
        #id: id,
        #preventDuplicates: preventDuplicates,
        #parameters: parameters
      })) as _i15.Future<T?>?);
  @override
  _i15.Future<T?>? clearStackAndShow<T>(String? routeName,
          {dynamic arguments, int? id, Map<String, String>? parameters}) =>
      (super.noSuchMethod(Invocation.method(#clearStackAndShow, [
        routeName
      ], {
        #arguments: arguments,
        #id: id,
        #parameters: parameters
      })) as _i15.Future<T?>?);
  @override
  _i15.Future<T?>? clearTillFirstAndShow<T>(String? routeName,
          {dynamic arguments,
          int? id,
          bool? preventDuplicates = true,
          Map<String, String>? parameters}) =>
      (super.noSuchMethod(Invocation.method(#clearTillFirstAndShow, [
        routeName
      ], {
        #arguments: arguments,
        #id: id,
        #preventDuplicates: preventDuplicates,
        #parameters: parameters
      })) as _i15.Future<T?>?);
  @override
  _i15.Future<T?>? clearTillFirstAndShowView<T>(_i24.Widget? view,
          {dynamic arguments, int? id}) =>
      (super.noSuchMethod(Invocation.method(#clearTillFirstAndShowView, [view],
          {#arguments: arguments, #id: id})) as _i15.Future<T?>?);
  @override
  _i15.Future<T?>? pushNamedAndRemoveUntil<T>(String? routeName,
          {_i24.RoutePredicate? predicate, dynamic arguments, int? id}) =>
      (super.noSuchMethod(Invocation.method(#pushNamedAndRemoveUntil, [
        routeName
      ], {
        #predicate: predicate,
        #arguments: arguments,
        #id: id
      })) as _i15.Future<T?>?);
}

/// A class which mocks [SnackbarService].
///
/// See the documentation for Mockito's code generation for more information.
class MockSnackbarService extends _i1.Mock implements _i23.SnackbarService {
  @override
  void registerSnackbarConfig(_i23.SnackbarConfig? config) =>
      super.noSuchMethod(Invocation.method(#registerSnackbarConfig, [config]),
          returnValueForMissingStub: null);
  @override
  void registerCustomSnackbarconfig(
          {dynamic customData, _i23.SnackbarConfig? config}) =>
      super.noSuchMethod(
          Invocation.method(#registerCustomSnackbarconfig, [],
              {#customData: customData, #config: config}),
          returnValueForMissingStub: null);
  @override
  void registerCustomMainButtonBuilder(
          {dynamic variant,
          _i24.Widget Function(String?, Function?)? builder}) =>
      super.noSuchMethod(
          Invocation.method(#registerCustomMainButtonBuilder, [],
              {#variant: variant, #builder: builder}),
          returnValueForMissingStub: null);
  @override
  void registerCustomSnackbarConfig(
          {dynamic variant,
          _i23.SnackbarConfig? config,
          _i23.SnackbarConfig Function()? configBuilder}) =>
      super.noSuchMethod(
          Invocation.method(#registerCustomSnackbarConfig, [], {
            #variant: variant,
            #config: config,
            #configBuilder: configBuilder
          }),
          returnValueForMissingStub: null);
  @override
  void showSnackbar(
          {String? title = r'',
          String? message,
          dynamic Function(dynamic)? onTap,
          Duration? duration = const Duration(seconds: 3),
          String? mainButtonTitle,
          void Function()? onMainButtonTapped}) =>
      super.noSuchMethod(
          Invocation.method(#showSnackbar, [], {
            #title: title,
            #message: message,
            #onTap: onTap,
            #duration: duration,
            #mainButtonTitle: mainButtonTitle,
            #onMainButtonTapped: onMainButtonTapped
          }),
          returnValueForMissingStub: null);
  @override
  _i15.Future<dynamic>? showCustomSnackBar(
          {String? message,
          dynamic customData,
          dynamic variant,
          String? title,
          String? mainButtonTitle,
          void Function()? onMainButtonTapped,
          Function? onTap,
          Duration? duration = const Duration(seconds: 1)}) =>
      (super.noSuchMethod(Invocation.method(#showCustomSnackBar, [], {
        #message: message,
        #customData: customData,
        #variant: variant,
        #title: title,
        #mainButtonTitle: mainButtonTitle,
        #onMainButtonTapped: onMainButtonTapped,
        #onTap: onTap,
        #duration: duration
      })) as _i15.Future<dynamic>?);
}

/// A class which mocks [FirebaseAuthenticationService].
///
/// See the documentation for Mockito's code generation for more information.
class MockFirebaseAuthenticationService extends _i1.Mock
    implements _i12.FirebaseAuthenticationService {
  @override
  _i11.FirebaseAuth get firebaseAuth =>
      (super.noSuchMethod(Invocation.getter(#firebaseAuth),
          returnValue: _FakeFirebaseAuth()) as _i11.FirebaseAuth);
  @override
  bool get hasUser =>
      (super.noSuchMethod(Invocation.getter(#hasUser), returnValue: false)
          as bool);
  @override
  _i15.Stream<_i11.User?> get authStateChanges =>
      (super.noSuchMethod(Invocation.getter(#authStateChanges),
          returnValue: Stream<_i11.User?>.empty()) as _i15.Stream<_i11.User?>);
  @override
  _i15.Future<bool> emailExists(String? email) =>
      (super.noSuchMethod(Invocation.method(#emailExists, [email]),
          returnValue: Future<bool>.value(false)) as _i15.Future<bool>);
  @override
  _i15.Future<_i12.FirebaseAuthenticationResult> signInWithGoogle() =>
      (super.noSuchMethod(Invocation.method(#signInWithGoogle, []),
              returnValue: Future<_i12.FirebaseAuthenticationResult>.value(
                  _FakeFirebaseAuthenticationResult()))
          as _i15.Future<_i12.FirebaseAuthenticationResult>);
  @override
  _i15.Future<bool> isAppleSignInAvailable() =>
      (super.noSuchMethod(Invocation.method(#isAppleSignInAvailable, []),
          returnValue: Future<bool>.value(false)) as _i15.Future<bool>);
  @override
  _i15.Future<_i12.FirebaseAuthenticationResult> signInWithApple(
          {String? appleRedirectUri, String? appleClientId}) =>
      (super.noSuchMethod(
              Invocation.method(#signInWithApple, [], {
                #appleRedirectUri: appleRedirectUri,
                #appleClientId: appleClientId
              }),
              returnValue: Future<_i12.FirebaseAuthenticationResult>.value(
                  _FakeFirebaseAuthenticationResult()))
          as _i15.Future<_i12.FirebaseAuthenticationResult>);
  @override
  _i15.Future<_i12.FirebaseAuthenticationResult> loginAnonymously() =>
      (super.noSuchMethod(Invocation.method(#loginAnonymously, []),
              returnValue: Future<_i12.FirebaseAuthenticationResult>.value(
                  _FakeFirebaseAuthenticationResult()))
          as _i15.Future<_i12.FirebaseAuthenticationResult>);
  @override
  _i15.Future<_i12.FirebaseAuthenticationResult> loginWithEmail(
          {String? email, String? password}) =>
      (super.noSuchMethod(
              Invocation.method(
                  #loginWithEmail, [], {#email: email, #password: password}),
              returnValue: Future<_i12.FirebaseAuthenticationResult>.value(
                  _FakeFirebaseAuthenticationResult()))
          as _i15.Future<_i12.FirebaseAuthenticationResult>);
  @override
  _i15.Future<_i12.FirebaseAuthenticationResult> createAccountWithEmail(
          {String? email, String? password}) =>
      (super.noSuchMethod(
              Invocation.method(#createAccountWithEmail, [],
                  {#email: email, #password: password}),
              returnValue: Future<_i12.FirebaseAuthenticationResult>.value(
                  _FakeFirebaseAuthenticationResult()))
          as _i15.Future<_i12.FirebaseAuthenticationResult>);
  @override
  _i15.Future<dynamic> logout() =>
      (super.noSuchMethod(Invocation.method(#logout, []),
          returnValue: Future<dynamic>.value()) as _i15.Future<dynamic>);
  @override
  _i15.Future<dynamic> sendResetPasswordLink(String? email) =>
      (super.noSuchMethod(Invocation.method(#sendResetPasswordLink, [email]),
          returnValue: Future<dynamic>.value()) as _i15.Future<dynamic>);
  @override
  _i15.Future<dynamic> validatePassword(String? password) =>
      (super.noSuchMethod(Invocation.method(#validatePassword, [password]),
          returnValue: Future<dynamic>.value()) as _i15.Future<dynamic>);
  @override
  _i15.Future<dynamic> updatePassword(String? password) =>
      (super.noSuchMethod(Invocation.method(#updatePassword, [password]),
          returnValue: Future<dynamic>.value()) as _i15.Future<dynamic>);
  @override
  _i15.Future<dynamic> updateEmail(String? email) =>
      (super.noSuchMethod(Invocation.method(#updateEmail, [email]),
          returnValue: Future<dynamic>.value()) as _i15.Future<dynamic>);
  @override
  String generateNonce([int? length = 32]) =>
      (super.noSuchMethod(Invocation.method(#generateNonce, [length]),
          returnValue: '') as String);
  @override
  String sha256ofString(String? input) =>
      (super.noSuchMethod(Invocation.method(#sha256ofString, [input]),
          returnValue: '') as String);
}
