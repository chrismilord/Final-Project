import java.util.ArrayList;
Table table;
PImage img;
PImage img1;
int showStats = 0;

// Shows the Pokemon Class that comments what the Pokemon are
public class PocketMan {
  private String name;
  private int attack;
  private int defense;
  private int speed;
  private int id;
  private int xPos;
  private int yPos;

  // Creates a pokemon object based on name, attack, defense, speed and id
  public PocketMan(String name, int attack, int defense, int speed, int id) {
    this.name = name;
    this.id = id;
    this.attack = attack;
    this.defense = defense;
    this.speed = speed;
    xPos = 10 * id;
    yPos = 10*id;
  }
  // Gets the X, Y, and ID from its private variable
  public int getXPos() {
    return xPos;
  }
  public int getYPos() {
    return yPos;
  }
  public int getID() {
    return id;
  }

  // Displays the basic information of the Pokemon by name and color
  public void whosThatPKMN() {
    colourPok();
    textSize(10);
    text(name, xPos, yPos);
  }
  // Shows the Pokemon's color based on the attack, defense, and speed
  public void colourPok() {
    fill(color(attack, defense, speed));
  }
  // Testing the script based on text methods.
  public String toString() {
    return name + " " + attack + " " + defense + " " + speed + " " + id;
  }
  // Shuffling the x and y positions
  public void pokeShuffL() {
    xPos -= 5;
    yPos -= 5;
  }
  public void pokeShuffR() {
    xPos += 5;
    yPos += 5;
  }
  // Growing the text size
  public int textGrow() {
    int finalSize = 10;
    while (finalSize < 100) {
      finalSize++;
    }
    return finalSize;
  }
  // Shows the actual info of the Pokemon and displays them as text
  public void displayInfo() {
    textSize(textGrow());
    text(name, 500, 100);
    textSize(20);
    text("Attack : " + attack, 500, 180);
    text("Defense : " + defense, 500, 220);
    text("Speed : " + speed, 500, 260);
  }
}

ArrayList<PocketMan> PKMN = new ArrayList<PocketMan>();

// Runs the script that moves all the pokemon from the original data sheet into the new arrayList as PocketMan objects
void setup() {
  size(1000, 1000);
  img = loadImage("mistake.png");
  img1 = loadImage("controls.png");
  table = loadTable("Pokemon.csv", "header");
  println(table.getRowCount() + " total rows in table");
  for (TableRow row : table.rows()) {
    PKMN.add(new PocketMan(row.getString("Name"), row.getInt("Attack"), row.getInt("Defense"), row.getInt("Speed"), row.getInt("#")));
  }
  println(PKMN.size());
  for (int i = 0; i < PKMN.size(); i++) {
    PocketMan row = PKMN.get(i);
    if ((row.name.indexOf("Mega ") > -1) || (row.name.indexOf(" Forme") > -1) || (row.name.indexOf("Primal ") > -1) || (row.name.indexOf(" Mode") > -1)) {
      PKMN.remove(PKMN.get(i));
      i--;
    }
    println(PKMN.get(i).toString());
  }
}

// Draws the background, control image, and all the pokemon text
void draw() {
  background(img);
  image(img1, 0, 500);
  for (PocketMan p : PKMN) {
    p.whosThatPKMN();
  }
  if (showStats!=0) {
    PKMN.get(showStats-1).displayInfo();
  }
}
// When you click on the list item, you will get the data
void mouseClicked() {
  for (PocketMan p : PKMN) {
    if (dist(mouseX, mouseY, p.xPos, p.yPos)<10) {
      showStats = p.getID();
      println(showStats);
    }
  }
}

// When you move up and down, the list moves in that way
void keyPressed() {
  for (int i = 0; i < PKMN.size(); i++) {
    if (keyCode == UP) {
      PKMN.get(i).pokeShuffR();
    } else if (keyCode == DOWN) {
      PKMN.get(i).pokeShuffL();
    }
  }
}
