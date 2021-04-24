import 'package:tic_tac_toe/app/models/move.dart';
import 'package:tic_tac_toe/app/utils/constants.dart';

class GameController {
  String showResult(int playerNumber) {
    if (playerNumber == 0)
      return TIED_TITLE;
    else if (playerNumber == 1)
      return USER_WON_TITLE;
    else
      return IA_WON_TITLE;
  }

  // Verifica se o jogo acabou
  bool isEndState(List<String> game) {
    var temp = findResult(game);
    if (temp == -1) return false;
    return true;
  }

  // Verifica o estado atual do jogo
  int findResult(List<String> game) {
    //? -1 = JOGO AINDA NÃO ACABOU
    //?  0 = EMPATE
    //?  1 = PLAYER
    //?  2 = IA

    // Verificar Linhas
    for (int i = 0; i < BOARD_SIZE; i += 3) {
      if (game[i] == game[i + 1] &&
          game[i + 1] == game[i + 2] &&
          game[i] != '') {
        if (game[i] == PLAYER2_SYMBOL) {
          return 1;
        } else if (game[i] == PLAYER1_SYMBOL) {
          return 2;
        }
      }
    }

    // Verificar Colunas
    for (int i = 0; i < 3; i++) {
      if (game[i] == game[i + 3] &&
          game[i + 3] == game[i + 6] &&
          game[i] != '') {
        if (game[i] == PLAYER2_SYMBOL) {
          return 1;
        } else if (game[i] == PLAYER1_SYMBOL) {
          return 2;
        }
      }
    }

    // Verifica Diagonal Principal
    if (game[0] == game[4] && game[4] == game[8] && game[0] != '') {
      if (game[0] == PLAYER2_SYMBOL) {
        return 1;
      } else if (game[0] == PLAYER1_SYMBOL) {
        return 2;
      }
    }

    // Verifica Diagonal Secundaria
    else if (game[2] == game[4] && game[4] == game[6] && game[2] != '') {
      if (game[2] == PLAYER2_SYMBOL) {
        return 1;
      } else if (game[2] == PLAYER1_SYMBOL) {
        return 2;
      }
    }

    // Verifica se existem espaços vazios
    for (int i = 0; i < BOARD_SIZE; i++) {
      if (game[i] == '') return -1;
    }

    // Se não existem espaços vazios e o jogo acabou
    // retorna como empate
    return 0;
  }

  // Busca pela pontuação do Minimax
  int getScore(List<String> game, int depth) {
    int res = findResult(game);
    if (res == 1)
      return 10 + depth;
    else if (res == 2) return depth - 10;

    return 0;
  }

  // Minimax
  // Move minimax(List<String> game, int depth, isMinimiser) {
  //   if (isEndState(game)) {
  //     return Move(
  //       score: getScore(game, depth),
  //       index: -1,
  //     );
  //   }

  //   // Verifica o tipo de Execução MIN || MAX
  //   if (isMinimiser) {
  //     // Executa minimiser
  //     Move min = new Move(score: 1000, index: -1);
  //     for (int i = 0; i < BOARD_SIZE; i++) {
  //       if (game[i] == '') {
  //         game[i] = PLAYER1_SYMBOL;

  //         Move value = minimax(game, depth + 1, false);
  //         if (value.score < min.score) {
  //           min.score = value.score;
  //           min.index = i;
  //         }
  //         game[i] = '';
  //       }
  //     }
  //     return min;
  //   } else {
  //     // Executa maximiser
  //     Move max = new Move(score: -1000, index: -1);

  //     for (int i = 0; i < BOARD_SIZE; i++) {
  //       if (game[i] == '') {
  //         game[i] = PLAYER2_SYMBOL;

  //         Move value = minimax(game, depth + 1, true);
  //         if (value.score > max.score) {
  //           max.score = value.score;
  //           max.index = i;
  //         }
  //         game[i] = '';
  //       }
  //     }
  //     return max;
  //   }
  // }

  Move minimax({
    required List<String> game,
    required int depth,
    required double alpha,
    required double beta,
    required bool isMinimiser,
  }) {
    if (isEndState(game)) {
      return Move(
        score: getScore(game, depth),
        index: -1,
      );
    }

    // Verifica o tipo de Execução MIN || MAX
    if (isMinimiser) {
      // Executa minimiser
      Move min = new Move(score: 1000, index: -1);
      for (int i = 0; i < BOARD_SIZE; i++) {
        if (game[i] == '') {
          game[i] = PLAYER1_SYMBOL;

          Move value = minimax(
            game: game,
            depth: depth + 1,
            alpha: alpha,
            beta: beta,
            isMinimiser: false,
          );

          if (beta > value.score) {
            beta = value.score.toDouble();
          }
          if (value.score < min.score) {
            min.score = value.score;
            min.index = i;
          }
          game[i] = '';
          if (beta <= alpha) {
            print('PODA ESSA MERDA');
            break;
          }
        }
      }
      return min;
    } else {
      // Executa maximiser
      Move max = new Move(score: -1000, index: -1);

      for (int i = 0; i < BOARD_SIZE; i++) {
        if (game[i] == '') {
          game[i] = PLAYER2_SYMBOL;

          Move value = minimax(
            game: game,
            depth: depth + 1,
            alpha: alpha,
            beta: beta,
            isMinimiser: true,
          );

          if (alpha < value.score) {
            alpha = value.score.toDouble();
          }
          if (value.score > max.score) {
            max.score = value.score;
            max.index = i;
          }
          game[i] = '';
          if (beta <= alpha) {
            print('PODA ESSA MERDA');
            break;
          }
        }
      }
      return max;
    }
  }
}
