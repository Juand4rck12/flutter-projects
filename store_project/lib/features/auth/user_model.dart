class User {
  final int id;
  final String documentId;
  final String username;
  final String email;
  final bool confirmed;

  User({
    required this.id,
    required this.documentId,
    required this.username,
    required this.email,
    required this.confirmed,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      documentId: json['documentId'] ?? '',
      username: json['username'],
      email: json['email'],
      confirmed: json['confirmed'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'documentId': documentId,
      'username': username,
      'email': email,
    };
  }
}
