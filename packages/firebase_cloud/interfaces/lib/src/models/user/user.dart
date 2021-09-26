import 'package:equatable/equatable.dart';
import 'package:firebase_cloud_interfaces/src/firebase_cloud_interfaces.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

/// {@template user}
/// [User] model which contain all the information for a user
/// {@endtemplate}
@JsonSerializable()
class User extends Equatable {
  /// {@macro user} default [User] constructor
  /// Required Params:
  ///       - [id] of type [String]
  ///       - [isAnonymous] of type [bool]
  const User({
    required this.isAnonymous,
    this.id,
    this.dobDay,
    this.dobMonth,
    this.dobYear,
    this.email,
    this.displayName,
    this.firstName,
    this.lastLogin,
    this.lastName,
    this.phoneNumber,
    this.zipCode,
    this.createdAt,
  });

  /// Create an anonymous [User]
  factory User.anonymous() => User(
        id: Strings.empty,
        isAnonymous: true,
      );

  /// Factory which converts a [Map<String, dynamic>] into a [User].
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  /// Converts the current [User] into a [Map<String, dynamic>].
  Map<String, dynamic> toJson() => _$UserToJson(this);

  /// Create an anonymous [User]
  @Deprecated('Use User.anonymous')
  static final nullObject = User(
    id: Strings.empty,
    isAnonymous: true,
  );

  /// Unique [id] of the user
  final String? id;

  /// Timestamp at which this user was created
  /// Type: int
  final int? createdAt;

  /// Date of birth day of the user
  @JsonKey(name: 'dob_dd')
  final int? dobDay;

  /// Date of birth month of the user
  @JsonKey(name: 'dob_mm')
  final int? dobMonth;

  /// Date of birth year of the user
  @JsonKey(name: 'dob_yyyy')
  final int? dobYear;

  /// Email address of the user
  final String? email;

  /// Display name of the user
  @JsonKey(name: 'displayName')
  final String? displayName;

  /// First name of the user
  final String? firstName;

  /// A Check which indicate if the user is anonymous or not
  final bool isAnonymous;

  /// Last login timestamp
  final int? lastLogin;

  /// Last name of the user
  final String? lastName;

  /// Phone number of the user
  final String? phoneNumber;

  /// Zipcode of the user
  final String? zipCode;

  /// Create a copy of the current instance
  /// override the values for the attributes provided in params
  /// otherwise use the value from the current instance
  User copyWith({
    String? id,
    bool? isAnonymous,
    int? dobDay,
    int? dobMonth,
    int? dobYear,
    String? email,
    String? displayName,
    String? firstName,
    int? lastLogin,
    String? lastName,
    String? phoneNumber,
    String? zipCode,
    int? rewardsTosAccepted,
    int? lotteryTosAccepted,
    bool? ukPrivacyAccepted,
    bool? ukOptoutHamilton,
    bool? ukOptoutLuckyseat,
    bool? ukOptoutVenue,
    bool? appTosPpAccepted,
    bool? ukOptoutUpdatedAt,
    Map? lotteryTosAcceptanceV2,
    bool? hasAcceptedBetaNda,
    int? createdAt,
  }) {
    return User(
      id: id ?? this.id,
      isAnonymous: isAnonymous ?? this.isAnonymous,
      dobDay: dobDay ?? this.dobDay,
      dobMonth: dobMonth ?? this.dobMonth,
      dobYear: dobYear ?? this.dobYear,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      firstName: firstName ?? this.firstName,
      lastLogin: lastLogin ?? this.lastLogin,
      lastName: lastName ?? this.lastName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      zipCode: zipCode ?? this.zipCode,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        isAnonymous,
        dobDay,
        dobMonth,
        dobYear,
        email,
        displayName,
        firstName,
        lastLogin,
        lastName,
        phoneNumber,
        zipCode,
        createdAt,
      ];
}
