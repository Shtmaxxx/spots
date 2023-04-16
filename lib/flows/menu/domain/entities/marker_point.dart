class MarkerPoint {
  const MarkerPoint({
    this.id = '',
    required this.name,
    required this.description,
    required this.latitude,
    required this.longitude,
  });

  final String id;
  final String name;
  final String description;
  final double latitude;
  final double longitude;

  MarkerPoint copyWith({
    String? id,
    String? name,
    String? description,
    double? latitude,
    double? longitude,
  }) {
    return MarkerPoint(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }
}
