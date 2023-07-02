class SplashScreenState {
  final bool opacity;

  SplashScreenState({
    this.opacity = true,
  });

  SplashScreenState copyWith({
    bool? opacity,
  }) {
    return SplashScreenState(
      opacity: opacity ?? this.opacity,
    );
  }
}