enum CharacterGenders { male, female, unknown, empty }

final characterGenderAvailable = {
  CharacterGenders.female: "Female",
  CharacterGenders.male: "Male",
  CharacterGenders.unknown: "unknown",
  CharacterGenders.empty: "",
};

extension CharacterGendersExtension on CharacterGenders {
  static CharacterGenders fromString(String? value) {
    switch (value?.toLowerCase()) {
      case 'female':
        return CharacterGenders.female;
      case 'male':
        return CharacterGenders.male;
      case 'unknown':
        return CharacterGenders.unknown;
      default:
        return CharacterGenders.empty;
    }
  }
}
