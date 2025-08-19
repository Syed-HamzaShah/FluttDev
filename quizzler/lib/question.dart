class Questions {
  String qName;
  bool aName;

  Questions({required this.qName, required this.aName});

  String get questionText => qName;
  bool get questionNumber => aName;
}

class QuestionBank {
  List<Questions> questions = [
    Questions(qName: 'Some cats are actually allergic to humans', aName: true),
    Questions(
      qName: 'You can lead a cow down stairs but not up stairs.',
      aName: false,
    ),
    Questions(
      qName: 'Approximately one quarter of human bones are in the feet.',
      aName: true,
    ),
    Questions(qName: 'A slug\'s blood is green.', aName: true),
    Questions(
      qName: 'Buzz Aldrin\'s mother\'s maiden name was \"Moon\".',
      aName: true,
    ),
    Questions(
      qName: 'It is illegal to pee in the Ocean in Portugal.',
      aName: true,
    ),
    Questions(
      qName:
          'No piece of square dry paper can be folded in half more than 7 times.',
      aName: false,
    ),
    Questions(
      qName:
          'In London, UK, if you happen to die in the House of Parliament, you are technically entitled to a state funeral, because the building is considered too sacred a place.',
      aName: true,
    ),
    Questions(
      qName:
          'The loudest sound produced by any animal is 188 decibels. That animal is the African Elephant.',
      aName: false,
    ),
    Questions(
      qName:
          'The total surface area of two human lungs is approximately 70 square metres.',
      aName: true,
    ),
    Questions(qName: 'Google was originally called \"Backrub\".', aName: true),
    Questions(
      qName:
          'Chocolate affects a dog\'s heart and nervous system; a few ounces are enough to kill a small dog.',
      aName: true,
    ),
    Questions(
      qName:
          'In West Virginia, USA, if you accidentally hit an animal with your car, you are free to take it home to eat.',
      aName: true,
    ),
  ];

  Questions getQuestion(int index) {
    return questions[index];
  }
}
