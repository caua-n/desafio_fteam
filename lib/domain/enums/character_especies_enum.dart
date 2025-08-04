enum CharacterSpecies { human, alien, empty }

final characterSpeciesAvailable = {
  CharacterSpecies.alien: "Alien",
  CharacterSpecies.human: "Human",
  CharacterSpecies.empty: "",
};

extension CharacterSpeciesExtension on CharacterSpecies {
  static CharacterSpecies fromString(String? value) {
    switch (value?.toLowerCase()) {
      case 'human':
        return CharacterSpecies.human;
      case 'alien':
        return CharacterSpecies.alien;
      default:
        return CharacterSpecies.empty;
    }
  }
}
