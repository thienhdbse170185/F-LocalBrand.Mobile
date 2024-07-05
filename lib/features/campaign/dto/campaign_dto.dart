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
      json['campaign']['id'] ?? 0,
      json['campaign']['name'] ?? "",
      json['campaign']['status'] ?? "",
    );
  }
}
