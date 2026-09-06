enum ThermalSensitivity {
  chilly('chilly'),
  hot('hot');

  final String key;

  const ThermalSensitivity(this.key);
}

enum FluidNeed {
  thirsty('thirsty'),
  thirstless('thirstless');

  final String key;

  const FluidNeed(this.key);
}
