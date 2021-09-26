import 'package:equatable/equatable.dart';

/// {@template}
/// Status model
/// The fromJson and toJson are hardcoded here, because it take String
/// as a value not a Map
/// {@endtemplate}
class Status extends Equatable {
  /// {@macro}
  const Status({
    this.active,
  });

  /// fromJson
  factory Status.fromJson(String? string) {
    if (string != null && string.toLowerCase() == 'active') {
      return const Status(active: true);
    }
    return const Status(active: false);
  }

  /// Create toJson for Status
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'status': (active ?? false) ? 'active' : 'inactive',
    };
  }

  /// is Active
  final bool? active;

  @override
  List<Object?> get props => [active];
}
