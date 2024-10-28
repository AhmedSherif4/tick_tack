import 'dart:math';

class Player {
  static const o = 'O';
  static const x = 'X';
  static const empty = '';

  static List<int> playerX = [];
  static List<int> playerO = [];
}

extension ContainsAll on List {
  bool containsAll(int a, int b, [c]) {
    if (c == null) {
      return contains(a) && contains(b);
    } else {
      return contains(a) && contains(b) && contains(c);
    }
  }
}

class Game {
  static void playGame(int index, String activePlayer) {
    if (activePlayer == 'X') {
      Player.playerX.add(index);
    } else if (activePlayer == 'O') {
      Player.playerO.add(index);
    }
  }

  checkWinner() {
    String winner = '';
    if (Player.playerX.containsAll(0, 1, 2) ||
        Player.playerX.containsAll(3, 4, 5) ||
        Player.playerX.containsAll(6, 7, 8) ||
        Player.playerX.containsAll(0, 3, 6) ||
        Player.playerX.containsAll(1, 4, 7) ||
        Player.playerX.containsAll(2, 5, 8) ||
        Player.playerX.containsAll(0, 4, 8) ||
        Player.playerX.containsAll(2, 4, 6)) {
      winner = 'X';
    } else if (Player.playerO.containsAll(0, 1, 2) ||
        Player.playerO.containsAll(3, 4, 5) ||
        Player.playerO.containsAll(6, 7, 8) ||
        Player.playerO.containsAll(0, 3, 6) ||
        Player.playerO.containsAll(1, 4, 7) ||
        Player.playerO.containsAll(2, 5, 8) ||
        Player.playerO.containsAll(0, 4, 8) ||
        Player.playerO.containsAll(2, 4, 6)) {
      winner = 'O';
    } else {
      winner = '';
    }
    return winner;
  }

  Future<void> autoPlay(activePlayer) async {
    int index = 0;
    List<int> emptyCell =
        []; // قائمة احتمالات المربعات اللي ممكن يلعبها الكمبيوتر

    for (var i = 0; i < 9; i++) {
      // اللي فاضي ضيفه فالقائمة
      if (!(Player.playerX.contains(i) || Player.playerO.contains(i)))
        emptyCell.add(i);
    }

//START CENTER ATTACK
    if (Player.playerO.containsAll(0, 1) && emptyCell.contains(2)) {
      index = 2;
    } else if (Player.playerO.containsAll(3, 4) && emptyCell.contains(5)) {
      index = 5;
    } else if (Player.playerO.containsAll(6, 7) && emptyCell.contains(8)) {
      index = 8;
    } else if (Player.playerO.containsAll(0, 3) && emptyCell.contains(6)) {
      index = 6;
    } else if (Player.playerO.containsAll(1, 4) && emptyCell.contains(7)) {
      index = 7;
    } else if (Player.playerO.containsAll(2, 5) && emptyCell.contains(8)) {
      index = 8;
    } else if (Player.playerO.containsAll(0, 4) && emptyCell.contains(8)) {
      index = 8;
    } else if (Player.playerO.containsAll(2, 4) && emptyCell.contains(6)) {
      index = 6;
      // start end attack
    } else if (Player.playerO.containsAll(0, 2) && emptyCell.contains(1)) {
      index = 1;
    } else if (Player.playerO.containsAll(3, 5) && emptyCell.contains(4)) {
      index = 4;
    } else if (Player.playerO.containsAll(6, 8) && emptyCell.contains(7)) {
      index = 7;
    } else if (Player.playerO.containsAll(0, 6) && emptyCell.contains(3)) {
      index = 3;
    } else if (Player.playerO.containsAll(1, 7) && emptyCell.contains(4)) {
      index = 4;
    } else if (Player.playerO.containsAll(2, 8) && emptyCell.contains(5)) {
      index = 5;
    } else if (Player.playerO.containsAll(0, 8) && emptyCell.contains(4)) {
      index = 4;
    } else if (Player.playerO.containsAll(2, 6) && emptyCell.contains(4)) {
      index = 4;
    }
    // center end attack
    else if (Player.playerO.containsAll(1, 2) && emptyCell.contains(0)) {
      index = 1;
    } else if (Player.playerO.containsAll(4, 5) && emptyCell.contains(3)) {
      index = 4;
    } else if (Player.playerO.containsAll(7, 8) && emptyCell.contains(6)) {
      index = 7;
    } else if (Player.playerO.containsAll(3, 6) && emptyCell.contains(0)) {
      index = 3;
    } else if (Player.playerO.containsAll(4, 7) && emptyCell.contains(1)) {
      index = 4;
    } else if (Player.playerO.containsAll(5, 8) && emptyCell.contains(2)) {
      index = 5;
    } else if (Player.playerO.containsAll(4, 8) && emptyCell.contains(0)) {
      index = 4;
    } else if (Player.playerO.containsAll(4, 6) && emptyCell.contains(2)) {
      index = 4;
    }
    //START CENTER defend
    else if (Player.playerO.containsAll(0, 1) && emptyCell.contains(2)) {
      index = 2;
    } else if (Player.playerX.containsAll(3, 4) && emptyCell.contains(5)) {
      index = 5;
    } else if (Player.playerX.containsAll(6, 7) && emptyCell.contains(8)) {
      index = 8;
    } else if (Player.playerX.containsAll(0, 3) && emptyCell.contains(6)) {
      index = 6;
    } else if (Player.playerX.containsAll(1, 4) && emptyCell.contains(7)) {
      index = 7;
    } else if (Player.playerX.containsAll(2, 5) && emptyCell.contains(8)) {
      index = 8;
    } else if (Player.playerX.containsAll(0, 4) && emptyCell.contains(8)) {
      index = 8;
    } else if (Player.playerX.containsAll(2, 4) && emptyCell.contains(6)) {
      index = 6;
// start end defend
    } else if (Player.playerX.containsAll(0, 2) && emptyCell.contains(1)) {
      index = 1;
    } else if (Player.playerX.containsAll(3, 5) && emptyCell.contains(4)) {
      index = 4;
    } else if (Player.playerX.containsAll(6, 8) && emptyCell.contains(7)) {
      index = 7;
    } else if (Player.playerX.containsAll(0, 6) && emptyCell.contains(3)) {
      index = 3;
    } else if (Player.playerX.containsAll(1, 7) && emptyCell.contains(4)) {
      index = 4;
    } else if (Player.playerX.containsAll(2, 8) && emptyCell.contains(5)) {
      index = 5;
    } else if (Player.playerX.containsAll(0, 8) && emptyCell.contains(4)) {
      index = 4;
    } else if (Player.playerX.containsAll(2, 6) && emptyCell.contains(4)) {
      index = 4;
    }
    // center end defend
    else if (Player.playerX.containsAll(1, 2) && emptyCell.contains(0)) {
      index = 1;
    } else if (Player.playerX.containsAll(4, 5) && emptyCell.contains(3)) {
      index = 4;
    } else if (Player.playerX.containsAll(7, 8) && emptyCell.contains(6)) {
      index = 7;
    } else if (Player.playerX.containsAll(3, 6) && emptyCell.contains(0)) {
      index = 3;
    } else if (Player.playerX.containsAll(4, 7) && emptyCell.contains(1)) {
      index = 4;
    } else if (Player.playerX.containsAll(5, 8) && emptyCell.contains(2)) {
      index = 5;
    } else if (Player.playerX.containsAll(4, 8) && emptyCell.contains(0)) {
      index = 4;
    } else if (Player.playerX.containsAll(4, 6) && emptyCell.contains(2)) {
      index = 4;
    }
    if (emptyCell.isEmpty) {
      index = 0;
    } else {
      Random random = Random();
      int randomIndex =
          (random.nextInt(emptyCell.length)); // اختار بشكل عشوائي من القائمة
      index = emptyCell[randomIndex];
    }

    playGame(index, activePlayer); // ودي اللي انت اختارته لفانكشن تنفيذ اللعب
  }
}
