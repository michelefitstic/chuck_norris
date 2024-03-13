import 'dart:convert';

class Citazione {
  String frase;
  String id;
  String createdAt;

  Citazione({required this.frase, required this.id, required this.createdAt});

  factory Citazione.fromJson(String jsonString) {
    final Map<String, dynamic> data = json.decode(jsonString);
    return Citazione.fromMap(data);
  }

  factory Citazione.fromMap(Map<String, dynamic> map) {
    final citazione = Citazione(
        frase: map['value'], id: map['id'], createdAt: map['created_at']);
    return citazione;
  }

  @override
  String toString() {
    return "Citazione: $frase - Id: $id - Data: $createdAt";
  }
}
