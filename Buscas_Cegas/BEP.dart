import 'dart:collection';
import 'arvore.dart';

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
  //           /   \
  //        [b]     [c]
  //       /   \       \
  //    [d]     [e]     [f]
  //   /   \       \
  //[g]     [h]     [i]
  //
  //Criando Arestas
  List<Aresta> arestas = [
    Aresta(pai: a, filho: b),
    Aresta(pai: b, filho: d),
    Aresta(pai: d, filho: g),
    Aresta(pai: d, filho: h),
    Aresta(pai: b, filho: e),
    Aresta(pai: e, filho: i),
    Aresta(pai: a, filho: c),
    Aresta(pai: c, filho: f),
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

    pilha.add(raiz);

    // Até que a Pilha esteja vazia ou que o nó destino tenha sido encontrado
    while (pilha.isNotEmpty) {
      print(pilha.first.toString());

      // Verifica se o nó já foi visitado
      if (visitados.contains(pilha.first)) {
        print('Remove ${pilha.first.toString()}');
        pilha.removeFirst();
      } else {
        if (pilha.first == busca) {
          // Se for p primeiro elemento da Pilha
          print('Sucesso!');
          return;
        } else {
          // Se não for, remove o elemento e adicionando seus filhos
          visitados.add(pilha.first);

          // Salva o nó atual para inserir os filhos
          aux = arvore.adjacente(pilha.first);

          for (var i = 0; i < aux.length; i++) {
            pilha.addFirst(aux[i]);
            print('AUX ADD = ${aux[i]}');
          }
        }
      }
    }
  }

  busca_em_largura(arvore, a, h);
}
