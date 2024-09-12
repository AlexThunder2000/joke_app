import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joke_app/cubit/joke_cubit.dart';

class JokeScreen extends StatelessWidget {
  const JokeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Joke & Dog"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            BlocBuilder<JokeCubit, JokeState>(
              builder: (context, state) {
                if (state.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state.isError) {
                  return Text("Error: ${state.errorMessage}", style: const TextStyle(color: Colors.redAccent));
                } else {
                  return DropdownMenu<String>(
                    width: double.infinity,
                    initialSelection: state.selectedType.isEmpty ? null : state.selectedType,
                    hintText: 'Select joke type',
                    dropdownMenuEntries: state.jokeTypes
                        .map((type) => DropdownMenuEntry<String>(
                              value: type,
                              label: type,
                            ))
                        .toList(),
                    onSelected: (value) {
                      if (value != null) {
                        context.read<JokeCubit>().setSelectedType(value);
                      }
                    },
                    inputDecorationTheme: const InputDecorationTheme(
                      border: InputBorder.none,
                    ),
                    menuHeight: 200,
                  );
                }
              },
            ),
            const SizedBox(height: 20),
            BlocBuilder<JokeCubit, JokeState>(
              builder: (context, state) {
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: state.selectedType.isEmpty
                      ? null
                      : () {
                          context.read<JokeCubit>().getJokeAndDogImage();
                        },
                  child: const Text(
                    "Tell me a joke!",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            BlocBuilder<JokeCubit, JokeState>(
              builder: (context, state) {
                if (state.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state.isSuccess) {
                  return Column(
                    children: [
                      Text(
                        state.joke.setup,
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        state.joke.punchline,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontStyle: FontStyle.italic),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      state.joke.setup.isNotEmpty
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: CachedNetworkImage(
                                imageUrl: state.dogImageUrl,
                                errorWidget: (context, url, error) => const Icon(Icons.error, color: Colors.red),
                                fadeInDuration: const Duration(seconds: 1),
                                fadeOutDuration: const Duration(seconds: 1),
                                width: 300,
                                height: 300,
                                fit: BoxFit.cover,
                              ),
                            )
                          : SizedBox.shrink(),
                    ],
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
