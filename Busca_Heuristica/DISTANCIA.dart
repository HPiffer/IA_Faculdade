import 'dart:collection';
import 'arvore_valorada.dart';

main(List<String> args) {
  //Variaveis de controle
  var resultado;

  // Criando Nós
  var a = No(label: 'a', x: 2, y: 4);
  var b = No(label: 'b', x: 5, y: 6);
  var c = No(label: 'c', x: 4, y: 2);
  var d = No(label: 'd', x: 7, y: 4);
  var g = No(label: 'g', x: 8, y: 2);
  var h = No(label: 'h', x: 10, y: 1);
  var n = No(label: 'n', x: 11, y: 3);
  var s = No(label: 's', x: 13, y: 2);
  var p = No(label: 'p', x: 12, y: 6);
  var q = No(label: 'q', x: 11, y: 7);
  var m = No(label: 'm', x: 9, y: 6);
  var f = No(label: 'f', x: 7, y: 8);
  List<No> nos = [a, b, c, d, g, h, n, s, p, q, m, f];

  //* Olhar grafo.png ==========================================================

  //Criando Arestas
  List<Aresta> arestas = [
    Aresta(pai: a, filho: b),
    Aresta(pai: b, filho: c),
    Aresta(pai: c, filho: d),
    Aresta(pai: d, filho: g),
    Aresta(pai: d, filho: n),
    Aresta(pai: n, filho: s),
    Aresta(pai: n, filho: h),
    Aresta(pai: h, filho: g),
    Aresta(pai: d, filho: q),
    Aresta(pai: q, filho: p),
    Aresta(pai: p, filho: s),
    Aresta(pai: p, filho: n),
    Aresta(pai: b, filho: m),
    Aresta(pai: m, filho: f),
  ];

  //Criando Arvore
  Arvore arvore = new Arvore(
    vertices: nos,
    arestas: arestas,
  );

  //Busca algoritmo A*
  busca_a_estrela(Arvore arvore, No origem, No destino) {
    // Pilha consistindo no nó Raiz
    Queue<No> pilha = new Queue();
    List<No> aux = [];
    List<No> visitados = []; // Lista de nós visitados
    double dist = 0; // Distancia calculada

    pilha.add(origem);

    // Até que a Pilha esteja vazia ou que o nó destino tenha sido encontrado
    while (pilha.isNotEmpty) {
      print(pilha.first.toString());

      // Verifica se o nó já foi visitado
      if (visitados.contains(pilha.first)) {
        print('Remove ${pilha.first.toString()}');

        // Subtrai distância
        if (arvore.getPai(pilha.first) == null) {
          // É o nó raiz
          print('Nó raiz');
        } else {
          print('Distancia = ${dist}');
          dist -= arvore.distancia(arvore.getPai(pilha.first), pilha.first);
        }

        pilha.removeFirst();
      } else {
        // Adiciona distância
        if (arvore.getPai(pilha.first) == null) {
          // É o nó raiz
          print('Nó raiz');
        } else {
          print('Distancia = ${dist}');
          dist += arvore.distancia(arvore.getPai(pilha.first), pilha.first);
        }

        if (pilha.first == destino) {
          // Se for p primeiro elemento da Pilha
          print('Sucesso!');
          print('Distancia = ${dist}');
          return;
        } else {
          // Se não for, remove o elemento e adicionando seus filhos
          visitados.add(pilha.first);

          // Salva o nó atual para inserir os filhos
          aux = arvore.getFilhos(pilha.first);

          for (var i = 0; i < aux.length; i++) {
            pilha.addFirst(aux[i]);
          }
        }
      }
    }
  }

  //Busca algoritmo Guloso
  void busca_gulosa(Arvore arvore, No origem, No destino) {}

  busca_a_estrela(arvore, a, g);
}
