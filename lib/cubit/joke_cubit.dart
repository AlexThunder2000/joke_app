// joke_cubit.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joke_app/models/joke_model.dart';
import 'package:joke_app/services/api_service.dart';

part 'joke_state.dart';

class JokeCubit extends Cubit<JokeState> {
  final ApiService apiService;

  JokeCubit(this.apiService) : super(JokeState.initial());

  Future<void> loadJokeTypes() async {
    try {
      final jokeTypes = await apiService.fetchJokeTypes();
      emit(
        state.copyWith(
          jokeTypes: jokeTypes,
          status: JokeStatus.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(status: JokeStatus.error, errorMessage: e.toString()),
      );
    }
  }

  void setSelectedType(String type) {
    emit(
      state.copyWith(selectedType: type),
    );
  }

  Future<void> getJokeAndDogImage() async {
    try {
      Joke joke = await apiService.fetchJokeByType(state.selectedType!);
      String dogImageUrl = await apiService.fetchDogImageUrl();
      emit(state.copyWith(status: JokeStatus.success, joke: joke, dogImageUrl: dogImageUrl));
    } catch (e) {
      emit(
        state.copyWith(status: JokeStatus.error, errorMessage: e.toString()),
      );
    }
  }
}
