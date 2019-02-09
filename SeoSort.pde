import java.util.Collections;

boolean createCsv = false;
int start = 1, end = 100, step = 1;

int size = 100;
ArrayList<Integer> array;

boolean sorting, sorted;
int splits, divChecks, maxS, arrAcc, extraArr;
int nanoStart, nanos;

int current;
Table table;

void setup() {
  size(500, 500);
  surface.setResizable(true);
  surface.setTitle("Seo-Sort testing area");
  background(255);

  shuffle(size);
  //println(array);

  splits = 0;
  divChecks = 0;
  maxS = 0;
  arrAcc = 0;
  extraArr = 0;
  sorted = false;
  sorting = false;

  current = start;

  table = new Table();
  table.addColumn("n");
  //table.addColumn("div-checks");
  //table.addColumn("nanos");
  table.addColumn("extra-arr");
}

void draw() {
  background(255);

  fill(0);
  textAlign(CENTER, CENTER);
  textSize(30);
  text(sorted ? "Sorted" : "Shuffled", width * .5, 50);

  textAlign(LEFT, TOP);
  textSize(20);
  text("Size: " + size, 30, 100);
  text("Splits: " + splits, 30, 130);
  text("Div-checks: " + divChecks, 30, 160);
  text("Max s: " + maxS, 30, 190);
  text("Nanos: " + nanos, 30, 220);
  text("Array-acc: " + arrAcc, 30, 250);
  text("Extra-arr: " + extraArr, 30, 280);
  text("" + array, 30, 330, width - 50, height - 330);
  
  textSize(10);
  text("right-click: shuffle, left-click: sort, mouse-wheel: change size", 0, 0);

  if (createCsv) {
    if (sorted && sorting) {
      if (current + step <= end) {
        current += step;
        size = current;
        sorting = false;
      } else {
        sorting = false;
        createCsv = false;
      }
    } else if (!sorting) {
      shuffle(size);
      sorting = true;
      seoSort(array);
      TableRow newRow = table.addRow();
      newRow.setInt("n", current);
      //newRow.setInt("div-checks", divChecks);
      //newRow.setInt("nanos", nanos);
      newRow.setInt("extra-arr", extraArr);
    }

    if (!createCsv) {
      String name = "data/from" + start + "to" + end + "with" + step + ".csv";
      saveTable(table, name, "tsv");
      println("Saved file to: " + name);
    }
  }
};

void mouseWheel(MouseEvent event) {
  if (!createCsv) {
    int e = event.getCount();
    size = (int)max(size - e * pow(10, String.valueOf((int)(size - e * .1)).length() - 1), 1);
  }
}

void mousePressed() {
  if (mouseButton == LEFT) {
    array = seoSort(array);
    //println(array);
    sorted = true;
  } else {
    shuffle(size);
    //println(array);
    sorted = false;
  }
}

void shuffle(int s) {
    array = new ArrayList<Integer>();
    for (int i = 1; i <= s; i++) array.add(i);
    Collections.shuffle(array);
}
