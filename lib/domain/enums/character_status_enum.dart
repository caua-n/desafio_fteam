enum CharacterStatus { alive, unknown, dead, empty }

final characterStatusAvailable = {
  CharacterStatus.alive: "Alive",
  CharacterStatus.dead: "Dead",
  CharacterStatus.unknown: "Unknown",
  CharacterStatus.empty: "",
};

extension CharacterStatusExtension on CharacterStatus {
  static CharacterStatus fromString(String? value) {
    switch (value?.toLowerCase()) {
      case 'alive':
        return CharacterStatus.alive;
      case 'dead':
        return CharacterStatus.dead;
      case 'unknown':
        return CharacterStatus.unknown;
      default:
        return CharacterStatus.empty;
    }
  }
}