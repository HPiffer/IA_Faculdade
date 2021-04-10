import 'dart:collection';
import 'arvore_valorada.dart';

main(List<String> args) {
  // Criando Nós
  var a = No("a");
  var b = No("b");
  var c = No("c");
  var d = No("d");
  var e = No("e");
  var f = No("f");
  var g = No("g");
  var h = No("h");
  var i = No("i");
  List<No> nos = [a, b, c, d, e, f, g, h, i];

  //            [a]
  //          3/   \5
  //        [b]     [c]
  //      1/   \4      \8
  //    [d]     [e]     [f]
  //  6/   \7  /   \2
  //[g]     [h]     [i]
  //
  //Criando Arestas
  List<Aresta> arestas = [
    Aresta(pai: a, filho: b, distancia: 3),
    Aresta(pai: b, filho: d, distancia: 1),
    Aresta(pai: d, filho: g, distancia: 6),
    Aresta(pai: d, filho: h, distancia: 7),
    Aresta(pai: b, filho: e, distancia: 4),
    Aresta(pai: e, filho: i, distancia: 2),
    Aresta(pai: a, filho: c, distancia: 5),
    Aresta(pai: c, filho: f, distancia: 8),
  ];

  //Criando Arvore
  Arvore arvore = new Arvore(
    vertices: nos,
    arestas: arestas,
  );

  //Busca em Largura
  busca_em_largura(Arvore arvore, No raiz, No busca) {
    // Pilha consistindo no nó Raiz
    Queue<No> pilha = new Queue();
    List<No> aux = [];
    List<No> visitados = []; // Lista de nós visitados
    int dist = 0; // Distancia calculada

    // Até que a Pilha esteja vazia ou que o nó destino tenha sido encontrado
    pilha.add(raiz);

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

        if (pilha.first == busca) {
          // Se for p primeiro elemento da Pilha
          print('Sucesso!');
          print('Distancia = ${dist}');
          return;
        } else {
          // Se não for, removeno o elemento e adicionando seus filhos
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

  busca_em_largura(arvore, a, g);
}
