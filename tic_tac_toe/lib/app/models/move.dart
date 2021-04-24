class Move {
  int score; // Pontuação para validação do Minimax
  int index; // Indice para retorno

  Move({
    this.score = 0,
    required this.index,
  });
}
