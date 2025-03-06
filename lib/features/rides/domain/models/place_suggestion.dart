class StructuredFormatting {
  final String mainText;
  final String secondaryText;

  StructuredFormatting({
    required this.mainText,
    required this.secondaryText,
  });

  factory StructuredFormatting.fromJson(Map<String, dynamic> json) {
    return StructuredFormatting(
      mainText: json['main_text'] as String,
      secondaryText: json['secondary_text'] as String,
    );
  }
}

class PlaceSuggestion {
  final String description;
  final String placeId;
  final StructuredFormatting structuredFormatting;

  PlaceSuggestion({
    required this.description,
    required this.placeId,
    required this.structuredFormatting,
  });

  factory PlaceSuggestion.fromJson(Map<String, dynamic> json) {
    return PlaceSuggestion(
      description: json['description'] as String,
      placeId: json['place_id'] as String,
      structuredFormatting: StructuredFormatting.fromJson(
          json['structured_formatting'] as Map<String, dynamic>),
    );
  }
}
