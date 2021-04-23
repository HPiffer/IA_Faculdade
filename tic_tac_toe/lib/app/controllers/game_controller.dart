import 'dart:math';

import 'package:tic_tac_toe/app/models/board_tile.dart';
import 'package:tic_tac_toe/app/utils/constants.dart';
import 'package:tic_tac_toe/app/utils/enums.dart';
import 'package:tic_tac_toe/app/utils/winner_rules.dart';

class GameController {
  List<BoardTile> tiles = [];
  List<int> movesPlayer1 = [];
  List<int> movesPlayer2 = [];
  PlayerType currentPlayer = PlayerType.player1;
  bool isSinglePlayer = true;

  // Retorna se ainda existem movimentos
  bool get hasMoves =>
      (movesPlayer1.length + movesPlayer2.length) != BOARD_SIZE;

  GameController() {
    _initialize();
  }

  // Inicializa o Controller
  void _initialize() {
    movesPlayer1.clear();
    movesPlayer2.clear();
    currentPlayer = PlayerType.player1;
    tiles =
        List<BoardTile>.generate(BOARD_SIZE, (index) => BoardTile(index + 1));
  }

  void reset() {
    _initialize();
  }

  // Marcar campo
  void markBoardTileByIndex(index) {
    final tile = tiles[index];
    if (currentPlayer == PlayerType.player1) {
      _markBoardTileWithPlayer1(tile);
    } else {
      _markBoardTileWithPlayer2(tile);
    }
  }

  // Marca com X
  void _markBoardTileWithPlayer1(BoardTile tile) {
    tile.symbol = PLAYER1_SYMBOL;
    tile.color = PLAYER1_COLOR;
    movesPlayer1.add(tile.id);
    currentPlayer = PlayerType.player2;
  }

  // Marca com O
  void _markBoardTileWithPlayer2(BoardTile tile) {
    tile.symbol = PLAYER2_SYMBOL;
    tile.color = PLAYER2_COLOR;
    movesPlayer2.add(tile.id);
    currentPlayer = PlayerType.player1;
  }

  // Verifica se já existe algum ganhador
  bool _checkPlayerWinner(List<int> moves) {
    return winnerRules.any((rule) =>
        moves.contains(rule[0]) &&
        moves.contains(rule[1]) &&
        moves.contains(rule[2]));
  }

  // Retorna o jogador que venceu
  WinnerPlayer checkWinner() {
    if (_checkPlayerWinner(movesPlayer1)) return WinnerPlayer.player1;
    if (_checkPlayerWinner(movesPlayer2)) return WinnerPlayer.player2;

    //* Ninguem ganhou
    return WinnerPlayer.none;
  }

  // Movimento automático para testes
  int automaticMove() {
    var list = new List.generate(9, (index) => index + 1);
    list.removeWhere((element) => movesPlayer1.contains(element));
    list.removeWhere((element) => movesPlayer2.contains(element));

    var random = new Random();
    var index = random.nextInt(list.length - 1);
    return tiles.indexWhere((tile) => tile.id == list[index]);
  }
}
