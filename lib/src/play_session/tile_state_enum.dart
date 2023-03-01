enum TileStateEnum {
  empty,
  cross,
  circle,
  none
}

extension TileStateEnumExtension on TileStateEnum {
  String get value {
    switch (this) {
      case TileStateEnum.circle:
        return 'O';
      case TileStateEnum.cross:
        return 'X';
      default:
        return '';
    }
  }
}
