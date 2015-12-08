
//Star [] stars;
//SpaceShip ship;
//ArrayList <Asteroid> asteroidList;
//ArrayList <Bullets> bullet;
int sizeSize, asteroidS, rectW, rectH;
boolean goodGame, win;

//public void setup()
{
 sizeSize = 600;
 asteroidS = 30;
 rectW = 200;
 rectH = 100;
 size(sizeSize,sizeSize);
 ship = new SpaceShip();
 stars = new Star[250];
  for(int i = 0; i < stars.length; i++)
    stars[i] = new Star();
 bullet = new ArrayList <Bullets>();
 asteroidList = new ArrayList <Asteroid>();

 for (int i=0; i< asteroidS; i++)
 {
  asteroidList.add(new Asteroid());
 }
 goodGame = false;
}

//public void mousePressed()
{
 if (mousePressed == true && goodGame == false)
   {
    bullet.add(new Bullets(ship));
   }

 if (goodGame == true)
   {
     if (mousePressed == true)
     {
       if (mouseX<(sizeSize/2 - rectW/2)+ rectW && mouseX>(sizeSize/2 - rectW/2))
       {
         if (mouseY<(sizeSize/2 + rectH) && mouseY>sizeSize/2)
         {
          goodGame = false;
         }
       }
     }
   }
}

//public void draw()
{
 background(random(0,55));
 for(int i = 0; i < stars.length; i++)
  stars[i].show();
 if (goodGame == false)
 {
   for (int i=0; i< bullet.size(); i++)
   {
     bullet.get(i).show();
     bullet.get(i).move();
   }
   ship.show();
   ship.rotate(ship);
   ship.keyPressed();
   ship.move();
   for (int i=0; i< asteroidList.size()-1; i++)
   {
     asteroidList.get(i).show();
     asteroidList.get(i).move();
     for(int b=0; b < bullet.size(); b++)
     {
       if (dist((float)asteroidList.get(i).getX(),(float)asteroidList.get(i).getY(), (float)bullet.get(b).getX(), (float)bullet.get(b).getY())<20)
       {
        asteroidList.remove(i);
       }
       if (dist((float)asteroidList.get(i).getX(),(float)asteroidList.get(i).getY(), (float)ship.getX(), (float)ship.getY())<10)
       {
       goodGame = true;
       win = false;
       asteroidList.get(i).setX((int)(Math.random()*sizeSize));
       asteroidList.get(i).setY((int)(Math.random()*sizeSize));
       if (asteroidList.size()< asteroidS)
       {
         for (int e=asteroidList.size(); e<asteroidS; e++)
         {
          asteroidList.add(new Asteroid());
         }
       }
       ship.setX(sizeSize/2);
       ship.setY(sizeSize/2);
       ship.setDirectionX(0);
       ship.setDirectionY(0);
       ship.setPointDirection(-90);
       for(int q=0; q < bullet.size(); q++)
       {
        bullet.remove(q);
       }
       }
     }

   if (asteroidList.size() == 1)
      {
      goodGame = true;
      win = true;
      asteroidList.get(i).setX((int)(Math.random()*sizeSize));
      asteroidList.get(i).setY((int)(Math.random()*sizeSize));
      if (asteroidList.size()< asteroidS)
        {
         for (int e=asteroidList.size(); e<asteroidS; e++)
         {
          asteroidList.add(new Asteroid());
         }
        }
       ship.setX(sizeSize/2);
       ship.setY(sizeSize/2);
       ship.setDirectionX(0);
       ship.setDirectionY(0);
       ship.setPointDirection(-90);
       }
   }
 }

  if(goodGame == true)
  {
   fill(random(0,255),random(0,255),random(0,255));
   textAlign(CENTER,CENTER);
   textSize(70);
   if (win == false)
   {
       text("Click to Retry", sizeSize/2, sizeSize/2 + rectH/2);
   }
   if (win == true)
   {
       textSize(90);
       text("Again?", sizeSize/2, sizeSize/2 + rectH/2);
   }
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

class SpaceShip extends Floater 
{  
 public void setX(int x) {myCenterX = x;} 
 public int getX() {return (int)myCenterX;}
 public void setY(int y) {myCenterY = y;}
 public int getY() {return (int)myCenterY;}
 public void setDirectionX(double x) {myDirectionX = x;}  
 public double getDirectionX() {return myDirectionX;}
 public void setDirectionY(double y) {myDirectionY = y;}    
 public double getDirectionY() {return myDirectionY;} 
 public void setPointDirection(int degrees) {myPointDirection = degrees;} 
 public double getPointDirection() {return myPointDirection;}

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
   myColor = (int)(Math.random()*3)+150;  
   myCenterX = sizeSize/2;
   myCenterY = sizeSize/2;  
   myDirectionX = 0;
   myDirectionY = 0;
   myPointDirection = -90;
 }

public void rotate(SpaceShip theShip)
{ 
    //first quadrant  
    if (mouseX>theShip.getX() && mouseY<theShip.getY())
    {
     myPointDirection = (-1)*(180/Math.PI)*Math.atan(Math.abs((double)mouseY - (double)theShip.getY())/Math.abs((double)mouseX - (double)theShip.getX()));
    }

    //second quadrant
    if (mouseX<theShip.getX() && mouseY<theShip.getY())
    {
     myPointDirection = 180 + (180/Math.PI)*Math.atan(Math.abs((double)mouseY - (double)theShip.getY())/Math.abs((double)mouseX - (double)theShip.getX()));
    }

    //third quadrant
    if (mouseX<theShip.getX() && mouseY>theShip.getY())
    {
     myPointDirection = 180 - (180/Math.PI)*Math.atan(Math.abs((double)mouseY - (double)theShip.getY())/Math.abs((double)mouseX - (double)theShip.getX()));
    }

    //fourth quadrant
    if (mouseX>theShip.getX() && mouseY>theShip.getY())
    {
     myPointDirection = (180/Math.PI)*Math.atan(Math.abs((double)mouseY - (double)theShip.getY())/Math.abs((double)mouseX - (double)theShip.getX()));
    }
}

public void keyPressed()
{
   if (keyPressed && keyCode == UP)
   {
    ship.accelerate(0.5);
   }

   if (keyPressed && keyCode == DOWN)
   {
    ship.accelerate(-0.1);
   }

   if (keyPressed && keyCode == 17)
   {
    ship.setX((int)(Math.random()*sizeSize));
    ship.setY((int)(Math.random()*sizeSize));
    ship.setDirectionX(0);
    ship.setDirectionY(0);
   }
 }
}

class Bullets extends Floater
{
public void setX(int x) {myCenterX = x;} 
public int getX() {return (int)myCenterX;}
public void setY(int y) {myCenterY = y;}
public int getY() {return (int)myCenterY;}
public void setDirectionX(double x) {myDirectionX = x;}  
public double getDirectionX() {return myDirectionX;}
public void setDirectionY(double y) {myDirectionY = y;}    
public double getDirectionY() {return myDirectionY;} 
public void setPointDirection(int degrees) {myPointDirection = degrees;} 
public double getPointDirection() {return myPointDirection;}

public Bullets(SpaceShip theShip)
{
   myCenterX = theShip.getX();
   myCenterY = theShip.getY();
   myPointDirection = theShip.getPointDirection();
   double dRadians =myPointDirection*(Math.PI/180);
   myDirectionX = 5 * Math.cos(dRadians) + theShip.getDirectionX();
   myDirectionY = 5 * Math.sin(dRadians) + theShip.getDirectionY();
 }

public void show()


{
   fill(255,0,0);
   noStroke();
   ellipse((float)myCenterX, (float)myCenterY, 5, 5);
 }

 public void move()
 {
   myCenterX += myDirectionX;   
   myCenterY += myDirectionY;
 }
}

class Asteroid extends Floater
{
 public void setX(int x) {myCenterX = x;} 
 public int getX() {return (int)myCenterX;}
 public void setY(int y) {myCenterY = y;}
 public int getY() {return (int)myCenterY;}
 public void setDirectionX(double x) {myDirectionX = x;}  
 public double getDirectionX() {return myDirectionX;}
 public void setDirectionY(double y) {myDirectionY = y;}    
 public double getDirectionY() {return myDirectionY;} 
 public void setPointDirection(int degrees) {myPointDirection = degrees;} 
 public double getPointDirection() {return myPointDirection;}
 public int rotSpeed, scal;
 public double speed, ang;

 public Asteroid()
 {
   strokeWeight(10);

   if (Math.random() > 0.5)
   {
     rotSpeed = (int)(Math.random()*2)+2;
   }
   else
   {
     rotSpeed = ((int)(Math.random()*2)+2)*(-1);
   }

   scal = (int)(Math.random()*4)+2;
   corners = 6; 
   xCorners = new int[corners];
   yCorners = new int[corners];

     xCorners[0]=(int)(Math.random()*6*scal)+5*scal;
     xCorners[1]=(int)(Math.random()*3*scal);
     xCorners[2]=(int)(Math.random()*4*scal);
     xCorners[3]=(int)(Math.random()*5*scal)-5*scal;
     xCorners[4]=-(int)(Math.random()*3*scal);
     xCorners[5]=(int)(Math.random()*3*scal);
     yCorners[0]=(int)(Math.random()*3*scal)-2*scal;
     yCorners[1]=(int)(Math.random()*2*scal)-5*scal;
     yCorners[2]=(int)(Math.random()*4*scal)-5*scal;
     yCorners[3]=(int)(Math.random()*3*scal)-2*scal;
     yCorners[4]=(int)(Math.random()*3*scal)+5*scal;
     yCorners[5]=(int)(Math.random()*3*scal)+5*scal;

   myColor = 69;  
   myCenterX = (Math.random()*sizeSize);
   myCenterY = (Math.random()*sizeSize);
   speed = Math.random()*5;
   ang = Math.random()*2*Math.PI;
   myDirectionX = Math.cos(ang)*speed;
   myDirectionY = Math.sin(ang)*speed;
   myPointDirection = 0;
 }

public void move()
{
   myCenterX += myDirectionX;   
   myCenterY += myDirectionY;
   myPointDirection+=rotSpeed;    

   //wrap around screen   
   if(myCenterX >sizeSize)
   {    
    myCenterX = 0;   
   }   
   else if (myCenterX<0)
   {    
     myCenterX = sizeSize;   
   }   

   if(myCenterY >sizeSize)
   {   
     myCenterY = 0;   
   }  

   else if (myCenterY < 0)
   {    
     myCenterY = sizeSize;   
   }
 }

public void show ()
{            
   fill(0);  
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

abstract class Floater
{  
 protected int corners;   
 protected int[] xCorners;  
 protected int[] yCorners;  
 protected int myColor;  
 protected double myCenterX, myCenterY; 
 protected double myDirectionX, myDirectionY;  
 protected double myPointDirection;  
 abstract public void setX(int x); 
 abstract public int getX();  
 abstract public void setY(int y);
 abstract public int getY();  
 abstract public void setDirectionX(double x);  
 abstract public double getDirectionX();  
 abstract public void setDirectionY(double y);  
 abstract public double getDirectionY();  
 abstract public void setPointDirection(int degrees);  
 abstract public double getPointDirection();

public void accelerate (double dAmount)  
{         
   double dRadians =myPointDirection*(Math.PI/180);    
   myDirectionX += ((dAmount) * Math.cos(dRadians));   
   myDirectionY += ((dAmount) * Math.sin(dRadians));      
}  

public void rotate (int nDegreesOfRotation)  
{    
   myPointDirection+=nDegreesOfRotation;  
}  

public void move () 
{     
   myCenterX += myDirectionX;   
   myCenterY += myDirectionY;    

   if(myCenterX >width)
   {    
     myCenterX = 0;   
   }   
   else if (myCenterX<0)
   {    
     myCenterX = width;   
   }   
   if(myCenterY >height)
   {   
     myCenterY = 0;   
   }  
   else if (myCenterY < 0)
   {    
     myCenterY = height;   
   }  
 }  

public void show () 
{            
   fill(myColor);  
   stroke(myColor);   
   double dRadians = myPointDirection*(Math.PI/180);                
   int xRotatedTranslated, yRotatedTranslated;   
   beginShape();        

   for(int nI = 0; nI < corners; nI++)   
   {    
     xRotatedTranslated = (int)((xCorners[nI]* Math.cos(dRadians)) - (yCorners[nI] * Math.sin(dRadians))+myCenterX);    
     yRotatedTranslated = (int)((xCorners[nI]* Math.sin(dRadians)) + (yCorners[nI] * Math.cos(dRadians))+myCenterY);     
     vertex(xRotatedTranslated,yRotatedTranslated);   
   }  
   endShape(CLOSE); 
 } 
}


