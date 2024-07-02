class Spoileable<T> {
  bool spoiler;
  final T spoileable;
  bool get esSpoiler => spoiler;
  Spoileable(this.spoiler, this.spoileable);

  void switchSpoiler() {
    spoiler != spoiler;
  }
}
