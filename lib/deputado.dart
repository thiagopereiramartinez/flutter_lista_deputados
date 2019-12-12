
class Deputado {

  final int id;
  final String nome;
  final String email;
  final String foto;

  Deputado({this.id, this.nome, this.email, this.foto});

  factory Deputado.fromMap(Map<String, dynamic> map) {
    return Deputado(
      id: map["id"],
      nome: map["nome"],
      email: map["email"],
      foto: map["urlFoto"]
    );
  }

}
