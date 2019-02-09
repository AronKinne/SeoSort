ArrayList<Integer> seoSort(ArrayList<Integer> array) {
  splits = 0;
  divChecks = 0;
  maxS = 0;
  arrAcc = 0;
  extraArr = 0;
  sorted = false;
  nanos = 0;
  nanoStart = (int)System.nanoTime();

  ArrayList<Integer> out = split(array, 1, 0);

  nanos = (int)System.nanoTime() - nanoStart;
  sorted = true;

  return out;
}

ArrayList<Integer> split(ArrayList<Integer> array, int s, int o) {
  splits++;
  maxS = max(maxS, s);

  ArrayList<Integer> divisible = new ArrayList<Integer>();
  ArrayList<Integer> undivisible = new ArrayList<Integer>();

  for (int i = 0; i < array.size(); i++) {
    arrAcc += 2;
    extraArr++;
    if (isDivisible(array.get(i), (int)pow(2, s), o)) divisible.add(array.get(i));
    //pow(x, y) gibt x hoch y zurück
    else undivisible.add(array.get(i));
  }

  if (divisible.size() > 1) {
    int off = getOffset(divisible, (int)pow(2, s + 1));
    divisible = split(divisible, s + 1, off);
  }

  if (undivisible.size() > 1) {
    int off = getOffset(undivisible, (int)pow(2, s + 1));
    undivisible = split(undivisible, s + 1, off);
  }

  return merge(divisible, undivisible);
}

ArrayList<Integer> merge(ArrayList<Integer> divisible, ArrayList<Integer> undivisible) {  
  ArrayList<Integer> output = new ArrayList<Integer>();

  for (int i = 0; i < divisible.size() + undivisible.size(); i++) {
    arrAcc++;
    extraArr++;
    if (i % 2 == 0) {
      output.add(undivisible.get(floor(i / 2)));
    } else {
      output.add(divisible.get(floor(i / 2)));
    }
  }

  return output;
}

int getOffset(ArrayList<Integer> array, int e) {
  int off = Integer.MAX_VALUE;
  for (int i = 0; i < array.size(); i++) {
    arrAcc++;
    if (array.get(i) <= e) {
      arrAcc++;
      off = min(off, e - array.get(i));
      //min(x, y) gibt den kleineren der beiden Werte zurück
      if (off == 0) break;
    }
  }
  return off;
}

boolean isDivisible(int x, int e, int o) { 
  divChecks++;
  return (x + o) % e == 0;
}