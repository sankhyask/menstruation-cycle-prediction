class PredictionModel {
  final String id;
  final String userId;
  final int age;
  final double weight;
  final double height;
  final double bmi;
  final int prediction;
  final double? confidence;
  final DateTime createdAt;

  PredictionModel({
    required this.id,
    required this.userId,
    required this.age,
    required this.weight,
    required this.height,
    required this.bmi,
    required this.prediction,
    this.confidence,
    required this.createdAt,
  });

  factory PredictionModel.fromMap(Map<String, dynamic> map) {
    return PredictionModel(
      id: map['id'] as String? ?? '',
      userId: map['userId'] as String? ?? '',
      age: map['age'] as int? ?? 0,
      weight: map['weight'] as double? ?? 0.0,
      height: map['height'] as double? ?? 0.0,
      bmi: map['bmi'] as double? ?? 0.0,
      prediction: map['prediction'] as int? ?? 0,
      confidence: map['confidence'] as double?,
      createdAt: map['createdAt'] != null
          ? DateTime.parse(map['createdAt'] as String)
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'age': age,
      'weight': weight,
      'height': height,
      'bmi': bmi,
      'prediction': prediction,
      'confidence': confidence,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  PredictionModel copyWith({
    String? id,
    String? userId,
    int? age,
    double? weight,
    double? height,
    double? bmi,
    int? prediction,
    double? confidence,
    DateTime? createdAt,
  }) {
    return PredictionModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      age: age ?? this.age,
      weight: weight ?? this.weight,
      height: height ?? this.height,
      bmi: bmi ?? this.bmi,
      prediction: prediction ?? this.prediction,
      confidence: confidence ?? this.confidence,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
