import 'package:equatable/equatable.dart';
import '../../../results/domain/models/exam_result_entity.dart';
import '../../domain/models/exam_model.dart';

enum TimerStatus { initial, running, lowTime, finished }

enum ExamStatus { initial, loading, success, error }

class ExamState extends Equatable {
  final ExamStatus status;
  final String? errorMessage;
  final ExamDetails? data;
  
  final int currentIndex;
  final Map<int, List<String>> answers;
  final int? score;
  final ExamResultEntity? result;
  final int remainingSeconds;
  final int totalDurationSeconds;
  final TimerStatus timerStatus;

  const ExamState({
    this.status = ExamStatus.initial,
    this.errorMessage,
    this.data,
    this.currentIndex = 0,
    this.answers = const {},
    this.score,
    this.result,
    this.remainingSeconds = 0,
    this.totalDurationSeconds = 0,
    this.timerStatus = TimerStatus.initial,
  });

  factory ExamState.initial() => const ExamState();

  ExamState copyWith({
    ExamStatus? status,
    String? errorMessage,
    ExamDetails? data,
    int? currentIndex,
    Map<int, List<String>>? answers,
    int? score,
    ExamResultEntity? result,
    int? remainingSeconds,
    int? totalDurationSeconds,
    TimerStatus? timerStatus,
  }) {
    return ExamState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
      currentIndex: currentIndex ?? this.currentIndex,
      answers: answers ?? this.answers,
      score: score ?? this.score,
      result: result ?? this.result,
      remainingSeconds: remainingSeconds ?? this.remainingSeconds,
      totalDurationSeconds: totalDurationSeconds ?? this.totalDurationSeconds,
      timerStatus: timerStatus ?? this.timerStatus,
    );
  }

  QuestionEntity? get currentQuestion {
    if (data?.questions != null &&
        currentIndex >= 0 &&
        currentIndex < data!.questions!.length) {
      return data!.questions![currentIndex];
    }
    return null;
  }

  String get formattedTime {
    final int minutes = remainingSeconds ~/ 60;
    final int seconds = remainingSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  bool get isFirstQuestion => currentIndex == 0;
  bool get isLastQuestion =>
      data?.questions != null && currentIndex == data!.questions!.length - 1;

  @override
  List<Object?> get props => [
        status,
        errorMessage,
        data,
        currentIndex,
        answers,
        score,
        result,
        remainingSeconds,
        totalDurationSeconds,
        timerStatus,
      ];
}
