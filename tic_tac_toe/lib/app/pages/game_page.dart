import 'package:flutter/material.dart';
import 'package:tic_tac_toe/app/controllers/game_controller.dart';
import 'package:tic_tac_toe/app/utils/constants.dart';
import 'package:tic_tac_toe/app/utils/enums.dart';
import 'package:tic_tac_toe/app/widgets/cistom_dialog_widget.dart';

// =========================================== //
// Home Page
// =========================================== //
class GamePage extends StatefulWidget {
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  // =========================================== //
  // Declarations
  // =========================================== //
  final _controller = GameController();

  // =========================================== //
  // Functions
  // =========================================== //
  _onResetGame() {
    setState(() {
      _controller.reset();
    });
  }

  //* Usuário clica no campo
  _onMarkTile(int index) {
    // Verifica se o campo está disponível
    if (!_controller.tiles[index].enable) return;

    // Se o cmapo estiver disponível, atualiza o conteúdo
    setState(() {
      _controller.markBoardTileByIndex(index);
    });

    // Verifica se depois da jogada alguem ganhou
    _checkWinner();
  }

  //* Verifica ganhador
  _checkWinner() {
    var winner = _controller.checkWinner();
    if (winner == WinnerPlayer.none) {
      if (!_controller.hasMoves) {
        _showTiedDialog();
      } else if (_controller.isSinglePlayer &&
          _controller.currentPlayer == PlayerType.player2) {
        final index = _controller.automaticMove();
        _onMarkTile(index);
      }
    } else {
      String symbol =
          winner == WinnerPlayer.player1 ? PLAYER1_SYMBOL : PLAYER2_SYMBOL;
      _showWinnerDialog(symbol);
    }
  }

  //* Pop up de ganhador
  _showWinnerDialog(String symbol) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return CustomDialog(
          title: WIN_TITLE.replaceAll('[SYMBOL]', symbol),
          message: DIALOG_MESSAGE,
          onPressed: _onResetGame,
        );
      },
    );
  }

  //* Pop up de empate
  _showTiedDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return CustomDialog(
          title: TIED_TITLE,
          message: DIALOG_MESSAGE,
          onPressed: _onResetGame,
        );
      },
    );
  }

  // =========================================== //
  // Screen
  // =========================================== //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(GAME_TITLE),
        actions: [
          IconButton(
            icon: _controller.isSinglePlayer
                ? Icon(Icons.person)
                : Icon(Icons.group),
            onPressed: () {
              setState(() {
                _controller.isSinglePlayer = !_controller.isSinglePlayer;
              });
            },
          ),
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: GridView.builder(
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
                    color: _controller.tiles[index].color,
                    child: InkWell(
                      splashColor:
                          _controller.currentPlayer == PlayerType.player1
                              ? PLAYER1_COLOR
                              : PLAYER2_COLOR,
                      onTap: () => _onMarkTile(index),
                      child: Center(
                        child: Text(
                          _controller.tiles[index].symbol,
                          style: TextStyle(
                            fontSize: 72,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Divider(),
            SizedBox(height: 10),
            Text(
              _controller.isSinglePlayer ? 'Singleplayer' : 'Multiplayer',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextButton(
                onPressed: _onResetGame,
                child: Text(
                  RESET_BUTTON_LABEL,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
