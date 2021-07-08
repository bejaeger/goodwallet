// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'payments_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PaymentData _$PaymentDataFromJson(Map<String, dynamic> json) {
  return _PaymentData.fromJson(json);
}

/// @nodoc
class _$PaymentDataTearOff {
  const _$PaymentDataTearOff();

  _PaymentData call(
      {required int amount,
      required BillingDetails billingDetails,
      required String currency}) {
    return _PaymentData(
      amount: amount,
      billingDetails: billingDetails,
      currency: currency,
    );
  }

  PaymentData fromJson(Map<String, Object> json) {
    return PaymentData.fromJson(json);
  }
}

/// @nodoc
const $PaymentData = _$PaymentDataTearOff();

/// @nodoc
mixin _$PaymentData {
  int get amount => throw _privateConstructorUsedError;
  BillingDetails get billingDetails => throw _privateConstructorUsedError;
  String get currency => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PaymentDataCopyWith<PaymentData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaymentDataCopyWith<$Res> {
  factory $PaymentDataCopyWith(
          PaymentData value, $Res Function(PaymentData) then) =
      _$PaymentDataCopyWithImpl<$Res>;
  $Res call({int amount, BillingDetails billingDetails, String currency});

  $BillingDetailsCopyWith<$Res> get billingDetails;
}

/// @nodoc
class _$PaymentDataCopyWithImpl<$Res> implements $PaymentDataCopyWith<$Res> {
  _$PaymentDataCopyWithImpl(this._value, this._then);

  final PaymentData _value;
  // ignore: unused_field
  final $Res Function(PaymentData) _then;

  @override
  $Res call({
    Object? amount = freezed,
    Object? billingDetails = freezed,
    Object? currency = freezed,
  }) {
    return _then(_value.copyWith(
      amount: amount == freezed
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
      billingDetails: billingDetails == freezed
          ? _value.billingDetails
          : billingDetails // ignore: cast_nullable_to_non_nullable
              as BillingDetails,
      currency: currency == freezed
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }

  @override
  $BillingDetailsCopyWith<$Res> get billingDetails {
    return $BillingDetailsCopyWith<$Res>(_value.billingDetails, (value) {
      return _then(_value.copyWith(billingDetails: value));
    });
  }
}

/// @nodoc
abstract class _$PaymentDataCopyWith<$Res>
    implements $PaymentDataCopyWith<$Res> {
  factory _$PaymentDataCopyWith(
          _PaymentData value, $Res Function(_PaymentData) then) =
      __$PaymentDataCopyWithImpl<$Res>;
  @override
  $Res call({int amount, BillingDetails billingDetails, String currency});

  @override
  $BillingDetailsCopyWith<$Res> get billingDetails;
}

/// @nodoc
class __$PaymentDataCopyWithImpl<$Res> extends _$PaymentDataCopyWithImpl<$Res>
    implements _$PaymentDataCopyWith<$Res> {
  __$PaymentDataCopyWithImpl(
      _PaymentData _value, $Res Function(_PaymentData) _then)
      : super(_value, (v) => _then(v as _PaymentData));

  @override
  _PaymentData get _value => super._value as _PaymentData;

  @override
  $Res call({
    Object? amount = freezed,
    Object? billingDetails = freezed,
    Object? currency = freezed,
  }) {
    return _then(_PaymentData(
      amount: amount == freezed
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
      billingDetails: billingDetails == freezed
          ? _value.billingDetails
          : billingDetails // ignore: cast_nullable_to_non_nullable
              as BillingDetails,
      currency: currency == freezed
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PaymentData implements _PaymentData {
  _$_PaymentData(
      {required this.amount,
      required this.billingDetails,
      required this.currency});

  factory _$_PaymentData.fromJson(Map<String, dynamic> json) =>
      _$_$_PaymentDataFromJson(json);

  @override
  final int amount;
  @override
  final BillingDetails billingDetails;
  @override
  final String currency;

  @override
  String toString() {
    return 'PaymentData(amount: $amount, billingDetails: $billingDetails, currency: $currency)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _PaymentData &&
            (identical(other.amount, amount) ||
                const DeepCollectionEquality().equals(other.amount, amount)) &&
            (identical(other.billingDetails, billingDetails) ||
                const DeepCollectionEquality()
                    .equals(other.billingDetails, billingDetails)) &&
            (identical(other.currency, currency) ||
                const DeepCollectionEquality()
                    .equals(other.currency, currency)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(amount) ^
      const DeepCollectionEquality().hash(billingDetails) ^
      const DeepCollectionEquality().hash(currency);

  @JsonKey(ignore: true)
  @override
  _$PaymentDataCopyWith<_PaymentData> get copyWith =>
      __$PaymentDataCopyWithImpl<_PaymentData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_PaymentDataToJson(this);
  }
}

abstract class _PaymentData implements PaymentData {
  factory _PaymentData(
      {required int amount,
      required BillingDetails billingDetails,
      required String currency}) = _$_PaymentData;

  factory _PaymentData.fromJson(Map<String, dynamic> json) =
      _$_PaymentData.fromJson;

  @override
  int get amount => throw _privateConstructorUsedError;
  @override
  BillingDetails get billingDetails => throw _privateConstructorUsedError;
  @override
  String get currency => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$PaymentDataCopyWith<_PaymentData> get copyWith =>
      throw _privateConstructorUsedError;
}
