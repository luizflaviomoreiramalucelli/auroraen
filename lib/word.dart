class Word {
  final String word;
  final String description;
  final String? fileName;

  const Word(this.word, this.description, [this.fileName]);

  String get imgPath => 'assets/$fileName';

  @override
  String toString() => 'Word(word: $word, description: $description)';
}
