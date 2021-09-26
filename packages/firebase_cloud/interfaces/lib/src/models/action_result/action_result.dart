import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'action_result.g.dart';

/// {@template}
/// Action result, which perform different action on database
/// Allow the firebase cloud function triggers to make the decision
/// {@endtemplate}
@JsonSerializable()
class ActionResult extends Equatable {
  /// @{macro}
  const ActionResult({
    this.success,
    this.msg,
    this.data,
  });

  /// Factory which converts a [Map<String, dynamic>] into a [ActionResult].
  factory ActionResult.fromJson(Map<String, dynamic> json) =>
      _$ActionResultFromJson(json);

  /// Converts the current [ActionResult] into a [Map<String, dynamic>].
  Map<String, dynamic> toJson() => _$ActionResultToJson(this);

  /// Indicates if the action was successful or not
  final bool? success;

  /// Message received in response of the action
  final String? msg;

  /// Data received in response of the action,
  /// the data can be on type as its is [dynamic]
  final dynamic data;

  @override
  List<Object?> get props => [success, msg, data];
}
