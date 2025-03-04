import 'dart:io';
import 'korabl.dart';
import 'pole.dart';

void main() {
  Main game = Main();
  game.play();
}

class Main{
  //поля
  Pole pole1 = Pole();
  Pole pole2 = Pole();
  //счеты
  int schet1 = 0; 
  int schet2 = 0;

  void rasstanovka_na_pole(Pole board, String player){
    print("\n$player расставляет корабли");
    List<int> korabl_sizes = [4, 3, 3, 2, 2, 2, 1, 1, 1, 1];
    for (int size in korabl_sizes){
      bool placed = false;
      while (!placed){
        print('\nРазмести корабль размером $size.');
        print('Введите координаты по горизонтали и вертикали, а также направление (0 - горизонтально, 1 - вертикально):');
        try {
          var vvod = stdin.readLineSync()!.split(' ');
          if (vvod.length != 3) {
            throw FormatException('ведите 3 значения: x, y и направление.');
          }
          int x = int.parse(vvod[0]) - 1;

          int y = int.parse(vvod[1]) - 1;
          String direction = vvod[2].toLowerCase();

          if (x < 0 || x >= Pole.size || y < 0 || y >= Pole.size){
            throw FormatException('Вводи корды от 1 до 10');
          }

          if (direction != '0' && direction != '1') {
            throw FormatException('Направление должно быть 0 - горизонтально или 1 - вертикально.');
          }

          bool isHorizontal = direction == '0';

          if (proverka(board, x, y, size, isHorizontal)) {
            board.rasstanovka(Korabl(size), x, y, isHorizontal);
            placed = true;
            board.display();
          }
          else {
            print('Тут нельзя поставиьт корабль!!!');
          }
        }
        on FormatException catch (e) {
          print('Ошибка: ${e.message}');
        }
        catch (e) {
          print('Неправильно ввел данные -_-');
        }
      }
    }
  }

  bool proverka(Pole board, int x, int y, int size, bool gorizontalno) {
    if (gorizontalno = true) {
      if (y + size > Pole.size) return false;
      for (int i = 0; i < size; i++) {
        if (board.pole[x][y + i] != ' ') return false;
      }
    }
    else {
      if (x + size > Pole.size) return false;
      for (int i = 0; i < size; i++) {
        if (board.pole[x + i][y] != ' ') return false;
      }
    }
    return true;
  }

  void play(){
    rasstanovka_na_pole(pole1, 'Игрок 1');
    rasstanovka_na_pole(pole2, 'Игрок 2');

    bool xod1 = true;

    while (true){
      if (xod1){
        print('\nИгрок 1 ходит');
        print('Поле противника:');
        pole2.display(sp_korabli: true);
        print('\nСчет: Игрок 1 - $schet1, Игрок 2 - $schet2');
        print('Введите координаты для выстрела (x y):');
        try{
          var input = stdin.readLineSync()!.split(' ');
          if (input.length != 2) {
            throw FormatException('Некорректный ввод. Введите 2 значения: x и y.');
          }

          int x = int.parse(input[0]) - 1;
          int y = int.parse(input[1]) - 1;

          if (x < 0 || x >= Pole.size || y < 0 || y >= Pole.size){
            throw FormatException('Координаты должны быть от 1 до 10.');
          }

          if (pole2.popal_ili_net(x, y)){
            print('Попадание!');
            schet1++;
            if (pole2.vseUbiti()){
              print('Игрок 1 выиграл!');
              print('Финальный счет: Игрок 1 - $schet1, Игрок 2 - $schet2');
              print('У победителя осталось ${pole1.ostalosKorabley()} кораблей.');
              break;
            }
          }
          else{
            print('Промах!');
          }
        }
        on FormatException catch (e){
          print('Ошибка: ${e.message}');
        }
        catch (e){
          print('Ошибка: некорректный ввод. Введите числа для координат.');
        }
      }
      else{
        print('\nИгрок 2, ваш ход!');
        print('Поле противника:');
        pole1.display(sp_korabli: true);
        print('\nСчет: Игрок 1 - $schet1, Игрок 2 - $schet2');
        print('Введите координаты для выстрела (x y):');
        try{
          var input = stdin.readLineSync()!.split(' ');
          if (input.length != 2){
            throw FormatException('Некорректный ввод. Введите 2 значения: x и y.');
          }

          int x = int.parse(input[0]) - 1;
          int y = int.parse(input[1]) - 1;

          if (x < 0 || x >= Pole.size || y < 0 || y >= Pole.size){
            throw FormatException('Координаты должны быть от 1 до 10.');
          }

          if (pole1.popal_ili_net(x, y)){
            print('Попадание!');
            schet2++;
            if (pole1.vseUbiti()){
              print('Игрок 2 выиграл!');
              print('Финальный счет: Игрок 1 - $schet1, Игрок 2 - $schet2');
              print('У победителя осталось ${pole2.ostalosKorabley()} кораблей.');
              break;
            }
          }
          else{
            print('Промах!');
          }
        }
        on FormatException catch (e) {
          print('Ошибка: ${e.message}');
        }
        catch (e) {
          print('Ошибка: некорректный ввод. Введите числа для координат.');
        }
      }
      xod1 = !xod1;
    }
  }
}