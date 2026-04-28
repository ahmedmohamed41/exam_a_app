import 'package:equatable/equatable.dart';
import 'package:exam_a_app/feature/explore/domain/model/subject_entity.dart';

enum ExploreStatus { initial, loading, success, error }

class ExploreStates extends Equatable {
  final ExploreStatus status;
  final List<SubjectEntity>? subjects;
  final String? errorMessage;

  const ExploreStates({
    this.status = ExploreStatus.initial,
    this.subjects,
    this.errorMessage,
  });

  ExploreStates copyWith({
    ExploreStatus? status,
    List<SubjectEntity>? subjects,
    String? errorMessage,
  }) {
    return ExploreStates(
      status: status ?? this.status,
      subjects: subjects ?? this.subjects,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, subjects, errorMessage];
}
