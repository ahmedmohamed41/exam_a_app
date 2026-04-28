import 'package:equatable/equatable.dart';
import '../../domain/models/exam_result_entity.dart';

enum ResultsStatus { initial, loading, success, error }

class ResultsState extends Equatable {
  final ResultsStatus status;
  final List<ExamResultEntity>? results;
  final String? errorMessage;

  const ResultsState({
    this.status = ResultsStatus.initial,
    this.results,
    this.errorMessage,
  });

  // For backward compatibility during refactoring if needed, 
  // but better to update consumers.
  bool get isLoading => status == ResultsStatus.loading;

  ResultsState copyWith({
    ResultsStatus? status,
    List<ExamResultEntity>? results,
    String? errorMessage,
  }) {
    return ResultsState(
      status: status ?? this.status,
      results: results ?? this.results,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, results, errorMessage];
}
