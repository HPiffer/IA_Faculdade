import 'dart:collection';
import 'dart:io';
import 'arvore_valorada.dart';

main(List<String> args) {
  //Variaveis de controle
  bool resultado = false;

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
    Aresta(pai: f, filho: q),
  ];

  //Criando Arvore
  Arvore arvore = new Arvore(
    vertices: nos,
    arestas: arestas,
  );

  // Calcula Distancia
  double calculaDistancia(Arvore arvore, Queue<No> pilha) {
    No trueFirst = pilha.first;
    pilha.removeFirst();
    double value = 0;
    while (pilha.isNotEmpty) {
      value += arvore.distancia(pilha.first, trueFirst);
      trueFirst = pilha.first;
      pilha.removeFirst();
    }
    return value;
  }

  //Busca algoritmo A*
  busca_a_estrela(Arvore arvore, No origem, No destino) {
    // Pilha consistindo no nó Raiz
    Queue<No> pilha = new Queue();
    List<No> aux = [];
    List<No> visitados = []; // Lista de nós visitados

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
        }

        pilha.removeFirst();
      } else {
        // Adiciona distância
        if (arvore.getPai(pilha.first) == null) {
          // É o nó raiz
          print('Nó raiz');
        }

        if (pilha.first == destino) {
          // Se for p primeiro elemento da Pilha
          print('Sucesso!');
          resultado = true;
          print(calculaDistancia(arvore, pilha));
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
    if (resultado == false) {
      print('Não se pode chegar até $destino a partir de $origem');
    }
  }

  //Busca algoritmo Guloso
  void busca_gulosa(Arvore arvore, No origem, No destino) {
    //Fila iniciando no nó origem
    Queue<No> pilha = new Queue();
    List<No> visitados = []; // Lista de nós visitados
    List<No> filhos = [];
    List<No> filhosOrdenados = [];

    pilha.add(origem);

    //Até que a fila esteja vazia ou que o nó destino tenha sido encontrado
    while (pilha.isNotEmpty) {
      print(pilha.first.toString());

      //Verifica se o nó ja foi visitado
      if (visitados.contains(pilha.first)) {
        print('Remove ${pilha.first.toString()}');

        // Subtrai distância
        if (arvore.getPai(pilha.first) == null) {
          // É o nó raiz
          print('Nó raiz');
        }

        pilha.removeFirst();
      } else {
        // Adiciona distância
        if (arvore.getPai(pilha.first) == null) {
          // É o nó raiz
          print('Nó raiz');
        }

        if (pilha.first == destino) {
          // Se for o primeiro elemento da fila
          print('Sucesso!');
          resultado = true;
          print(calculaDistancia(arvore, pilha));
          return;
        } else {
          // Se não for, marca o nó como visitado e adiciona seus filhos
          visitados.add(pilha.first);
          // print('Pilha atual $pilha');

          //Adiciona o menor filho na pilha
          filhos = arvore.getFilhos(pilha.first);
          // print('Buscou filhos $filhos');

          //Busca o filho com a menor distancia
          filhosOrdenados = arvore.menorDistancia(pilha.first, filhos);
          // print('Filhos ordenados $filhosOrdenados');
          for (var i = filhosOrdenados.length; i > 0; i--) {
            pilha.addFirst(filhosOrdenados[i - 1]);
          }
        }
      }
    }
    if (resultado == false) {
      print('Não se pode chegar até $destino a partir de $origem');
    }
  }

  //Funcao para leitura
  print("========================================");
  print("===== Selecione um metodo de busca =====");
  print("[1] - Método A* \n[2] - Método Guloso");
  var metodoBusca = stdin.readLineSync().toString();
  print("===== Digite uma cidade de origem ======");
  var inputOrigem = stdin.readLineSync().toString();
  print("===== Digite uma cidade de destino =====");
  var inputDestino = stdin.readLineSync().toString();
  print("========================================");
  //Atribuindo um tipo especifico a variavel
  //var idade = int.parse(input);

  var cidadeOrigem, cidadeDestino;

  for (var i = 0; i < arvore.vertices.length; i++) {
    if (arvore.vertices[i].label == inputOrigem) {
      cidadeOrigem = arvore.vertices[i];
    }
    if (arvore.vertices[i].label == inputDestino) {
      cidadeDestino = arvore.vertices[i];
    }
  }

  if (cidadeOrigem == null || cidadeDestino == null) {
    print('PREENCHE DIREITO DESGRAÇA');
    print('CIDADE N EXISTE');
  } else {
    if (metodoBusca == '1') {
      busca_a_estrela(arvore, cidadeOrigem, cidadeDestino);
    } else if (metodoBusca == '2') {
      busca_gulosa(arvore, cidadeOrigem, cidadeDestino);
    } else {
      print(
        'Valor errado, reinicia o programa aê'
        'pq eu to com preguiça de fazer um while!',
      );
    }
  }
}
