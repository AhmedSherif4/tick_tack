import 'package:flutter/material.dart';
import 'package:tick_tack/game_logic.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String activePlayer = 'X';
  bool gameOver = false;
  int tune = 0;
  String result = '#######';
  Game game = Game();
  bool isSwitcher = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: MediaQuery.of(context).orientation == Orientation.portrait
            ? Column(
                children: [
                  ...firstBlock(),
                  _expanded(context),
                  ...lastBlock(),
                ],
              )
            : Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ...firstBlock(),
                        ...lastBlock(),
                      ],
                    ),
                  ),
                  _expanded(context),
                ],
              ),
      ),
    );
  }

  Expanded _expanded(BuildContext context) {
    return Expanded(
      child: GridView.count(
        padding: const EdgeInsets.all(16),
        mainAxisSpacing: 8.0, //المسافات مابين المربعات
        crossAxisSpacing: 8.0,
        childAspectRatio: 1.0, // نسبة الطول في العرض
        crossAxisCount: 3,
        children: List.generate(
            9,
            (index) => InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: gameOver ? null : () => _onTap(index),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).shadowColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                      child: Text(
                        Player.playerX.contains(index)
                            ? 'X'
                            : Player.playerO.contains(index)
                                ? 'O'
                                : '',
                        style: TextStyle(
                          color: Player.playerX.contains(index)
                              ? Colors.blue
                              : Colors.pink,
                          fontSize: 50,
                        ),
                      ),
                    ),
                  ),
                )),
      ),
    );
  }

  List<Widget> firstBlock() {
    return [
      SwitchListTile.adaptive(
        title: const Text(
          'Turn on/off two player',
          style: TextStyle(color: Colors.white, fontSize: 20),
          textAlign: TextAlign.center,
        ),
        value: isSwitcher,
        onChanged: (bool newValue) {
          setState(() {
            isSwitcher = newValue;
          });
        },
      ),
      Text(
        'it\'s $activePlayer turn'.toUpperCase(),
        style: const TextStyle(color: Colors.white, fontSize: 40),
        textAlign: TextAlign.center,
      ),
    ];
  }

  List<Widget> lastBlock() {
    return [
      Text(
        result,
        style: const TextStyle(color: Colors.white, fontSize: 30),
        textAlign: TextAlign.center,
      ),
      ElevatedButton.icon(
        onPressed: () {
          setState(() {
            Player.playerX = [];
            Player.playerO = [];
            activePlayer = 'X';
            gameOver = false;
            tune = 0;
            result = '';
          });
        },
        icon: const Icon(Icons.replay_circle_filled),
        label: const Text('repeat the game'),
        style: ButtonStyle(
            backgroundColor:
                WidgetStateProperty.all(Theme.of(context).splashColor)),
      )
    ];
  }

  _onTap(int index) async {
    if ((Player.playerX.isEmpty || !Player.playerX.contains(index)) &&
        (Player.playerO.isEmpty || !Player.playerO.contains(index))) {
      Game.playGame(index, activePlayer);
      updateState();

      if (!isSwitcher && !gameOver) {
        await game.autoPlay(activePlayer);
        updateState();
      }
    }
  }

  void updateState() {
    setState(
      () {
        activePlayer = (activePlayer == 'X') ? 'O' : 'X';

        tune++;

        String? winner = game.checkWinner();

        if (winner != '') {
          gameOver = true;
          result = '$winner هو اللي كسب';
        } else if (!gameOver && tune == 9) {
          result = 'تعادل!';
        }
      },
    );
  }
}
