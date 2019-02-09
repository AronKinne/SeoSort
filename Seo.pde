void seoSort(ArrayList<Integer> array) {
  split(array, 0, array.size() - 1, 1, getOffset(array, 2));
}

void split(ArrayList<Integer> array, int start, int end, int s, int o) {
  ArrayList<Integer> divisible = new ArrayList<Integer>();
  ArrayList<Integer> undivisible = new ArrayList<Integer>();

  for (int i = start; i <= end; i++) {
    if (isDivisible(array.get(i), (int)pow(2, s), o)) divisible.add(array.get(i));
    //pow(x, y) gibt x hoch y zurück
    else undivisible.add(array.get(i));
  }

  buildTupel(array, start, end, undivisible, divisible);

  if (undivisible.size() > 1) {
    int off = getOffset(undivisible, (int)pow(2, s + 1));
    split(array, start, start + undivisible.size() - 1, s + 1, off);
  }

  if (divisible.size() > 1) {
    int off = getOffset(divisible, (int)pow(2, s + 1));
    split(array, start + undivisible.size(), end, s + 1, off);
  }

  merge(array, start, end, undivisible.size());
}

void merge(ArrayList<Integer> array, int start, int end, int undivSize) {  
  ArrayList<Integer> undivisible = new ArrayList<Integer>();
  ArrayList<Integer> divisible = new ArrayList<Integer>();

  for (int i = start; i <= end; i++) {
    if (i < start + undivSize) undivisible.add(array.get(i));
    else divisible.add(array.get(i));
  }

  int startWith = 1;
  if (undivisible.size() > 0 && divisible.size() > 0)
    startWith = undivisible.get(0) < divisible.get(0) ? 0 : 1;
  else if (divisible.size() == 0)
    startWith = 0;

  for (int i = start; i <= end; i++) {
    if (((i - start) % 2 == startWith && undivisible.size() > 0) || divisible.size() == 0) {
      array.set(i, undivisible.get(0));
      undivisible.remove(0);
    } else {
      array.set(i, divisible.get(0));
      divisible.remove(0);
    }
  }
}

void buildTupel(ArrayList<Integer> array, int start, int end, ArrayList<Integer> undivisible, ArrayList<Integer> divisible) {

  int j = 0;
  if (undivisible.size() > 0) {
    for (int i = start; i < start + undivisible.size(); i++) {
      array.set(i, undivisible.get(j++));
    }
  }

  j = 0;
  if (divisible.size() > 0) {
    for (int i = start + undivisible.size(); i <= end; i++) {
      array.set(i, divisible.get(j++));
    }
  }
}

int getOffset(ArrayList<Integer> array, int e) {
  int off = Integer.MAX_VALUE;
  for (int i = 0; i < array.size(); i++) {
    if (array.get(i) <= e) off = min(off, e - array.get(i));
    //min(x, y) gibt den kleineren der beiden Werte zurück
  }
  return off;
}

boolean isDivisible(int x, int e, int o) { 
  return (x + o) % e == 0;
}