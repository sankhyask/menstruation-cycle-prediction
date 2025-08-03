class UserModel {
  final String id;
  final String email;
  final String? name;
  final DateTime? createdAt;
  final DateTime? lastLoginAt;

  UserModel({
    required this.id,
    required this.email,
    this.name,
    this.createdAt,
    this.lastLoginAt,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      email: map['email'] ?? '',
      name: map['name'],
      createdAt: map['createdAt'] != null 
          ? DateTime.parse(map['createdAt']) 
          : null,
      lastLoginAt: map['lastLoginAt'] != null 
          ? DateTime.parse(map['lastLoginAt']) 
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'createdAt': createdAt?.toIso8601String(),
      'lastLoginAt': lastLoginAt?.toIso8601String(),
    };
  }

  UserModel copyWith({
    String? id,
    String? email,
    String? name,
    DateTime? createdAt,
    DateTime? lastLoginAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      lastLoginAt: lastLoginAt ?? this.lastLoginAt,
    );
  }
}
