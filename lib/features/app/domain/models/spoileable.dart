class ContenidoCensurable<T> {
  final bool spoiler;
  final T content;
  bool get esSpoiler => spoiler;

  const ContenidoCensurable(this.spoiler, this.content);

  ContenidoCensurable<T> copyWith({
    bool? spoiler,
    T? content,
  }) {
    return ContenidoCensurable(
      spoiler ?? this.spoiler,
      content ?? this.content,
    );
  }

  factory ContenidoCensurable.fromJson(Map<String, dynamic> json) {
    return ContenidoCensurable(json["spoiler"], json["content"]);
  }
}
