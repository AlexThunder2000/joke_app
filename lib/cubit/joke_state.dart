part of 'joke_cubit.dart';

enum JokeStatus { initial, loading, success, error }

class JokeState {
  final JokeStatus status;
  final List<String> jokeTypes;
  final String selectedType;
  final Joke joke;
  final String dogImageUrl;
  final String errorMessage;

  JokeState({
    required this.status,
    required this.jokeTypes,
    required this.selectedType,
    required this.joke,
    required this.dogImageUrl,
    required this.errorMessage,
  });

  JokeState.initial()
      : status = JokeStatus.initial,
        jokeTypes = [],
        selectedType = '',
        errorMessage = '',
        joke = Joke.empty(),
        dogImageUrl = '';

  bool get isLoading => status == JokeStatus.loading;

  bool get isError => status == JokeStatus.error;

  bool get isSuccess => status == JokeStatus.success;

  JokeState copyWith({
    JokeStatus? status,
    List<String>? jokeTypes,
    String? selectedType,
    Joke? joke,
    String? dogImageUrl,
    String? errorMessage,
  }) {
    return JokeState(
      status: status ?? this.status,
      jokeTypes: jokeTypes ?? this.jokeTypes,
      selectedType: selectedType ?? this.selectedType,
      joke: joke ?? this.joke,
      dogImageUrl: dogImageUrl ?? this.dogImageUrl,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
