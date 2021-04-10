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
    // Fila consistindo no nó Raiz
    Queue<No> fila = new Queue();

    fila.add(raiz);

    // Até que a fila esteja vazia ou que o nó destino tenha sido encontrado
    while (fila.isNotEmpty) {
      print(fila.first.toString());
      if (fila.first == busca) {
        // Se for p primeiro elemento da fila
        print('Sucesso!');
        return;
      } else {
        // Se não for, removeno o elemento e adicionando seus filhos
        fila.addAll(arvore.adjacente(fila.first));
        fila.remove(fila.first);
      }
    }
  }

  busca_em_largura(arvore, a, i);
}
