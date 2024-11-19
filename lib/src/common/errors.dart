import 'package:equatable/equatable.dart';

class RepositoryError extends Equatable {
  final String message;

  const RepositoryError({required this.message});

  @override
  List<Object?> get props => [message];
}
