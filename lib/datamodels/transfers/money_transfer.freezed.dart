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

    default:
      throw FallThroughError();
  }
}

/// @nodoc
class _$MoneyTransferTearOff {
  const _$MoneyTransferTearOff();

  Peer2PeerTransfer peer2peer(
      {required TransferDetails transferDetails,
      required dynamic createdAt,
      TransferStatus status = TransferStatus.Initialized,
      TransferType type = TransferType.Peer2Peer,
      @JsonKey(name: "transferId", toJson: MoneyTransfer._checkIftransferIdIsSet)
          String transferId = "placeholder"}) {
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
      required ProjectPreviewDetails projectPreviewDetails,
      required dynamic createdAt,
      TransferStatus status = TransferStatus.Initialized,
      TransferType type = TransferType.Donation,
      @JsonKey(name: "transferId", toJson: MoneyTransfer._checkIftransferIdIsSet)
          String transferId = "placeholder"}) {
    return Donation(
      transferDetails: transferDetails,
      projectPreviewDetails: projectPreviewDetails,
      createdAt: createdAt,
      status: status,
      type: type,
      transferId: transferId,
    );
  }

  MoneyPoolContribution moneyPoolContribution(
      {required TransferDetails transferDetails,
      required dynamic createdAt,
      TransferStatus status = TransferStatus.Initialized,
      TransferType type = TransferType.MoneyPoolContribution,
      @JsonKey(name: "transferId", toJson: MoneyTransfer._checkIftransferIdIsSet)
          String transferId = "placeholder"}) {
    return MoneyPoolContribution(
      transferDetails: transferDetails,
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
  @JsonKey(name: "transferId", toJson: MoneyTransfer._checkIftransferIdIsSet)
  String get transferId => throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            TransferDetails transferDetails,
            dynamic createdAt,
            TransferStatus status,
            TransferType type,
            @JsonKey(name: "transferId", toJson: MoneyTransfer._checkIftransferIdIsSet)
                String transferId)
        peer2peer,
    required TResult Function(
            TransferDetails transferDetails,
            ProjectPreviewDetails projectPreviewDetails,
            dynamic createdAt,
            TransferStatus status,
            TransferType type,
            @JsonKey(name: "transferId", toJson: MoneyTransfer._checkIftransferIdIsSet)
                String transferId)
        donation,
    required TResult Function(
            TransferDetails transferDetails,
            dynamic createdAt,
            TransferStatus status,
            TransferType type,
            @JsonKey(name: "transferId", toJson: MoneyTransfer._checkIftransferIdIsSet)
                String transferId)
        moneyPoolContribution,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            TransferDetails transferDetails,
            dynamic createdAt,
            TransferStatus status,
            TransferType type,
            @JsonKey(name: "transferId", toJson: MoneyTransfer._checkIftransferIdIsSet)
                String transferId)?
        peer2peer,
    TResult Function(
            TransferDetails transferDetails,
            ProjectPreviewDetails projectPreviewDetails,
            dynamic createdAt,
            TransferStatus status,
            TransferType type,
            @JsonKey(name: "transferId", toJson: MoneyTransfer._checkIftransferIdIsSet)
                String transferId)?
        donation,
    TResult Function(
            TransferDetails transferDetails,
            dynamic createdAt,
            TransferStatus status,
            TransferType type,
            @JsonKey(name: "transferId", toJson: MoneyTransfer._checkIftransferIdIsSet)
                String transferId)?
        moneyPoolContribution,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Peer2PeerTransfer value) peer2peer,
    required TResult Function(Donation value) donation,
    required TResult Function(MoneyPoolContribution value)
        moneyPoolContribution,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Peer2PeerTransfer value)? peer2peer,
    TResult Function(Donation value)? donation,
    TResult Function(MoneyPoolContribution value)? moneyPoolContribution,
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
      @JsonKey(name: "transferId", toJson: MoneyTransfer._checkIftransferIdIsSet)
          String transferId});

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
      @JsonKey(name: "transferId", toJson: MoneyTransfer._checkIftransferIdIsSet)
          String transferId});

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
      required this.createdAt,
      this.status = TransferStatus.Initialized,
      this.type = TransferType.Peer2Peer,
      @JsonKey(name: "transferId", toJson: MoneyTransfer._checkIftransferIdIsSet)
          this.transferId = "placeholder"})
      : super._();

  factory _$Peer2PeerTransfer.fromJson(Map<String, dynamic> json) =>
      _$_$Peer2PeerTransferFromJson(json);

  @override
  final TransferDetails transferDetails;
  @override
  final dynamic createdAt;
  @JsonKey(defaultValue: TransferStatus.Initialized)
  @override
  final TransferStatus status;
  @JsonKey(defaultValue: TransferType.Peer2Peer)
  @override
  final TransferType type;
  @override
  @JsonKey(name: "transferId", toJson: MoneyTransfer._checkIftransferIdIsSet)
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
            @JsonKey(name: "transferId", toJson: MoneyTransfer._checkIftransferIdIsSet)
                String transferId)
        peer2peer,
    required TResult Function(
            TransferDetails transferDetails,
            ProjectPreviewDetails projectPreviewDetails,
            dynamic createdAt,
            TransferStatus status,
            TransferType type,
            @JsonKey(name: "transferId", toJson: MoneyTransfer._checkIftransferIdIsSet)
                String transferId)
        donation,
    required TResult Function(
            TransferDetails transferDetails,
            dynamic createdAt,
            TransferStatus status,
            TransferType type,
            @JsonKey(name: "transferId", toJson: MoneyTransfer._checkIftransferIdIsSet)
                String transferId)
        moneyPoolContribution,
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
            @JsonKey(name: "transferId", toJson: MoneyTransfer._checkIftransferIdIsSet)
                String transferId)?
        peer2peer,
    TResult Function(
            TransferDetails transferDetails,
            ProjectPreviewDetails projectPreviewDetails,
            dynamic createdAt,
            TransferStatus status,
            TransferType type,
            @JsonKey(name: "transferId", toJson: MoneyTransfer._checkIftransferIdIsSet)
                String transferId)?
        donation,
    TResult Function(
            TransferDetails transferDetails,
            dynamic createdAt,
            TransferStatus status,
            TransferType type,
            @JsonKey(name: "transferId", toJson: MoneyTransfer._checkIftransferIdIsSet)
                String transferId)?
        moneyPoolContribution,
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
  }) {
    return peer2peer(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Peer2PeerTransfer value)? peer2peer,
    TResult Function(Donation value)? donation,
    TResult Function(MoneyPoolContribution value)? moneyPoolContribution,
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
      required dynamic createdAt,
      TransferStatus status,
      TransferType type,
      @JsonKey(name: "transferId", toJson: MoneyTransfer._checkIftransferIdIsSet)
          String transferId}) = _$Peer2PeerTransfer;
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
  @JsonKey(name: "transferId", toJson: MoneyTransfer._checkIftransferIdIsSet)
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
      ProjectPreviewDetails projectPreviewDetails,
      dynamic createdAt,
      TransferStatus status,
      TransferType type,
      @JsonKey(name: "transferId", toJson: MoneyTransfer._checkIftransferIdIsSet)
          String transferId});

  @override
  $TransferDetailsCopyWith<$Res> get transferDetails;
  $ProjectPreviewDetailsCopyWith<$Res> get projectPreviewDetails;
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
    Object? projectPreviewDetails = freezed,
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
      projectPreviewDetails: projectPreviewDetails == freezed
          ? _value.projectPreviewDetails
          : projectPreviewDetails // ignore: cast_nullable_to_non_nullable
              as ProjectPreviewDetails,
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
  $ProjectPreviewDetailsCopyWith<$Res> get projectPreviewDetails {
    return $ProjectPreviewDetailsCopyWith<$Res>(_value.projectPreviewDetails,
        (value) {
      return _then(_value.copyWith(projectPreviewDetails: value));
    });
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$Donation extends Donation {
  const _$Donation(
      {required this.transferDetails,
      required this.projectPreviewDetails,
      required this.createdAt,
      this.status = TransferStatus.Initialized,
      this.type = TransferType.Donation,
      @JsonKey(name: "transferId", toJson: MoneyTransfer._checkIftransferIdIsSet)
          this.transferId = "placeholder"})
      : super._();

  factory _$Donation.fromJson(Map<String, dynamic> json) =>
      _$_$DonationFromJson(json);

  @override
  final TransferDetails transferDetails;
  @override
  final ProjectPreviewDetails projectPreviewDetails;
  @override
  final dynamic createdAt;
  @JsonKey(defaultValue: TransferStatus.Initialized)
  @override
  final TransferStatus status;
  @JsonKey(defaultValue: TransferType.Donation)
  @override
  final TransferType type;
  @override
  @JsonKey(name: "transferId", toJson: MoneyTransfer._checkIftransferIdIsSet)
  final String transferId;

  @override
  String toString() {
    return 'MoneyTransfer.donation(transferDetails: $transferDetails, projectPreviewDetails: $projectPreviewDetails, createdAt: $createdAt, status: $status, type: $type, transferId: $transferId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Donation &&
            (identical(other.transferDetails, transferDetails) ||
                const DeepCollectionEquality()
                    .equals(other.transferDetails, transferDetails)) &&
            (identical(other.projectPreviewDetails, projectPreviewDetails) ||
                const DeepCollectionEquality().equals(
                    other.projectPreviewDetails, projectPreviewDetails)) &&
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
      const DeepCollectionEquality().hash(projectPreviewDetails) ^
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
            @JsonKey(name: "transferId", toJson: MoneyTransfer._checkIftransferIdIsSet)
                String transferId)
        peer2peer,
    required TResult Function(
            TransferDetails transferDetails,
            ProjectPreviewDetails projectPreviewDetails,
            dynamic createdAt,
            TransferStatus status,
            TransferType type,
            @JsonKey(name: "transferId", toJson: MoneyTransfer._checkIftransferIdIsSet)
                String transferId)
        donation,
    required TResult Function(
            TransferDetails transferDetails,
            dynamic createdAt,
            TransferStatus status,
            TransferType type,
            @JsonKey(name: "transferId", toJson: MoneyTransfer._checkIftransferIdIsSet)
                String transferId)
        moneyPoolContribution,
  }) {
    return donation(transferDetails, projectPreviewDetails, createdAt, status,
        type, transferId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            TransferDetails transferDetails,
            dynamic createdAt,
            TransferStatus status,
            TransferType type,
            @JsonKey(name: "transferId", toJson: MoneyTransfer._checkIftransferIdIsSet)
                String transferId)?
        peer2peer,
    TResult Function(
            TransferDetails transferDetails,
            ProjectPreviewDetails projectPreviewDetails,
            dynamic createdAt,
            TransferStatus status,
            TransferType type,
            @JsonKey(name: "transferId", toJson: MoneyTransfer._checkIftransferIdIsSet)
                String transferId)?
        donation,
    TResult Function(
            TransferDetails transferDetails,
            dynamic createdAt,
            TransferStatus status,
            TransferType type,
            @JsonKey(name: "transferId", toJson: MoneyTransfer._checkIftransferIdIsSet)
                String transferId)?
        moneyPoolContribution,
    required TResult orElse(),
  }) {
    if (donation != null) {
      return donation(transferDetails, projectPreviewDetails, createdAt, status,
          type, transferId);
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
  }) {
    return donation(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Peer2PeerTransfer value)? peer2peer,
    TResult Function(Donation value)? donation,
    TResult Function(MoneyPoolContribution value)? moneyPoolContribution,
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
      required ProjectPreviewDetails projectPreviewDetails,
      required dynamic createdAt,
      TransferStatus status,
      TransferType type,
      @JsonKey(name: "transferId", toJson: MoneyTransfer._checkIftransferIdIsSet)
          String transferId}) = _$Donation;
  const Donation._() : super._();

  factory Donation.fromJson(Map<String, dynamic> json) = _$Donation.fromJson;

  @override
  TransferDetails get transferDetails => throw _privateConstructorUsedError;
  ProjectPreviewDetails get projectPreviewDetails =>
      throw _privateConstructorUsedError;
  @override
  dynamic get createdAt => throw _privateConstructorUsedError;
  @override
  TransferStatus get status => throw _privateConstructorUsedError;
  @override
  TransferType get type => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: "transferId", toJson: MoneyTransfer._checkIftransferIdIsSet)
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
      dynamic createdAt,
      TransferStatus status,
      TransferType type,
      @JsonKey(name: "transferId", toJson: MoneyTransfer._checkIftransferIdIsSet)
          String transferId});

  @override
  $TransferDetailsCopyWith<$Res> get transferDetails;
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
class _$MoneyPoolContribution extends MoneyPoolContribution {
  const _$MoneyPoolContribution(
      {required this.transferDetails,
      required this.createdAt,
      this.status = TransferStatus.Initialized,
      this.type = TransferType.MoneyPoolContribution,
      @JsonKey(name: "transferId", toJson: MoneyTransfer._checkIftransferIdIsSet)
          this.transferId = "placeholder"})
      : super._();

  factory _$MoneyPoolContribution.fromJson(Map<String, dynamic> json) =>
      _$_$MoneyPoolContributionFromJson(json);

  @override
  final TransferDetails transferDetails;
  @override
  final dynamic createdAt;
  @JsonKey(defaultValue: TransferStatus.Initialized)
  @override
  final TransferStatus status;
  @JsonKey(defaultValue: TransferType.MoneyPoolContribution)
  @override
  final TransferType type;
  @override
  @JsonKey(name: "transferId", toJson: MoneyTransfer._checkIftransferIdIsSet)
  final String transferId;

  @override
  String toString() {
    return 'MoneyTransfer.moneyPoolContribution(transferDetails: $transferDetails, createdAt: $createdAt, status: $status, type: $type, transferId: $transferId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is MoneyPoolContribution &&
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
            @JsonKey(name: "transferId", toJson: MoneyTransfer._checkIftransferIdIsSet)
                String transferId)
        peer2peer,
    required TResult Function(
            TransferDetails transferDetails,
            ProjectPreviewDetails projectPreviewDetails,
            dynamic createdAt,
            TransferStatus status,
            TransferType type,
            @JsonKey(name: "transferId", toJson: MoneyTransfer._checkIftransferIdIsSet)
                String transferId)
        donation,
    required TResult Function(
            TransferDetails transferDetails,
            dynamic createdAt,
            TransferStatus status,
            TransferType type,
            @JsonKey(name: "transferId", toJson: MoneyTransfer._checkIftransferIdIsSet)
                String transferId)
        moneyPoolContribution,
  }) {
    return moneyPoolContribution(
        transferDetails, createdAt, status, type, transferId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            TransferDetails transferDetails,
            dynamic createdAt,
            TransferStatus status,
            TransferType type,
            @JsonKey(name: "transferId", toJson: MoneyTransfer._checkIftransferIdIsSet)
                String transferId)?
        peer2peer,
    TResult Function(
            TransferDetails transferDetails,
            ProjectPreviewDetails projectPreviewDetails,
            dynamic createdAt,
            TransferStatus status,
            TransferType type,
            @JsonKey(name: "transferId", toJson: MoneyTransfer._checkIftransferIdIsSet)
                String transferId)?
        donation,
    TResult Function(
            TransferDetails transferDetails,
            dynamic createdAt,
            TransferStatus status,
            TransferType type,
            @JsonKey(name: "transferId", toJson: MoneyTransfer._checkIftransferIdIsSet)
                String transferId)?
        moneyPoolContribution,
    required TResult orElse(),
  }) {
    if (moneyPoolContribution != null) {
      return moneyPoolContribution(
          transferDetails, createdAt, status, type, transferId);
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
  }) {
    return moneyPoolContribution(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Peer2PeerTransfer value)? peer2peer,
    TResult Function(Donation value)? donation,
    TResult Function(MoneyPoolContribution value)? moneyPoolContribution,
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
      required dynamic createdAt,
      TransferStatus status,
      TransferType type,
      @JsonKey(name: "transferId", toJson: MoneyTransfer._checkIftransferIdIsSet)
          String transferId}) = _$MoneyPoolContribution;
  const MoneyPoolContribution._() : super._();

  factory MoneyPoolContribution.fromJson(Map<String, dynamic> json) =
      _$MoneyPoolContribution.fromJson;

  @override
  TransferDetails get transferDetails => throw _privateConstructorUsedError;
  @override
  dynamic get createdAt => throw _privateConstructorUsedError;
  @override
  TransferStatus get status => throw _privateConstructorUsedError;
  @override
  TransferType get type => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: "transferId", toJson: MoneyTransfer._checkIftransferIdIsSet)
  String get transferId => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  $MoneyPoolContributionCopyWith<MoneyPoolContribution> get copyWith =>
      throw _privateConstructorUsedError;
}
