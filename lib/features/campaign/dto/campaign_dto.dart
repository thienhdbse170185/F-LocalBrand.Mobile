class CampaignDto {
  final int id;
  final String name;
  final String status;

  const CampaignDto(
    this.id,
    this.name,
    this.status,
  );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'status': status,
      };

  factory CampaignDto.fromJson(Map<String, dynamic> json) {
    return CampaignDto(
      json['id'] ?? 0,
      json['name'] ?? "",
      json['status'] ?? "",
    );
  }
}
