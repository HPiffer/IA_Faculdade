//* Classe Nó
class No {
  String label;

  No(this.label);

  @override
  String toString() {
    return this.label;
  }
}

//* Classe Aresta
class Aresta {
  final No pai;
  final No filho;

  Aresta({
    required this.pai,
    required this.filho,
  });
}

//* Classe Arvore
class Arvore {
  List<No> vertices = [];
  List<Aresta> arestas = [];

  Arvore({
    required this.vertices,
    required this.arestas,
  });

  // Lista de nós adjacentes
  List<No> adjacente(No vertice) {
    List<No> contato = [];
    for (var i = 0; i < arestas.length; i++) {
      // if (arestas[i].filho == vertice) {
      //   contato.add(arestas[i].pai);
      // } else

      if (arestas[i].pai == vertice) {
        contato.add(arestas[i].filho);
      }
    }
    return contato;
  }

  // List<String> adjacente_string(No vertice) {
  //   List<String> contato = [];
  //   for (var i = 0; i < arestas.length; i++) {
  //     if (arestas[i].filho == vertice) {
  //       contato.add(arestas[i].pai.label);
  //     } else if (arestas[i].pai == vertice) {
  //       contato.add(arestas[i].filho.label);
  //     }
  //   }
  //   return contato;
  // }
}
