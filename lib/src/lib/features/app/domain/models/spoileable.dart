class Spoileable<T> {
  final bool spoiler;
  final T spoileable;
  bool get esSpoiler => spoiler;

  const Spoileable(this.spoiler, this.spoileable);

  Spoileable<T> copyWith({
    bool? spoiler,
    T? spoileable,
  }) {
    return Spoileable(spoiler ?? this.spoiler, spoileable ?? this.spoileable);
  }

  factory Spoileable.fromJson(Map<String, dynamic> json) {
    return Spoileable(json["spoiler"], json["spoileable"]);
  }
}
