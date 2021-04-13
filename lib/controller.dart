import 'package:flutter/cupertino.dart';

enum WinnerType { draw, player1, player2, none }

class Controller {
  ValueNotifier<List<String>> lista = ValueNotifier(List<String>.filled(9, ''));

  ValueNotifier<int> player1Score = ValueNotifier(0);
  ValueNotifier<int> player2Score = ValueNotifier(0);

  ValueNotifier<bool> isPlayer1 = ValueNotifier(true);
  bool gameIsFinished = false;
  WinnerType winner = WinnerType.none;

  void startGame() {
    initBoard();
    isPlayer1.value = true;
    gameIsFinished = false;
  }

  void onClick(int index) {
    if (lista.value[index] == '') {
      if (isPlayer1.value) {
        lista.value[index] = 'X';
      } else {
        lista.value[index] = 'O';
      }

      lista.value = List.from(lista.value);

      winner = winCheck();

      if (winner != WinnerType.none) {
        gameIsFinished = true;
        switch (winner) {
          case WinnerType.draw:
            player1Score.value++;
            player2Score.value++;
            break;
          case WinnerType.player1:
            player1Score.value += 3;
            player2Score.value -= 5;
            break;
          case WinnerType.player2:
            player1Score.value -= 5;
            player2Score.value += 3;
            break;
          default:
            break;
        }
        initBoard();
        return;
      }

      isPlayer1.value = !isPlayer1.value;
    }
  }

  void initBoard() {
    lista.value = List.from(List<String>.filled(9, ''));
  }

  WinnerType winCheck() {
    String playerInput = isPlayer1.value ? 'X' : 'O';

    // check rows
    if (lista.value[0].contains(playerInput) &&
        lista.value[1].contains(playerInput) &&
        lista.value[2].contains(playerInput)) {
      return isPlayer1.value ? WinnerType.player1 : WinnerType.player2;
    }

    if (lista.value[3].contains(playerInput) &&
        lista.value[4].contains(playerInput) &&
        lista.value[5].contains(playerInput)) {
      return isPlayer1.value ? WinnerType.player1 : WinnerType.player2;
    }

    if (lista.value[6].contains(playerInput) &&
        lista.value[7].contains(playerInput) &&
        lista.value[8].contains(playerInput)) {
      return isPlayer1.value ? WinnerType.player1 : WinnerType.player2;
    }

    // check columns
    if (lista.value[0].contains(playerInput) &&
        lista.value[3].contains(playerInput) &&
        lista.value[6].contains(playerInput)) {
      return isPlayer1.value ? WinnerType.player1 : WinnerType.player2;
    }

    if (lista.value[1].contains(playerInput) &&
        lista.value[4].contains(playerInput) &&
        lista.value[7].contains(playerInput)) {
      return isPlayer1.value ? WinnerType.player1 : WinnerType.player2;
    }

    if (lista.value[2].contains(playerInput) &&
        lista.value[5].contains(playerInput) &&
        lista.value[8].contains(playerInput)) {
      return isPlayer1.value ? WinnerType.player1 : WinnerType.player2;
    }

    // check diagonals
    if (lista.value[0].contains(playerInput) &&
        lista.value[4].contains(playerInput) &&
        lista.value[8].contains(playerInput)) {
      return isPlayer1.value ? WinnerType.player1 : WinnerType.player2;
    }

    if (lista.value[2].contains(playerInput) &&
        lista.value[4].contains(playerInput) &&
        lista.value[6].contains(playerInput)) {
      return isPlayer1.value ? WinnerType.player1 : WinnerType.player2;
    }

    if (lista.value.where((element) => element == '').isEmpty) {
      return WinnerType.draw;
    }

    return WinnerType.none;
  }
}
