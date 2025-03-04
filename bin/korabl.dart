class Korabl {
  int size;
  List<List<int>> positions = [];
  List<bool> pops = [];

  Korabl(this.size){
    pops = List.filled(size, false);
  }

  bool ubit(){
    bool vseHit = true;
    for (bool hit in pops) {
      if (!hit){
        vseHit = false;
        break;
      }
    }
    return vseHit;
  }
}