import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tic_tac_toe/app/controllers/game_controller.dart';
import 'package:tic_tac_toe/app/models/move.dart';
import 'package:tic_tac_toe/app/utils/constants.dart';

// =========================================== //
// Home Page
// =========================================== //
class GamePage extends StatefulWidget {
  @override
  _GamePageState createState() => _GamePageState();
}

// 1 Player Game
// User goes first and uses 'O'
// Game goes second and uses 'X'
// result = 0 -> Tie
// result = 1 -> Player won
// result = 2 -> Game won
class _GamePageState extends State<GamePage> {
  // =========================================== //
  // Declarations
  // =========================================== //
  GameController _controller = GameController();
  List<String> game = new List.filled(BOARD_SIZE, '');
  bool gameOver = false;
  int moves = 0;
  int result = 0;

  // =========================================== //
  // Functions
  // =========================================== //
  void onClick(int index) {
    // Verifica se o espaço está disponível
    if (game[index] == '') {
      setState(() {
        game[index] = PLAYER2_SYMBOL;
        moves++;
      });
      checkVictory();
      gameMove();
    }
  }

  // Reinicia o jogo
  void reset() {
    setState(() {
      game.fillRange(0, BOARD_SIZE, '');
      gameOver = false;
      moves = 0;
      result = 0;
    });
  }

  // Verifica vitória
  void checkVictory() {
    print(game);
    print(_controller.isEndState(game));

    int res = _controller.findResult(game);
    // Se o jogo acabou
    if (res != -1) {
      setState(() {
        result = res;
        gameOver = true;
      });
    }
  }

  // Movimentação da IA
  gameMove() {
    if (!gameOver) {
      Move best = _controller.minimax(game, 0, true);
      print('IA Jogou -> ${best.index}');

      setState(() {
        game[best.index] = PLAYER1_SYMBOL;
        moves++;
      });

      checkVictory();
    }
  }

  // UI Components
  Widget getTile(int index, String text) {
    return Container(
      // decoration: BoxDecoration(border: getBorders(index)),
      decoration: BoxDecoration(border: Border()),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontSize: 64,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

  Border getBorders(int index) {
    switch (index) {
      case 0:
        return Border(
          bottom: BorderSide(width: 2, color: Colors.deepPurple),
          right: BorderSide(width: 2, color: Colors.deepPurple),
        );
      case 1:
        return Border(
          bottom: BorderSide(width: 2, color: Colors.deepPurple),
          left: BorderSide(width: 2, color: Colors.deepPurple),
          right: BorderSide(width: 2, color: Colors.deepPurple),
        );
      case 2:
        return Border(
          bottom: BorderSide(width: 2, color: Colors.deepPurple),
          left: BorderSide(width: 2, color: Colors.deepPurple),
        );
      case 3:
        return Border(
          top: BorderSide(width: 2, color: Colors.deepPurple),
          bottom: BorderSide(width: 2, color: Colors.deepPurple),
          right: BorderSide(width: 2, color: Colors.deepPurple),
        );
      case 4:
        return Border.all(width: 2, color: Colors.deepPurple);
      case 5:
        return Border(
          top: BorderSide(width: 2, color: Colors.deepPurple),
          bottom: BorderSide(width: 2, color: Colors.deepPurple),
          left: BorderSide(width: 2, color: Colors.deepPurple),
        );
      case 6:
        return Border(
          top: BorderSide(width: 2, color: Colors.deepPurple),
          right: BorderSide(width: 2, color: Colors.deepPurple),
        );
      case 7:
        return Border(
          top: BorderSide(width: 2, color: Colors.deepPurple),
          left: BorderSide(width: 2, color: Colors.deepPurple),
          right: BorderSide(width: 2, color: Colors.deepPurple),
        );
      case 8:
        return Border(
          top: BorderSide(width: 2, color: Colors.deepPurple),
          left: BorderSide(width: 2, color: Colors.deepPurple),
        );
    }
    return Border.all(width: 2, color: Colors.deepPurple);
  }

  // =========================================== //
  // Screen
  // =========================================== //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(GAME_TITLE),
      ),
      body: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Container(
                    width: kIsWeb
                        ? MediaQuery.of(context).size.width > 300
                            ? 400
                            : MediaQuery.of(context).size.width
                        : MediaQuery.of(context).size.width,
                    child: gridCard(),
                  ),
                ),
                Opacity(
                  opacity: gameOver ? 1.0 : 0.0,
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: 36.0,
                    ),
                    child: Text(
                      _controller.showResult(result),
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                ),
                Opacity(
                  opacity: gameOver ? 1.0 : 0.0,
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: 32.0,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        reset();
                      },
                      child: Text('Clique Aqui para Jogar Novamente',
                          style: TextStyle(fontSize: 24)),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  gridCard() {
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: BOARD_SIZE,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      itemBuilder: (BuildContext context, int index) {
        return Card(
          elevation: 5,
          shadowColor: Colors.deepPurple,
          color: Colors.white,
          child: InkWell(
            splashColor: Colors.deepPurpleAccent,
            onTap: () {
              if (!gameOver) {
                onClick(index);
              }
            },
            child: Center(child: getTile(index, game[index])),
          ),
        );
      },
    );
  }
}
