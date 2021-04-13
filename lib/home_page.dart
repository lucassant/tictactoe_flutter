import 'package:flutter/material.dart';
import 'package:tictactoe/controller.dart';

class HomePage extends StatelessWidget {
  final controller = new Controller();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text('Tic Tac Toe'),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.refresh),
          onPressed: () {
            controller.startGame();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 100,
              color: Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ValueListenableBuilder<bool>(
                    valueListenable: controller.isPlayer1,
                    builder: (_, isPlayer1, __) => Column(
                      children: [
                        Text(
                          'Player X',
                          style: TextStyle(
                              color:
                                  isPlayer1 ? Colors.teal[400] : Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        ValueListenableBuilder<int>(
                          valueListenable: controller.player1Score,
                          builder: (_, value, __) => Text(
                            '$value',
                            style: TextStyle(
                                color:
                                    isPlayer1 ? Colors.teal[400] : Colors.white,
                                fontSize: 32,
                                fontWeight: FontWeight.w500),
                          ),
                        )
                      ],
                    ),
                  ),
                  ValueListenableBuilder<bool>(
                    valueListenable: controller.isPlayer1,
                    builder: (_, isPlayer1, __) => Column(
                      children: [
                        Text(
                          'Player O',
                          style: TextStyle(
                              color: !isPlayer1
                                  ? Colors.redAccent[400]
                                  : Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        ValueListenableBuilder<int>(
                          valueListenable: controller.player2Score,
                          builder: (_, value, __) => Text(
                            '$value',
                            style: TextStyle(
                                color: !isPlayer1
                                    ? Colors.redAccent[400]
                                    : Colors.white,
                                fontSize: 32,
                                fontWeight: FontWeight.w500),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            ValueListenableBuilder<List<String>>(
              valueListenable: controller.lista,
              builder: (context, value, child) => Container(
                child: !controller.gameIsFinished
                    ? Expanded(
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 1,
                          ),
                          padding: const EdgeInsets.all(8),
                          itemBuilder: (context, index) => InkWell(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  border: Border.all(color: Colors.grey)),
                              child: Center(
                                  child: Text(
                                '${value[index]}',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 40),
                              )),
                            ),
                            onTap: () {
                              controller.onClick(index);
                            },
                          ),
                          itemCount: controller.lista.value.length,
                        ),
                      )
                    : Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              controller.winner != WinnerType.draw
                                  ? controller.winner == WinnerType.player1
                                      ? 'Player X win'
                                      : 'Player O win'
                                  : 'Draw',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 30),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.transparent,
                                    elevation: 0,
                                    side: BorderSide(
                                        width: 2, color: Colors.white)),
                                onPressed: () {
                                  controller.startGame();
                                },
                                child: Text(
                                  'Restart game',
                                  style: TextStyle(fontSize: 18),
                                ))
                          ],
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
