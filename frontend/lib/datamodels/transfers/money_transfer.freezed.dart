// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'money_transfer.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MoneyTransfer _$MoneyTransferFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType'] as String) {
    case 'peer2peer':
      return Peer2PeerTransfer.fromJson(json);
    case 'donation':
      return Donation.fromJson(json);
    case 'moneyPoolContribution':
      return MoneyPoolContribution.fromJson(json);
    case 'moneyPoolPayoutTransfer':
      return MoneyPoolPayoutTransfer.fromJson(json);

    default:
      throw FallThroughError();
  }
}

/// @nodoc
class _$MoneyTransferTearOff {
  const _$MoneyTransferTearOff();

  Peer2PeerTransfer peer2peer(
      {required TransferDetails transferDetails,
      dynamic createdAt = "",
      TransferStatus status = TransferStatus.Initialized,
      TransferType type = TransferType.User2User,
      @JsonKey(name: "transferId") String transferId = "placeholder"}) {
    return Peer2PeerTransfer(
      transferDetails: transferDetails,
      createdAt: createdAt,
      status: status,
      type: type,
      transferId: transferId,
    );
  }

  Donation donation(
      {required TransferDetails transferDetails,
      required ConciseProjectInfo projectInfo,
      dynamic createdAt = "",
      TransferStatus status = TransferStatus.Initialized,
      TransferType type = TransferType.User2Project,
      @JsonKey(name: "transferId") String transferId = "placeholder"}) {
    return Donation(
      transferDetails: transferDetails,
      projectInfo: projectInfo,
      createdAt: createdAt,
      status: status,
      type: type,
      transferId: transferId,
    );
  }

  MoneyPoolContribution moneyPoolContribution(
      {required TransferDetails transferDetails,
      required ConciseMoneyPoolInfo moneyPoolInfo,
      dynamic createdAt = "",
      TransferStatus status = TransferStatus.Initialized,
      TransferType type = TransferType.User2MoneyPool,
      @JsonKey(name: "transferId") String transferId = "placeholder"}) {
    return MoneyPoolContribution(
      transferDetails: transferDetails,
      moneyPoolInfo: moneyPoolInfo,
      createdAt: createdAt,
      status: status,
      type: type,
      transferId: transferId,
    );
  }

  MoneyPoolPayoutTransfer moneyPoolPayoutTransfer(
      {required TransferDetails transferDetails,
      required ConciseMoneyPoolInfo moneyPoolInfo,
      required String payoutId,
      dynamic createdAt = "",
      TransferStatus status = TransferStatus.Initialized,
      TransferType type = TransferType.MoneyPool2User,
      @JsonKey(name: "transferId") String transferId = "placeholder"}) {
    return MoneyPoolPayoutTransfer(
      transferDetails: transferDetails,
      moneyPoolInfo: moneyPoolInfo,
      payoutId: payoutId,
      createdAt: createdAt,
      status: status,
      type: type,
      transferId: transferId,
    );
  }

  MoneyTransfer fromJson(Map<String, Object> json) {
    return MoneyTransfer.fromJson(json);
  }
}

/// @nodoc
const $MoneyTransfer = _$MoneyTransferTearOff();

/// @nodoc
mixin _$MoneyTransfer {
  TransferDetails get transferDetails => throw _privateConstructorUsedError;
  dynamic get createdAt => throw _privateConstructorUsedError;
  TransferStatus get status => throw _privateConstructorUsedError;
  TransferType get type => throw _privateConstructorUsedError;
  @JsonKey(name: "transferId")
  String get transferId => throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            TransferDetails transferDetails,
            dynamic createdAt,
            TransferStatus status,
            TransferType type,
            @JsonKey(name: "transferId") String transferId)
        peer2peer,
    required TResult Function(
            TransferDetails transferDetails,
            ConciseProjectInfo projectInfo,
            dynamic createdAt,
            TransferStatus status,
            TransferType type,
            @JsonKey(name: "transferId") String transferId)
        donation,
    required TResult Function(
            TransferDetails transferDetails,
            ConciseMoneyPoolInfo moneyPoolInfo,
            dynamic createdAt,
            TransferStatus status,
            TransferType type,
            @JsonKey(name: "transferId") String transferId)
        moneyPoolContribution,
    required TResult Function(
            TransferDetails transferDetails,
            ConciseMoneyPoolInfo moneyPoolInfo,
            String payoutId,
            dynamic createdAt,
            TransferStatus status,
            TransferType type,
            @JsonKey(name: "transferId") String transferId)
        moneyPoolPayoutTransfer,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            TransferDetails transferDetails,
            dynamic createdAt,
            TransferStatus status,
            TransferType type,
            @JsonKey(name: "transferId") String transferId)?
        peer2peer,
    TResult Function(
            TransferDetails transferDetails,
            ConciseProjectInfo projectInfo,
            dynamic createdAt,
            TransferStatus status,
            TransferType type,
            @JsonKey(name: "transferId") String transferId)?
        donation,
    TResult Function(
            TransferDetails transferDetails,
            ConciseMoneyPoolInfo moneyPoolInfo,
            dynamic createdAt,
            TransferStatus status,
            TransferType type,
            @JsonKey(name: "transferId") String transferId)?
        moneyPoolContribution,
    TResult Function(
            TransferDetails transferDetails,
            ConciseMoneyPoolInfo moneyPoolInfo,
            String payoutId,
            dynamic createdAt,
            TransferStatus status,
            TransferType type,
            @JsonKey(name: "transferId") String transferId)?
        moneyPoolPayoutTransfer,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Peer2PeerTransfer value) peer2peer,
    required TResult Function(Donation value) donation,
    required TResult Function(MoneyPoolContribution value)
        moneyPoolContribution,
    required TResult Function(MoneyPoolPayoutTransfer value)
        moneyPoolPayoutTransfer,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Peer2PeerTransfer value)? peer2peer,
    TResult Function(Donation value)? donation,
    TResult Function(MoneyPoolContribution value)? moneyPoolContribution,
    TResult Function(MoneyPoolPayoutTransfer value)? moneyPoolPayoutTransfer,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MoneyTransferCopyWith<MoneyTransfer> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MoneyTransferCopyWith<$Res> {
  factory $MoneyTransferCopyWith(
          MoneyTransfer value, $Res Function(MoneyTransfer) then) =
      _$MoneyTransferCopyWithImpl<$Res>;
  $Res call(
      {TransferDetails transferDetails,
      dynamic createdAt,
      TransferStatus status,
      TransferType type,
      @JsonKey(name: "transferId") String transferId});

  $TransferDetailsCopyWith<$Res> get transferDetails;
}

/// @nodoc
class _$MoneyTransferCopyWithImpl<$Res>
    implements $MoneyTransferCopyWith<$Res> {
  _$MoneyTransferCopyWithImpl(this._value, this._then);

  final MoneyTransfer _value;
  // ignore: unused_field
  final $Res Function(MoneyTransfer) _then;

  @override
  $Res call({
    Object? transferDetails = freezed,
    Object? createdAt = freezed,
    Object? status = freezed,
    Object? type = freezed,
    Object? transferId = freezed,
  }) {
    return _then(_value.copyWith(
      transferDetails: transferDetails == freezed
          ? _value.transferDetails
          : transferDetails // ignore: cast_nullable_to_non_nullable
              as TransferDetails,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as dynamic,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as TransferStatus,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as TransferType,
      transferId: transferId == freezed
          ? _value.transferId
          : transferId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }

  @override
  $TransferDetailsCopyWith<$Res> get transferDetails {
    return $TransferDetailsCopyWith<$Res>(_value.transferDetails, (value) {
      return _then(_value.copyWith(transferDetails: value));
    });
  }
}

/// @nodoc
abstract class $Peer2PeerTransferCopyWith<$Res>
    implements $MoneyTransferCopyWith<$Res> {
  factory $Peer2PeerTransferCopyWith(
          Peer2PeerTransfer value, $Res Function(Peer2PeerTransfer) then) =
      _$Peer2PeerTransferCopyWithImpl<$Res>;
  @override
  $Res call(
      {TransferDetails transferDetails,
      dynamic createdAt,
      TransferStatus status,
      TransferType type,
      @JsonKey(name: "transferId") String transferId});

  @override
  $TransferDetailsCopyWith<$Res> get transferDetails;
}

/// @nodoc
class _$Peer2PeerTransferCopyWithImpl<$Res>
    extends _$MoneyTransferCopyWithImpl<$Res>
    implements $Peer2PeerTransferCopyWith<$Res> {
  _$Peer2PeerTransferCopyWithImpl(
      Peer2PeerTransfer _value, $Res Function(Peer2PeerTransfer) _then)
      : super(_value, (v) => _then(v as Peer2PeerTransfer));

  @override
  Peer2PeerTransfer get _value => super._value as Peer2PeerTransfer;

  @override
  $Res call({
    Object? transferDetails = freezed,
    Object? createdAt = freezed,
    Object? status = freezed,
    Object? type = freezed,
    Object? transferId = freezed,
  }) {
    return _then(Peer2PeerTransfer(
      transferDetails: transferDetails == freezed
          ? _value.transferDetails
          : transferDetails // ignore: cast_nullable_to_non_nullable
              as TransferDetails,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as dynamic,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as TransferStatus,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as TransferType,
      transferId: transferId == freezed
          ? _value.transferId
          : transferId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$Peer2PeerTransfer extends Peer2PeerTransfer {
  const _$Peer2PeerTransfer(
      {required this.transferDetails,
      this.createdAt = "",
      this.status = TransferStatus.Initialized,
      this.type = TransferType.User2User,
      @JsonKey(name: "transferId") this.transferId = "placeholder"})
      : super._();

  factory _$Peer2PeerTransfer.fromJson(Map<String, dynamic> json) =>
      _$_$Peer2PeerTransferFromJson(json);

  @override
  final TransferDetails transferDetails;
  @JsonKey(defaultValue: "")
  @override
  final dynamic createdAt;
  @JsonKey(defaultValue: TransferStatus.Initialized)
  @override
  final TransferStatus status;
  @JsonKey(defaultValue: TransferType.User2User)
  @override
  final TransferType type;
  @override
  @JsonKey(name: "transferId")
  final String transferId;

  @override
  String toString() {
    return 'MoneyTransfer.peer2peer(transferDetails: $transferDetails, createdAt: $createdAt, status: $status, type: $type, transferId: $transferId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Peer2PeerTransfer &&
            (identical(other.transferDetails, transferDetails) ||
                const DeepCollectionEquality()
                    .equals(other.transferDetails, transferDetails)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality()
                    .equals(other.createdAt, createdAt)) &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)) &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.transferId, transferId) ||
                const DeepCollectionEquality()
                    .equals(other.transferId, transferId)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(transferDetails) ^
      const DeepCollectionEquality().hash(createdAt) ^
      const DeepCollectionEquality().hash(status) ^
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(transferId);

  @JsonKey(ignore: true)
  @override
  $Peer2PeerTransferCopyWith<Peer2PeerTransfer> get copyWith =>
      _$Peer2PeerTransferCopyWithImpl<Peer2PeerTransfer>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            TransferDetails transferDetails,
            dynamic createdAt,
            TransferStatus status,
            TransferType type,
            @JsonKey(name: "transferId") String transferId)
        peer2peer,
    required TResult Function(
            TransferDetails transferDetails,
            ConciseProjectInfo projectInfo,
            dynamic createdAt,
            TransferStatus status,
            TransferType type,
            @JsonKey(name: "transferId") String transferId)
        donation,
    required TResult Function(
            TransferDetails transferDetails,
            ConciseMoneyPoolInfo moneyPoolInfo,
            dynamic createdAt,
            TransferStatus status,
            TransferType type,
            @JsonKey(name: "transferId") String transferId)
        moneyPoolContribution,
    required TResult Function(
            TransferDetails transferDetails,
            ConciseMoneyPoolInfo moneyPoolInfo,
            String payoutId,
            dynamic createdAt,
            TransferStatus status,
            TransferType type,
            @JsonKey(name: "transferId") String transferId)
        moneyPoolPayoutTransfer,
  }) {
    return peer2peer(transferDetails, createdAt, status, type, transferId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            TransferDetails transferDetails,
            dynamic createdAt,
            TransferStatus status,
            TransferType type,
            @JsonKey(name: "transferId") String transferId)?
        peer2peer,
    TResult Function(
            TransferDetails transferDetails,
            ConciseProjectInfo projectInfo,
            dynamic createdAt,
            TransferStatus status,
            TransferType type,
            @JsonKey(name: "transferId") String transferId)?
        donation,
    TResult Function(
            TransferDetails transferDetails,
            ConciseMoneyPoolInfo moneyPoolInfo,
            dynamic createdAt,
            TransferStatus status,
            TransferType type,
            @JsonKey(name: "transferId") String transferId)?
        moneyPoolContribution,
    TResult Function(
            TransferDetails transferDetails,
            ConciseMoneyPoolInfo moneyPoolInfo,
            String payoutId,
            dynamic createdAt,
            TransferStatus status,
            TransferType type,
            @JsonKey(name: "transferId") String transferId)?
        moneyPoolPayoutTransfer,
    required TResult orElse(),
  }) {
    if (peer2peer != null) {
      return peer2peer(transferDetails, createdAt, status, type, transferId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Peer2PeerTransfer value) peer2peer,
    required TResult Function(Donation value) donation,
    required TResult Function(MoneyPoolContribution value)
        moneyPoolContribution,
    required TResult Function(MoneyPoolPayoutTransfer value)
        moneyPoolPayoutTransfer,
  }) {
    return peer2peer(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Peer2PeerTransfer value)? peer2peer,
    TResult Function(Donation value)? donation,
    TResult Function(MoneyPoolContribution value)? moneyPoolContribution,
    TResult Function(MoneyPoolPayoutTransfer value)? moneyPoolPayoutTransfer,
    required TResult orElse(),
  }) {
    if (peer2peer != null) {
      return peer2peer(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$_$Peer2PeerTransferToJson(this)..['runtimeType'] = 'peer2peer';
  }
}

abstract class Peer2PeerTransfer extends MoneyTransfer {
  const factory Peer2PeerTransfer(
      {required TransferDetails transferDetails,
      dynamic createdAt,
      TransferStatus status,
      TransferType type,
      @JsonKey(name: "transferId") String transferId}) = _$Peer2PeerTransfer;
  const Peer2PeerTransfer._() : super._();

  factory Peer2PeerTransfer.fromJson(Map<String, dynamic> json) =
      _$Peer2PeerTransfer.fromJson;

  @override
  TransferDetails get transferDetails => throw _privateConstructorUsedError;
  @override
  dynamic get createdAt => throw _privateConstructorUsedError;
  @override
  TransferStatus get status => throw _privateConstructorUsedError;
  @override
  TransferType get type => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: "transferId")
  String get transferId => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  $Peer2PeerTransferCopyWith<Peer2PeerTransfer> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DonationCopyWith<$Res> implements $MoneyTransferCopyWith<$Res> {
  factory $DonationCopyWith(Donation value, $Res Function(Donation) then) =
      _$DonationCopyWithImpl<$Res>;
  @override
  $Res call(
      {TransferDetails transferDetails,
      ConciseProjectInfo projectInfo,
      dynamic createdAt,
      TransferStatus status,
      TransferType type,
      @JsonKey(name: "transferId") String transferId});

  @override
  $TransferDetailsCopyWith<$Res> get transferDetails;
  $ConciseProjectInfoCopyWith<$Res> get projectInfo;
}

/// @nodoc
class _$DonationCopyWithImpl<$Res> extends _$MoneyTransferCopyWithImpl<$Res>
    implements $DonationCopyWith<$Res> {
  _$DonationCopyWithImpl(Donation _value, $Res Function(Donation) _then)
      : super(_value, (v) => _then(v as Donation));

  @override
  Donation get _value => super._value as Donation;

  @override
  $Res call({
    Object? transferDetails = freezed,
    Object? projectInfo = freezed,
    Object? createdAt = freezed,
    Object? status = freezed,
    Object? type = freezed,
    Object? transferId = freezed,
  }) {
    return _then(Donation(
      transferDetails: transferDetails == freezed
          ? _value.transferDetails
          : transferDetails // ignore: cast_nullable_to_non_nullable
              as TransferDetails,
      projectInfo: projectInfo == freezed
          ? _value.projectInfo
          : projectInfo // ignore: cast_nullable_to_non_nullable
              as ConciseProjectInfo,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as dynamic,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as TransferStatus,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as TransferType,
      transferId: transferId == freezed
          ? _value.transferId
          : transferId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }

  @override
  $ConciseProjectInfoCopyWith<$Res> get projectInfo {
    return $ConciseProjectInfoCopyWith<$Res>(_value.projectInfo, (value) {
      return _then(_value.copyWith(projectInfo: value));
    });
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$Donation extends Donation {
  const _$Donation(
      {required this.transferDetails,
      required this.projectInfo,
      this.createdAt = "",
      this.status = TransferStatus.Initialized,
      this.type = TransferType.User2Project,
      @JsonKey(name: "transferId") this.transferId = "placeholder"})
      : super._();

  factory _$Donation.fromJson(Map<String, dynamic> json) =>
      _$_$DonationFromJson(json);

  @override
  final TransferDetails transferDetails;
  @override
  final ConciseProjectInfo projectInfo;
  @JsonKey(defaultValue: "")
  @override
  final dynamic createdAt;
  @JsonKey(defaultValue: TransferStatus.Initialized)
  @override
  final TransferStatus status;
  @JsonKey(defaultValue: TransferType.User2Project)
  @override
  final TransferType type;
  @override
  @JsonKey(name: "transferId")
  final String transferId;

  @override
  String toString() {
    return 'MoneyTransfer.donation(transferDetails: $transferDetails, projectInfo: $projectInfo, createdAt: $createdAt, status: $status, type: $type, transferId: $transferId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Donation &&
            (identical(other.transferDetails, transferDetails) ||
                const DeepCollectionEquality()
                    .equals(other.transferDetails, transferDetails)) &&
            (identical(other.projectInfo, projectInfo) ||
                const DeepCollectionEquality()
                    .equals(other.projectInfo, projectInfo)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality()
                    .equals(other.createdAt, createdAt)) &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)) &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.transferId, transferId) ||
                const DeepCollectionEquality()
                    .equals(other.transferId, transferId)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(transferDetails) ^
      const DeepCollectionEquality().hash(projectInfo) ^
      const DeepCollectionEquality().hash(createdAt) ^
      const DeepCollectionEquality().hash(status) ^
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(transferId);

  @JsonKey(ignore: true)
  @override
  $DonationCopyWith<Donation> get copyWith =>
      _$DonationCopyWithImpl<Donation>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            TransferDetails transferDetails,
            dynamic createdAt,
            TransferStatus status,
            TransferType type,
            @JsonKey(name: "transferId") String transferId)
        peer2peer,
    required TResult Function(
            TransferDetails transferDetails,
            ConciseProjectInfo projectInfo,
            dynamic createdAt,
            TransferStatus status,
            TransferType type,
            @JsonKey(name: "transferId") String transferId)
        donation,
    required TResult Function(
            TransferDetails transferDetails,
            ConciseMoneyPoolInfo moneyPoolInfo,
            dynamic createdAt,
            TransferStatus status,
            TransferType type,
            @JsonKey(name: "transferId") String transferId)
        moneyPoolContribution,
    required TResult Function(
            TransferDetails transferDetails,
            ConciseMoneyPoolInfo moneyPoolInfo,
            String payoutId,
            dynamic createdAt,
            TransferStatus status,
            TransferType type,
            @JsonKey(name: "transferId") String transferId)
        moneyPoolPayoutTransfer,
  }) {
    return donation(
        transferDetails, projectInfo, createdAt, status, type, transferId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            TransferDetails transferDetails,
            dynamic createdAt,
            TransferStatus status,
            TransferType type,
            @JsonKey(name: "transferId") String transferId)?
        peer2peer,
    TResult Function(
            TransferDetails transferDetails,
            ConciseProjectInfo projectInfo,
            dynamic createdAt,
            TransferStatus status,
            TransferType type,
            @JsonKey(name: "transferId") String transferId)?
        donation,
    TResult Function(
            TransferDetails transferDetails,
            ConciseMoneyPoolInfo moneyPoolInfo,
            dynamic createdAt,
            TransferStatus status,
            TransferType type,
            @JsonKey(name: "transferId") String transferId)?
        moneyPoolContribution,
    TResult Function(
            TransferDetails transferDetails,
            ConciseMoneyPoolInfo moneyPoolInfo,
            String payoutId,
            dynamic createdAt,
            TransferStatus status,
            TransferType type,
            @JsonKey(name: "transferId") String transferId)?
        moneyPoolPayoutTransfer,
    required TResult orElse(),
  }) {
    if (donation != null) {
      return donation(
          transferDetails, projectInfo, createdAt, status, type, transferId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Peer2PeerTransfer value) peer2peer,
    required TResult Function(Donation value) donation,
    required TResult Function(MoneyPoolContribution value)
        moneyPoolContribution,
    required TResult Function(MoneyPoolPayoutTransfer value)
        moneyPoolPayoutTransfer,
  }) {
    return donation(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Peer2PeerTransfer value)? peer2peer,
    TResult Function(Donation value)? donation,
    TResult Function(MoneyPoolContribution value)? moneyPoolContribution,
    TResult Function(MoneyPoolPayoutTransfer value)? moneyPoolPayoutTransfer,
    required TResult orElse(),
  }) {
    if (donation != null) {
      return donation(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$_$DonationToJson(this)..['runtimeType'] = 'donation';
  }
}

abstract class Donation extends MoneyTransfer {
  const factory Donation(
      {required TransferDetails transferDetails,
      required ConciseProjectInfo projectInfo,
      dynamic createdAt,
      TransferStatus status,
      TransferType type,
      @JsonKey(name: "transferId") String transferId}) = _$Donation;
  const Donation._() : super._();

  factory Donation.fromJson(Map<String, dynamic> json) = _$Donation.fromJson;

  @override
  TransferDetails get transferDetails => throw _privateConstructorUsedError;
  ConciseProjectInfo get projectInfo => throw _privateConstructorUsedError;
  @override
  dynamic get createdAt => throw _privateConstructorUsedError;
  @override
  TransferStatus get status => throw _privateConstructorUsedError;
  @override
  TransferType get type => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: "transferId")
  String get transferId => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  $DonationCopyWith<Donation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MoneyPoolContributionCopyWith<$Res>
    implements $MoneyTransferCopyWith<$Res> {
  factory $MoneyPoolContributionCopyWith(MoneyPoolContribution value,
          $Res Function(MoneyPoolContribution) then) =
      _$MoneyPoolContributionCopyWithImpl<$Res>;
  @override
  $Res call(
      {TransferDetails transferDetails,
      ConciseMoneyPoolInfo moneyPoolInfo,
      dynamic createdAt,
      TransferStatus status,
      TransferType type,
      @JsonKey(name: "transferId") String transferId});

  @override
  $TransferDetailsCopyWith<$Res> get transferDetails;
  $ConciseMoneyPoolInfoCopyWith<$Res> get moneyPoolInfo;
}

/// @nodoc
class _$MoneyPoolContributionCopyWithImpl<$Res>
    extends _$MoneyTransferCopyWithImpl<$Res>
    implements $MoneyPoolContributionCopyWith<$Res> {
  _$MoneyPoolContributionCopyWithImpl(
      MoneyPoolContribution _value, $Res Function(MoneyPoolContribution) _then)
      : super(_value, (v) => _then(v as MoneyPoolContribution));

  @override
  MoneyPoolContribution get _value => super._value as MoneyPoolContribution;

  @override
  $Res call({
    Object? transferDetails = freezed,
    Object? moneyPoolInfo = freezed,
    Object? createdAt = freezed,
    Object? status = freezed,
    Object? type = freezed,
    Object? transferId = freezed,
  }) {
    return _then(MoneyPoolContribution(
      transferDetails: transferDetails == freezed
          ? _value.transferDetails
          : transferDetails // ignore: cast_nullable_to_non_nullable
              as TransferDetails,
      moneyPoolInfo: moneyPoolInfo == freezed
          ? _value.moneyPoolInfo
          : moneyPoolInfo // ignore: cast_nullable_to_non_nullable
              as ConciseMoneyPoolInfo,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as dynamic,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as TransferStatus,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as TransferType,
      transferId: transferId == freezed
          ? _value.transferId
          : transferId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }

  @override
  $ConciseMoneyPoolInfoCopyWith<$Res> get moneyPoolInfo {
    return $ConciseMoneyPoolInfoCopyWith<$Res>(_value.moneyPoolInfo, (value) {
      return _then(_value.copyWith(moneyPoolInfo: value));
    });
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$MoneyPoolContribution extends MoneyPoolContribution {
  const _$MoneyPoolContribution(
      {required this.transferDetails,
      required this.moneyPoolInfo,
      this.createdAt = "",
      this.status = TransferStatus.Initialized,
      this.type = TransferType.User2MoneyPool,
      @JsonKey(name: "transferId") this.transferId = "placeholder"})
      : super._();

  factory _$MoneyPoolContribution.fromJson(Map<String, dynamic> json) =>
      _$_$MoneyPoolContributionFromJson(json);

  @override
  final TransferDetails transferDetails;
  @override
  final ConciseMoneyPoolInfo moneyPoolInfo;
  @JsonKey(defaultValue: "")
  @override
  final dynamic createdAt;
  @JsonKey(defaultValue: TransferStatus.Initialized)
  @override
  final TransferStatus status;
  @JsonKey(defaultValue: TransferType.User2MoneyPool)
  @override
  final TransferType type;
  @override
  @JsonKey(name: "transferId")
  final String transferId;

  @override
  String toString() {
    return 'MoneyTransfer.moneyPoolContribution(transferDetails: $transferDetails, moneyPoolInfo: $moneyPoolInfo, createdAt: $createdAt, status: $status, type: $type, transferId: $transferId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is MoneyPoolContribution &&
            (identical(other.transferDetails, transferDetails) ||
                const DeepCollectionEquality()
                    .equals(other.transferDetails, transferDetails)) &&
            (identical(other.moneyPoolInfo, moneyPoolInfo) ||
                const DeepCollectionEquality()
                    .equals(other.moneyPoolInfo, moneyPoolInfo)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality()
                    .equals(other.createdAt, createdAt)) &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)) &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.transferId, transferId) ||
                const DeepCollectionEquality()
                    .equals(other.transferId, transferId)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(transferDetails) ^
      const DeepCollectionEquality().hash(moneyPoolInfo) ^
      const DeepCollectionEquality().hash(createdAt) ^
      const DeepCollectionEquality().hash(status) ^
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(transferId);

  @JsonKey(ignore: true)
  @override
  $MoneyPoolContributionCopyWith<MoneyPoolContribution> get copyWith =>
      _$MoneyPoolContributionCopyWithImpl<MoneyPoolContribution>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            TransferDetails transferDetails,
            dynamic createdAt,
            TransferStatus status,
            TransferType type,
            @JsonKey(name: "transferId") String transferId)
        peer2peer,
    required TResult Function(
            TransferDetails transferDetails,
            ConciseProjectInfo projectInfo,
            dynamic createdAt,
            TransferStatus status,
            TransferType type,
            @JsonKey(name: "transferId") String transferId)
        donation,
    required TResult Function(
            TransferDetails transferDetails,
            ConciseMoneyPoolInfo moneyPoolInfo,
            dynamic createdAt,
            TransferStatus status,
            TransferType type,
            @JsonKey(name: "transferId") String transferId)
        moneyPoolContribution,
    required TResult Function(
            TransferDetails transferDetails,
            ConciseMoneyPoolInfo moneyPoolInfo,
            String payoutId,
            dynamic createdAt,
            TransferStatus status,
            TransferType type,
            @JsonKey(name: "transferId") String transferId)
        moneyPoolPayoutTransfer,
  }) {
    return moneyPoolContribution(
        transferDetails, moneyPoolInfo, createdAt, status, type, transferId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            TransferDetails transferDetails,
            dynamic createdAt,
            TransferStatus status,
            TransferType type,
            @JsonKey(name: "transferId") String transferId)?
        peer2peer,
    TResult Function(
            TransferDetails transferDetails,
            ConciseProjectInfo projectInfo,
            dynamic createdAt,
            TransferStatus status,
            TransferType type,
            @JsonKey(name: "transferId") String transferId)?
        donation,
    TResult Function(
            TransferDetails transferDetails,
            ConciseMoneyPoolInfo moneyPoolInfo,
            dynamic createdAt,
            TransferStatus status,
            TransferType type,
            @JsonKey(name: "transferId") String transferId)?
        moneyPoolContribution,
    TResult Function(
            TransferDetails transferDetails,
            ConciseMoneyPoolInfo moneyPoolInfo,
            String payoutId,
            dynamic createdAt,
            TransferStatus status,
            TransferType type,
            @JsonKey(name: "transferId") String transferId)?
        moneyPoolPayoutTransfer,
    required TResult orElse(),
  }) {
    if (moneyPoolContribution != null) {
      return moneyPoolContribution(
          transferDetails, moneyPoolInfo, createdAt, status, type, transferId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Peer2PeerTransfer value) peer2peer,
    required TResult Function(Donation value) donation,
    required TResult Function(MoneyPoolContribution value)
        moneyPoolContribution,
    required TResult Function(MoneyPoolPayoutTransfer value)
        moneyPoolPayoutTransfer,
  }) {
    return moneyPoolContribution(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Peer2PeerTransfer value)? peer2peer,
    TResult Function(Donation value)? donation,
    TResult Function(MoneyPoolContribution value)? moneyPoolContribution,
    TResult Function(MoneyPoolPayoutTransfer value)? moneyPoolPayoutTransfer,
    required TResult orElse(),
  }) {
    if (moneyPoolContribution != null) {
      return moneyPoolContribution(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$_$MoneyPoolContributionToJson(this)
      ..['runtimeType'] = 'moneyPoolContribution';
  }
}

abstract class MoneyPoolContribution extends MoneyTransfer {
  const factory MoneyPoolContribution(
          {required TransferDetails transferDetails,
          required ConciseMoneyPoolInfo moneyPoolInfo,
          dynamic createdAt,
          TransferStatus status,
          TransferType type,
          @JsonKey(name: "transferId") String transferId}) =
      _$MoneyPoolContribution;
  const MoneyPoolContribution._() : super._();

  factory MoneyPoolContribution.fromJson(Map<String, dynamic> json) =
      _$MoneyPoolContribution.fromJson;

  @override
  TransferDetails get transferDetails => throw _privateConstructorUsedError;
  ConciseMoneyPoolInfo get moneyPoolInfo => throw _privateConstructorUsedError;
  @override
  dynamic get createdAt => throw _privateConstructorUsedError;
  @override
  TransferStatus get status => throw _privateConstructorUsedError;
  @override
  TransferType get type => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: "transferId")
  String get transferId => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  $MoneyPoolContributionCopyWith<MoneyPoolContribution> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MoneyPoolPayoutTransferCopyWith<$Res>
    implements $MoneyTransferCopyWith<$Res> {
  factory $MoneyPoolPayoutTransferCopyWith(MoneyPoolPayoutTransfer value,
          $Res Function(MoneyPoolPayoutTransfer) then) =
      _$MoneyPoolPayoutTransferCopyWithImpl<$Res>;
  @override
  $Res call(
      {TransferDetails transferDetails,
      ConciseMoneyPoolInfo moneyPoolInfo,
      String payoutId,
      dynamic createdAt,
      TransferStatus status,
      TransferType type,
      @JsonKey(name: "transferId") String transferId});

  @override
  $TransferDetailsCopyWith<$Res> get transferDetails;
  $ConciseMoneyPoolInfoCopyWith<$Res> get moneyPoolInfo;
}

/// @nodoc
class _$MoneyPoolPayoutTransferCopyWithImpl<$Res>
    extends _$MoneyTransferCopyWithImpl<$Res>
    implements $MoneyPoolPayoutTransferCopyWith<$Res> {
  _$MoneyPoolPayoutTransferCopyWithImpl(MoneyPoolPayoutTransfer _value,
      $Res Function(MoneyPoolPayoutTransfer) _then)
      : super(_value, (v) => _then(v as MoneyPoolPayoutTransfer));

  @override
  MoneyPoolPayoutTransfer get _value => super._value as MoneyPoolPayoutTransfer;

  @override
  $Res call({
    Object? transferDetails = freezed,
    Object? moneyPoolInfo = freezed,
    Object? payoutId = freezed,
    Object? createdAt = freezed,
    Object? status = freezed,
    Object? type = freezed,
    Object? transferId = freezed,
  }) {
    return _then(MoneyPoolPayoutTransfer(
      transferDetails: transferDetails == freezed
          ? _value.transferDetails
          : transferDetails // ignore: cast_nullable_to_non_nullable
              as TransferDetails,
      moneyPoolInfo: moneyPoolInfo == freezed
          ? _value.moneyPoolInfo
          : moneyPoolInfo // ignore: cast_nullable_to_non_nullable
              as ConciseMoneyPoolInfo,
      payoutId: payoutId == freezed
          ? _value.payoutId
          : payoutId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as dynamic,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as TransferStatus,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as TransferType,
      transferId: transferId == freezed
          ? _value.transferId
          : transferId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }

  @override
  $ConciseMoneyPoolInfoCopyWith<$Res> get moneyPoolInfo {
    return $ConciseMoneyPoolInfoCopyWith<$Res>(_value.moneyPoolInfo, (value) {
      return _then(_value.copyWith(moneyPoolInfo: value));
    });
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$MoneyPoolPayoutTransfer extends MoneyPoolPayoutTransfer {
  const _$MoneyPoolPayoutTransfer(
      {required this.transferDetails,
      required this.moneyPoolInfo,
      required this.payoutId,
      this.createdAt = "",
      this.status = TransferStatus.Initialized,
      this.type = TransferType.MoneyPool2User,
      @JsonKey(name: "transferId") this.transferId = "placeholder"})
      : super._();

  factory _$MoneyPoolPayoutTransfer.fromJson(Map<String, dynamic> json) =>
      _$_$MoneyPoolPayoutTransferFromJson(json);

  @override
  final TransferDetails transferDetails;
  @override
  final ConciseMoneyPoolInfo moneyPoolInfo;
  @override // id of money pool payout that stores
// entire info of money pool payout
  final String payoutId;
  @JsonKey(defaultValue: "")
  @override
  final dynamic createdAt;
  @JsonKey(defaultValue: TransferStatus.Initialized)
  @override
  final TransferStatus status;
  @JsonKey(defaultValue: TransferType.MoneyPool2User)
  @override
  final TransferType type;
  @override
  @JsonKey(name: "transferId")
  final String transferId;

  @override
  String toString() {
    return 'MoneyTransfer.moneyPoolPayoutTransfer(transferDetails: $transferDetails, moneyPoolInfo: $moneyPoolInfo, payoutId: $payoutId, createdAt: $createdAt, status: $status, type: $type, transferId: $transferId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is MoneyPoolPayoutTransfer &&
            (identical(other.transferDetails, transferDetails) ||
                const DeepCollectionEquality()
                    .equals(other.transferDetails, transferDetails)) &&
            (identical(other.moneyPoolInfo, moneyPoolInfo) ||
                const DeepCollectionEquality()
                    .equals(other.moneyPoolInfo, moneyPoolInfo)) &&
            (identical(other.payoutId, payoutId) ||
                const DeepCollectionEquality()
                    .equals(other.payoutId, payoutId)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality()
                    .equals(other.createdAt, createdAt)) &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)) &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.transferId, transferId) ||
                const DeepCollectionEquality()
                    .equals(other.transferId, transferId)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(transferDetails) ^
      const DeepCollectionEquality().hash(moneyPoolInfo) ^
      const DeepCollectionEquality().hash(payoutId) ^
      const DeepCollectionEquality().hash(createdAt) ^
      const DeepCollectionEquality().hash(status) ^
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(transferId);

  @JsonKey(ignore: true)
  @override
  $MoneyPoolPayoutTransferCopyWith<MoneyPoolPayoutTransfer> get copyWith =>
      _$MoneyPoolPayoutTransferCopyWithImpl<MoneyPoolPayoutTransfer>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            TransferDetails transferDetails,
            dynamic createdAt,
            TransferStatus status,
            TransferType type,
            @JsonKey(name: "transferId") String transferId)
        peer2peer,
    required TResult Function(
            TransferDetails transferDetails,
            ConciseProjectInfo projectInfo,
            dynamic createdAt,
            TransferStatus status,
            TransferType type,
            @JsonKey(name: "transferId") String transferId)
        donation,
    required TResult Function(
            TransferDetails transferDetails,
            ConciseMoneyPoolInfo moneyPoolInfo,
            dynamic createdAt,
            TransferStatus status,
            TransferType type,
            @JsonKey(name: "transferId") String transferId)
        moneyPoolContribution,
    required TResult Function(
            TransferDetails transferDetails,
            ConciseMoneyPoolInfo moneyPoolInfo,
            String payoutId,
            dynamic createdAt,
            TransferStatus status,
            TransferType type,
            @JsonKey(name: "transferId") String transferId)
        moneyPoolPayoutTransfer,
  }) {
    return moneyPoolPayoutTransfer(transferDetails, moneyPoolInfo, payoutId,
        createdAt, status, type, transferId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            TransferDetails transferDetails,
            dynamic createdAt,
            TransferStatus status,
            TransferType type,
            @JsonKey(name: "transferId") String transferId)?
        peer2peer,
    TResult Function(
            TransferDetails transferDetails,
            ConciseProjectInfo projectInfo,
            dynamic createdAt,
            TransferStatus status,
            TransferType type,
            @JsonKey(name: "transferId") String transferId)?
        donation,
    TResult Function(
            TransferDetails transferDetails,
            ConciseMoneyPoolInfo moneyPoolInfo,
            dynamic createdAt,
            TransferStatus status,
            TransferType type,
            @JsonKey(name: "transferId") String transferId)?
        moneyPoolContribution,
    TResult Function(
            TransferDetails transferDetails,
            ConciseMoneyPoolInfo moneyPoolInfo,
            String payoutId,
            dynamic createdAt,
            TransferStatus status,
            TransferType type,
            @JsonKey(name: "transferId") String transferId)?
        moneyPoolPayoutTransfer,
    required TResult orElse(),
  }) {
    if (moneyPoolPayoutTransfer != null) {
      return moneyPoolPayoutTransfer(transferDetails, moneyPoolInfo, payoutId,
          createdAt, status, type, transferId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Peer2PeerTransfer value) peer2peer,
    required TResult Function(Donation value) donation,
    required TResult Function(MoneyPoolContribution value)
        moneyPoolContribution,
    required TResult Function(MoneyPoolPayoutTransfer value)
        moneyPoolPayoutTransfer,
  }) {
    return moneyPoolPayoutTransfer(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Peer2PeerTransfer value)? peer2peer,
    TResult Function(Donation value)? donation,
    TResult Function(MoneyPoolContribution value)? moneyPoolContribution,
    TResult Function(MoneyPoolPayoutTransfer value)? moneyPoolPayoutTransfer,
    required TResult orElse(),
  }) {
    if (moneyPoolPayoutTransfer != null) {
      return moneyPoolPayoutTransfer(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$_$MoneyPoolPayoutTransferToJson(this)
      ..['runtimeType'] = 'moneyPoolPayoutTransfer';
  }
}

abstract class MoneyPoolPayoutTransfer extends MoneyTransfer {
  const factory MoneyPoolPayoutTransfer(
          {required TransferDetails transferDetails,
          required ConciseMoneyPoolInfo moneyPoolInfo,
          required String payoutId,
          dynamic createdAt,
          TransferStatus status,
          TransferType type,
          @JsonKey(name: "transferId") String transferId}) =
      _$MoneyPoolPayoutTransfer;
  const MoneyPoolPayoutTransfer._() : super._();

  factory MoneyPoolPayoutTransfer.fromJson(Map<String, dynamic> json) =
      _$MoneyPoolPayoutTransfer.fromJson;

  @override
  TransferDetails get transferDetails => throw _privateConstructorUsedError;
  ConciseMoneyPoolInfo get moneyPoolInfo =>
      throw _privateConstructorUsedError; // id of money pool payout that stores
// entire info of money pool payout
  String get payoutId => throw _privateConstructorUsedError;
  @override
  dynamic get createdAt => throw _privateConstructorUsedError;
  @override
  TransferStatus get status => throw _privateConstructorUsedError;
  @override
  TransferType get type => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: "transferId")
  String get transferId => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  $MoneyPoolPayoutTransferCopyWith<MoneyPoolPayoutTransfer> get copyWith =>
      throw _privateConstructorUsedError;
}
