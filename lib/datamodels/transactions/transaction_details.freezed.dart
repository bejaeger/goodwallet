// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'transaction_details.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TransactionDetails _$TransactionDetailsFromJson(Map<String, dynamic> json) {
  return _TransactionDetails.fromJson(json);
}

/// @nodoc
class _$TransactionDetailsTearOff {
  const _$TransactionDetailsTearOff();

  _TransactionDetails call(
      {required String recipientId,
      required String recipientName,
      required String senderId,
      required String senderName,
      required num amount,
      required String currency,
      required MoneySource sourceType}) {
    return _TransactionDetails(
      recipientId: recipientId,
      recipientName: recipientName,
      senderId: senderId,
      senderName: senderName,
      amount: amount,
      currency: currency,
      sourceType: sourceType,
    );
  }

  TransactionDetails fromJson(Map<String, Object> json) {
    return TransactionDetails.fromJson(json);
  }
}

/// @nodoc
const $TransactionDetails = _$TransactionDetailsTearOff();

/// @nodoc
mixin _$TransactionDetails {
  String get recipientId => throw _privateConstructorUsedError;
  String get recipientName => throw _privateConstructorUsedError;
  String get senderId => throw _privateConstructorUsedError;
  String get senderName => throw _privateConstructorUsedError;
  num get amount => throw _privateConstructorUsedError;
  String get currency => throw _privateConstructorUsedError;
  MoneySource get sourceType => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TransactionDetailsCopyWith<TransactionDetails> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransactionDetailsCopyWith<$Res> {
  factory $TransactionDetailsCopyWith(
          TransactionDetails value, $Res Function(TransactionDetails) then) =
      _$TransactionDetailsCopyWithImpl<$Res>;
  $Res call(
      {String recipientId,
      String recipientName,
      String senderId,
      String senderName,
      num amount,
      String currency,
      MoneySource sourceType});
}

/// @nodoc
class _$TransactionDetailsCopyWithImpl<$Res>
    implements $TransactionDetailsCopyWith<$Res> {
  _$TransactionDetailsCopyWithImpl(this._value, this._then);

  final TransactionDetails _value;
  // ignore: unused_field
  final $Res Function(TransactionDetails) _then;

  @override
  $Res call({
    Object? recipientId = freezed,
    Object? recipientName = freezed,
    Object? senderId = freezed,
    Object? senderName = freezed,
    Object? amount = freezed,
    Object? currency = freezed,
    Object? sourceType = freezed,
  }) {
    return _then(_value.copyWith(
      recipientId: recipientId == freezed
          ? _value.recipientId
          : recipientId // ignore: cast_nullable_to_non_nullable
              as String,
      recipientName: recipientName == freezed
          ? _value.recipientName
          : recipientName // ignore: cast_nullable_to_non_nullable
              as String,
      senderId: senderId == freezed
          ? _value.senderId
          : senderId // ignore: cast_nullable_to_non_nullable
              as String,
      senderName: senderName == freezed
          ? _value.senderName
          : senderName // ignore: cast_nullable_to_non_nullable
              as String,
      amount: amount == freezed
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as num,
      currency: currency == freezed
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      sourceType: sourceType == freezed
          ? _value.sourceType
          : sourceType // ignore: cast_nullable_to_non_nullable
              as MoneySource,
    ));
  }
}

/// @nodoc
abstract class _$TransactionDetailsCopyWith<$Res>
    implements $TransactionDetailsCopyWith<$Res> {
  factory _$TransactionDetailsCopyWith(
          _TransactionDetails value, $Res Function(_TransactionDetails) then) =
      __$TransactionDetailsCopyWithImpl<$Res>;
  @override
  $Res call(
      {String recipientId,
      String recipientName,
      String senderId,
      String senderName,
      num amount,
      String currency,
      MoneySource sourceType});
}

/// @nodoc
class __$TransactionDetailsCopyWithImpl<$Res>
    extends _$TransactionDetailsCopyWithImpl<$Res>
    implements _$TransactionDetailsCopyWith<$Res> {
  __$TransactionDetailsCopyWithImpl(
      _TransactionDetails _value, $Res Function(_TransactionDetails) _then)
      : super(_value, (v) => _then(v as _TransactionDetails));

  @override
  _TransactionDetails get _value => super._value as _TransactionDetails;

  @override
  $Res call({
    Object? recipientId = freezed,
    Object? recipientName = freezed,
    Object? senderId = freezed,
    Object? senderName = freezed,
    Object? amount = freezed,
    Object? currency = freezed,
    Object? sourceType = freezed,
  }) {
    return _then(_TransactionDetails(
      recipientId: recipientId == freezed
          ? _value.recipientId
          : recipientId // ignore: cast_nullable_to_non_nullable
              as String,
      recipientName: recipientName == freezed
          ? _value.recipientName
          : recipientName // ignore: cast_nullable_to_non_nullable
              as String,
      senderId: senderId == freezed
          ? _value.senderId
          : senderId // ignore: cast_nullable_to_non_nullable
              as String,
      senderName: senderName == freezed
          ? _value.senderName
          : senderName // ignore: cast_nullable_to_non_nullable
              as String,
      amount: amount == freezed
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as num,
      currency: currency == freezed
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      sourceType: sourceType == freezed
          ? _value.sourceType
          : sourceType // ignore: cast_nullable_to_non_nullable
              as MoneySource,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_TransactionDetails implements _TransactionDetails {
  const _$_TransactionDetails(
      {required this.recipientId,
      required this.recipientName,
      required this.senderId,
      required this.senderName,
      required this.amount,
      required this.currency,
      required this.sourceType});

  factory _$_TransactionDetails.fromJson(Map<String, dynamic> json) =>
      _$_$_TransactionDetailsFromJson(json);

  @override
  final String recipientId;
  @override
  final String recipientName;
  @override
  final String senderId;
  @override
  final String senderName;
  @override
  final num amount;
  @override
  final String currency;
  @override
  final MoneySource sourceType;

  @override
  String toString() {
    return 'TransactionDetails(recipientId: $recipientId, recipientName: $recipientName, senderId: $senderId, senderName: $senderName, amount: $amount, currency: $currency, sourceType: $sourceType)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _TransactionDetails &&
            (identical(other.recipientId, recipientId) ||
                const DeepCollectionEquality()
                    .equals(other.recipientId, recipientId)) &&
            (identical(other.recipientName, recipientName) ||
                const DeepCollectionEquality()
                    .equals(other.recipientName, recipientName)) &&
            (identical(other.senderId, senderId) ||
                const DeepCollectionEquality()
                    .equals(other.senderId, senderId)) &&
            (identical(other.senderName, senderName) ||
                const DeepCollectionEquality()
                    .equals(other.senderName, senderName)) &&
            (identical(other.amount, amount) ||
                const DeepCollectionEquality().equals(other.amount, amount)) &&
            (identical(other.currency, currency) ||
                const DeepCollectionEquality()
                    .equals(other.currency, currency)) &&
            (identical(other.sourceType, sourceType) ||
                const DeepCollectionEquality()
                    .equals(other.sourceType, sourceType)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(recipientId) ^
      const DeepCollectionEquality().hash(recipientName) ^
      const DeepCollectionEquality().hash(senderId) ^
      const DeepCollectionEquality().hash(senderName) ^
      const DeepCollectionEquality().hash(amount) ^
      const DeepCollectionEquality().hash(currency) ^
      const DeepCollectionEquality().hash(sourceType);

  @JsonKey(ignore: true)
  @override
  _$TransactionDetailsCopyWith<_TransactionDetails> get copyWith =>
      __$TransactionDetailsCopyWithImpl<_TransactionDetails>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_TransactionDetailsToJson(this);
  }
}

abstract class _TransactionDetails implements TransactionDetails {
  const factory _TransactionDetails(
      {required String recipientId,
      required String recipientName,
      required String senderId,
      required String senderName,
      required num amount,
      required String currency,
      required MoneySource sourceType}) = _$_TransactionDetails;

  factory _TransactionDetails.fromJson(Map<String, dynamic> json) =
      _$_TransactionDetails.fromJson;

  @override
  String get recipientId => throw _privateConstructorUsedError;
  @override
  String get recipientName => throw _privateConstructorUsedError;
  @override
  String get senderId => throw _privateConstructorUsedError;
  @override
  String get senderName => throw _privateConstructorUsedError;
  @override
  num get amount => throw _privateConstructorUsedError;
  @override
  String get currency => throw _privateConstructorUsedError;
  @override
  MoneySource get sourceType => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$TransactionDetailsCopyWith<_TransactionDetails> get copyWith =>
      throw _privateConstructorUsedError;
}
