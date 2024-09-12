class Joke {
  final String setup;
  final String punchline;

  Joke({required this.setup, required this.punchline});

  Joke.empty()
      : setup = '',
        punchline = '';

  factory Joke.fromJson(Map<String, dynamic> json) {
    return Joke(
      setup: json['setup'],
      punchline: json['punchline'],
    );
  }
}
