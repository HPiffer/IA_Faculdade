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
  final int distancia;

  Aresta({
    required this.pai,
    required this.filho,
    required this.distancia,
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

  // Distancia
  int distancia(No pai, No filho) {
    int dist = 0;
    for (var i = 0; i < arestas.length; i++) {
      if (arestas[i].pai == pai && arestas[i].filho == filho) {
        dist = arestas[i].distancia;
        break;
      }
    }
    return dist;
  }

  // Lista de nós filhos
  List<No> getFilhos(No vertice) {
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

  // Busca pai
  getPai(No vertice) {
    var contato;
    for (var i = 0; i < arestas.length; i++) {
      // if (arestas[i].filho == vertice) {
      //   contato.add(arestas[i].pai);
      // } else

      if (arestas[i].filho == vertice) {
        contato = arestas[i].pai;
      }
    }
    if (contato == null) {
      // É o nó Raiz
    } else {
      return contato;
    }
  }
}
