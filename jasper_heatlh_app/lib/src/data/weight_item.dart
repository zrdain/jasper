class WeightItem {
  final String userId;
  final String weight;
  final int loggedTime;

  const WeightItem({
    required this.userId, 
    required this.weight, 
    required this.loggedTime
  });

  factory WeightItem.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'userId': String userId,
        'weight': String weight,
        'loggedTime': int loggedTime,
      } =>
        WeightItem(
          userId: userId,
          weight: weight,
          loggedTime: loggedTime,
        ),
      _ => throw const FormatException('Failed to load weight.'),
    };
  }

  Map<String, dynamic> toMap() {
    return {
        'userId': userId,
        'weight': weight,
        'loggedTime': loggedTime,
      };
  }

}
