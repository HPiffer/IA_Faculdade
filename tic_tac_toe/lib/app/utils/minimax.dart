// https://github.com/saurabhmittal16/tic-tac-toe/blob/master/lib/utils.dart

class Move {
  int score;
  int index;

  Move({
    this.score = 0,
    this.index = 0,
  });
}

bool isEndState(List<String> s) {
  var temp = findResult(s);
  if (temp == -1) return false;
  return true;
}

int findResult(List<String> game) {
  // Check rows
  for (int i = 0; i < 9; i += 3) {
    if (game[i] == game[i + 1] && game[i + 1] == game[i + 2] && game[i] != '') {
      if (game[i] == 'O') {
        return 1;
      } else if (game[i] == 'X') {
        return 2;
      }
    }
  }

  // Check columns
  for (int i = 0; i < 3; i++) {
    if (game[i] == game[i + 3] && game[i + 3] == game[i + 6] && game[i] != '') {
      if (game[i] == 'O') {
        return 1;
      } else if (game[i] == 'X') {
        return 2;
      }
    }
  }

  // Check primary diagonal
  if (game[0] == game[4] && game[4] == game[8] && game[0] != '') {
    if (game[0] == 'O') {
      return 1;
    } else if (game[0] == 'X') {
      return 2;
    }
  }

  // Check secondary diagonal
  else if (game[2] == game[4] && game[4] == game[6] && game[2] != '') {
    if (game[2] == 'O') {
      return 1;
    } else if (game[2] == 'X') {
      return 2;
    }
  }

  // Check for empty spaces, if found -> game not over
  for (int i = 0; i < 9; i++) {
    if (game[i] == '') return -1;
  }

  // If no empty spaces and no winner then game is tied
  return 0;
}

// Minimax Algorithm
Move minimiser(List<String> s, int depth) {
  if (isEndState(s)) {
    return Move(score: getScore(s, depth), index: -1);
  }

  Move min = new Move(score: 1000, index: -1);

  for (int i = 0; i < 9; i++) {
    if (s[i] == '') {
      s[i] = 'X';

      Move curr = maximiser(s, depth + 1);
      if (curr.score < min.score) {
        min.score = curr.score;
        min.index = i;
      }
      s[i] = '';
    }
  }
  return min;
}

Move maximiser(List<String> s, int depth) {
  if (isEndState(s)) {
    return Move(score: getScore(s, depth), index: -1);
  }

  Move max = new Move(score: -1000, index: -1);

  for (int i = 0; i < 9; i++) {
    if (s[i] == '') {
      s[i] = 'O';

      Move curr = minimiser(s, depth + 1);
      if (curr.score > max.score) {
        max.score = curr.score;
        max.index = i;
      }
      s[i] = '';
    }
  }
  return max;
}

int getScore(List<String> s, int depth) {
  int res = findResult(s);
  if (res == 1)
    return 10 + depth;
  else if (res == 2) return depth - 10;

  return 0;
}
