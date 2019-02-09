import java.util.Collections;

int size = 10;
ArrayList<Integer> array;

void setup() {
  size(500, 500);
  background(255);

  array = new ArrayList<Integer>();
  for (int i = 1; i <= size; i++) array.add(i);
  Collections.shuffle(array);
  println(array);
}

void mousePressed() {
  if (mouseButton == LEFT) {
    seoSort(array);
    println(array);
  } else {
    Collections.shuffle(array);
    println(array);
  }
}

void draw() {
};