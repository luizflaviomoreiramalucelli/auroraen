class Word {
  final String word;
  final String description;

  const Word(this.word, this.description);

  String get imgPath => '/assets/images/$word.png';

  @override
  String toString() => 'Word(word: $word, description: $description)';
}
