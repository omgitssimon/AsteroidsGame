
Star [] stars
SpaceShip ship
public boolean upkey = false
public boolean downkey = false;
public boolean leftkey = false;
public boolean rightkey = false;
public void setup() 
{
  size(500,500);
  background(0);
  ship = new SpaceShip()
  stars = new Star[250];
  for(int i = 0; i < stars.length; i++)
    stars[i] = new Star();
}
public void draw() 
{
  background(0);
  for(int i = 0; i < stars.length; i++)
  stars[i].show();
  ship.show();
  ship.move();
  if(upkey == true) ship.accelerate(Math.random()*0.18);
  if(downkey == true) ship.accelerate(Math.random()*-0.18);
  if(leftkey == true) ship.rotate(-5);
  if(rightkey == true) ship.rotate(5);
}
class SpaceShip extends Floater  
{   
  public SpaceShip()
  {
    corners = 4;  
    xCorners = new int[corners];
    yCorners = new int[corners];
    xCorners[0]=12;
    xCorners[1]=-3;
    xCorners[2]=-1;
    xCorners[3]=-3;
    yCorners[0]=2;
    yCorners[1]=7;
    yCorners[2]=2;
    yCorners[3]=-3;  
    myColor = color(random(0,255),random(0,255),random(0,255)); 
    myCenterX = 500/2; 
    myCenterY = 500/2;   
    myDirectionX = 0; 
    myDirectionY = 0; 
    myPointDirection = -90;
  }

  public void setX(int x){myCenterX = x;}
  public int getX(){return (int)myCenterX;}
  public void setY(int y){myCenterY = y;}
  public int getY(){return (int)myCenterY;}
  public void setDirectionX(double x){myDirectionX = x;}
  public double getDirectionX(){return myDirectionX;}
  public void setDirectionY(double y){myDirectionY = y;}
  public double getDirectionY(){return myDirectionY;}
  public void setPointDirection(double degrees){myPointDirection = degrees;}
  public double getPointDirection(){return myPointDirection;}   
}
abstract class Floater //Do NOT modify the Floater class! Make changes in the SpaceShip class 
{   
  protected int corners;  //the number of corners, a triangular floater has 3   
  protected int[] xCorners;   
  protected int[] yCorners;   
  protected int myColor;   
  protected double myCenterX, myCenterY; //holds center coordinates   
  protected double myDirectionX, myDirectionY; //holds x and y coordinates of the vector for direction of travel   
  protected double myPointDirection; //holds current direction the ship is pointing in degrees    
  abstract public void setX(int x);  
  abstract public int getX();   
  abstract public void setY(int y);   
  abstract public int getY();   
  abstract public void setDirectionX(double x);   
  abstract public double getDirectionX();   
  abstract public void setDirectionY(double y);   
  abstract public double getDirectionY();   
  abstract public void setPointDirection(double degrees);   
  abstract public double getPointDirection(); 
  //Accelerates the floater in the direction it is pointing (myPointDirection)   
  public void accelerate (double dAmount)   
  {          
    //convert the current direction the floater is pointing to radians    
    double dRadians = myPointDirection*(Math.PI/180);     
    //change coordinates of direction of travel    
    myDirectionX += ((dAmount) * Math.cos(dRadians));    
    myDirectionY += ((dAmount) * Math.sin(dRadians));       
  }   
  public void rotate (double nDegreesOfRotation)   
  {     
    //rotates the floater by a given number of degrees    
    myPointDirection+=nDegreesOfRotation;   
  }   
  public void move () //move the floater in the current direction of travel
  {      
    //change the x and y coordinates by myDirectionX and myDirectionY       
    myCenterX += myDirectionX;    
    myCenterY += myDirectionY;     

    //wrap around screen    
    if(myCenterX > width)    
      myCenterX = 0;       
    else if (myCenterX<0)
      myCenterX = width;        
    if(myCenterY > height)  
      myCenterY = 0;    
    else if (myCenterY < 0)    
      myCenterY = height;      
  }   
  public void show ()  //Draws the floater at the current position  
  {             
    fill(myColor);   
    stroke(myColor);    
    //convert degrees to radians for sin and cos         
    double dRadians = myPointDirection*(Math.PI/180);                 
    int xRotatedTranslated, yRotatedTranslated;    
    beginShape();         
    for(int nI = 0; nI < corners; nI++)    
    {     
      //rotate and translate the coordinates of the floater using current direction 
      xRotatedTranslated = (int)((xCorners[nI]* Math.cos(dRadians)) - (yCorners[nI] * Math.sin(dRadians))+myCenterX);     
      yRotatedTranslated = (int)((xCorners[nI]* Math.sin(dRadians)) + (yCorners[nI] * Math.cos(dRadians))+myCenterY);      
      vertex(xRotatedTranslated,yRotatedTranslated);    
    }   
    endShape(CLOSE);  
  }   
} 

class Star
{
  private int myX, myY;
  private double starsSize;
  public Star()
  {
    myX = (int)(Math.random()*600);
    myY = (int)(Math.random()*600);
    starsSize = Math.random()*3;
  }
  public void show()
  {
    fill(random(0,255));
    ellipse(myX, myY, (float)starsSize, (float)starsSize);
  }
}

public void keyPressed()
{
  if(key == CODED) 
  {
    if(keyCode == UP) upkey = true;
    if(keyCode == DOWN) downkey = true;
    if(keyCode == LEFT) leftkey = true;
    if(keyCode == RIGHT) rightkey = true;
  }
  if(key == 'h') 
  {
    ship.setX((int)(Math.random()*600));
    ship.setY((int)(Math.random()*600));
    ship.setPointDirection(Math.random()*360);
    ship.setDirectionX(0);
    ship.setDirectionY(0);
  }
}

public void keyReleased()
{
  if (keyCode == UP) upkey = false;
  if (keyCode == LEFT) leftkey = false;
  if (keyCode == RIGHT) rightkey = false;
  if (keyCode == DOWN) downkey = false;
}

