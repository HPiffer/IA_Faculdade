//* Classe Nó
import 'dart:math';

class No {
  final String label;
  final int x;
  final int y;

  No({
    required this.label,
    required this.x,
    required this.y,
  });

  @override
  String toString() {
    return this.label;
  }
}

//* Classe Aresta
class Aresta {
  final No pai;
  final No filho;
  double distancia = 0;

  Aresta({
    required this.pai,
    required this.filho,
  }) {
    this.distancia = calculaDistancia();
  }

  double calculaDistancia() {
    return sqrt(pow(this.filho.x - pai.x, 2) + pow(this.filho.y - pai.y, 2));
  }
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
  double distancia(No pai, No filho) {
    double dist = 0;
    for (var i = 0; i < arestas.length; i++) {
      if (arestas[i].pai == pai && arestas[i].filho == filho) {
        dist = arestas[i].distancia;
        break;
      }
    }
    return dist;
  }

  List<No> menorDistancia(No pai, List<No> filhos) {
    List<No> filhosOrdenados = [];
    No menorFilho = pai; // Pq a distancia é 0
    double menorDistancia = 0;

    // Se lista n for vazia
    int num = filhos.length;
    for (var j = 0; j < num; j++) {
      for (var i = 0; i < filhos.length; i++) {
        if (menorDistancia == 0 || distancia(pai, filhos[i]) < menorDistancia) {
          menorDistancia = distancia(pai, filhos[i]);
          menorFilho = filhos[i];
          // print('Filho[i] = ${filhos[i]}');
        }
      }
      filhosOrdenados.add(menorFilho);
      // print('adicionando ordenados $filhosOrdenados');
      filhos.remove(menorFilho);
      menorDistancia = 0;
    }

    return filhosOrdenados;
  }

  // Lista de nós filhos
  List<No> getFilhos(No vertice) {
    List<No> contato = [];
    for (var i = 0; i < arestas.length; i++) {
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
