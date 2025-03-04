import 'korabl.dart';
import 'dart:io';
class Pole{
  static const int size = 10;
  List<List<String>> pole = List.generate(size, (_) => List.filled(size, ' '));
  List<Korabl> korabli = [];

  void rasstanovka(Korabl ship, int x, int y, bool isHorizontal){
    if (isHorizontal) {
      for (int i = 0; i < ship.size; i++) {
        pole[x][y + i] = 'K'; 
        ship.positions.add([x, y + i]);
      }
    } else {
      for (int i = 0; i < ship.size; i++) {
        pole[x + i][y] = 'K';
        ship.positions.add([x + i, y]);
      }
    }
    korabli.add(ship);
  }



  bool popal_ili_net(int x, int y){
    for (var ship in korabli) {
      for (var pos in ship.positions) {
        if (pos[0] == x && pos[1] == y) {
          ship.pops[ship.positions.indexOf(pos)] = true;
          pole[x][y] = 'X'; //попал
          return true;
        }
      }
    }
    pole[x][y] = '*';//мимо
    return false;
  }

  bool vseUbiti(){
    bool allSunk = true;
    for (var ship in korabli){
      if (!ship.ubit()) {
        allSunk = false;
        break;
      }
    }
    return allSunk;
  }

  void display({bool sp_korabli = false}) {
    print('  1 2 3 4 5 6 7 8 9 10'); 
    for (int i = 0; i < size; i++) {
      stdout.write('${i + 1} ');

      for (int j = 0; j < size; j++) {
        if (sp_korabli && pole[i][j] == 'K') {
          stdout.write('  ');
        }
        else {
          stdout.write('${pole[i][j]} ');
        }
      }
      print('');
    }
  }

  int ostalosKorabley() {
    int count = 0;
    for (var ship in korabli) {
      if (!ship.ubit()) {
        count++;
      }
    }
    return count;
  }
}