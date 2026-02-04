enum MoodType { happiness, fear, rage, sadness, calmness, strength }

extension MoodTypeExtension on MoodType {
  String get label {
    switch (this) {
      case MoodType.happiness:
        return 'Радость';
      case MoodType.fear:
        return 'Страх';
      case MoodType.rage:
        return 'Бешенство';
      case MoodType.sadness:
        return 'Грусть';
      case MoodType.calmness:
        return 'Спокойствие';
      case MoodType.strength:
        return 'Сила';
    }
  }

  String get iconPath {
    return 'assets/icons/$name.png';
  }

  List<String> get subEmotions {
    switch (this) {
      case MoodType.happiness:
        return [
          'Возбуждение',
          'Восторг',
          'Игривость',
          'Наслаждение',
          'Очарование',
          'Осознанность',
          'Смелость',
          'Удовольствие',
          'Чувственность',
          'Энергичность',
          'Экстравагантность',
        ];
      case MoodType.fear:
        return ['Тревога', 'Испуг', 'Паника', 'Беспокойство', 'Нервозность', 'Опасение', 'Ужас'];
      case MoodType.rage:
        return ['Раздражение', 'Гнев', 'Злость', 'Ярость', 'Обида', 'Негодование', 'Досада'];
      case MoodType.sadness:
        return [
          'Тоска',
          'Печаль',
          'Уныние',
          'Скорбь',
          'Разочарование',
          'Одиночество',
          'Меланхолия',
        ];
      case MoodType.calmness:
        return [
          'Умиротворение',
          'Безмятежность',
          'Расслабленность',
          'Гармония',
          'Тишина',
          'Равновесие',
        ];
      case MoodType.strength:
        return ['Уверенность', 'Решительность', 'Мощь', 'Стойкость', 'Выносливость', 'Воля'];
    }
  }
}
