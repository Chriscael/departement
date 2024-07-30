class LecturerM {
  String id, email, name;

  LecturerM({
    required this.id,
    required this.name,
    required this.email,
  });
  static LecturerM current = LecturerM(id: "", email: "", name: "");
  factory LecturerM.fromJson(Map<String, dynamic> j) =>
      LecturerM(email: j['email'], id: j['id'], name: j['name']);
  Map<String, dynamic> toMap() => {
        "id": id,
        "email": email,
        "name": name,
      };
}
