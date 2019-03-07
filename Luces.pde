import processing.sound.*;                // importaremos la biblioteca de sonido
SoundFile musica;                         // creamos el archivo para el sonido
float rotacion;                           // una variable para controlar la rotacion del enterno
PShape earth, Luna, Sol;                  // creamos elementos que serán parte del entorno
PImage DN, LUN, SOL;                      // creamos imagenes para fondo, y texturas
float ValorZ;                             //Valores que representan giro y movimiento en sus respectivos ejes
boolean texto = true;      

void setup() {
  size(900, 700,  P3D);                          //tamaño de la ventana
  imageMode(CENTER);      
  ValorZ = 130;                                  //Aqui controlaremos el zoom inicial
  earth = loadShape("earth.obj");                //cargamos el objeto de la tierra
  earth.scale(200);                              //dado a su pequeño tamaño lo escalamos
  DN=loadImage("DN.jpg");                        //cargamos las imagenes que tenemos
  LUN=loadImage("luna.jpg");
  SOL=loadImage("Sol.jpg");
  musica = new SoundFile(this,"Paniyolo.mp3");              //cargamos la canción
  
  beginShape();
  noStroke(); 
  Luna = createShape(SPHERE,30);                //creamos objeto de la luna
  Luna.setTexture(LUN);                         //agregamos textura
  Sol = createShape(SPHERE,40);                 //hacemos lo mismo para el sol
  Sol.setTexture(SOL);
  endShape(CLOSE);
  musica.loop();                                //creamos loop para la canción
}


void draw() {

  if (mousePressed == true && mouseButton == LEFT){       //aqui controlamos el zoom
   ValorZ = ValorZ+2;
   texto =false;                                          //Al aplastarse un boton desaparecerán las indicaciones
   if(ValorZ >= 270){                                     //controlamos el zoom con este if 
      ValorZ = 270;  
      
   }
   }else if (mousePressed == true && mouseButton == RIGHT){
   ValorZ = ValorZ-2;
    texto =false;                                         //Al aplastarse un boton desaparecerán las indicaciones
   if(ValorZ <= 60){                                      //controlamos el zoom con este if
      ValorZ = 60;    
   }
   }
   
  lights();                                                                //para evitar que este demaciado oscuro, pondremos luces  

  if (texto == true){                                                      //solo se mostrará si no se han presionado teclas
  textSize(15);
  text( "Presiona clik derecho e izq para profundidad" ,-160,-400);
  }
  
   translate (width/2,height);                                              //cambiamos la coordenada origen 
   camera (0, -336, ValorZ/tan(PI*30.0/180.0)+ValorZ,                       //servirá para hacer el cambio
   0 , -336+50, ValorZ, 
   0, 1, 0);
   rotateZ(rotacion);
    
  pushMatrix();                                                             //creamos un push que controlara todos las "fisicas" del fondo
  translate(0,50,-250);                                                     //movemos la imagen
  image(DN,0,0);                                                            //cargamos la imagen
  popMatrix();
  
  pushMatrix();                                          //damos formato a la tierra     
  if( rotacion <=3.31 || rotacion >= 6.12) {            //Rango de cuando existirá atardeccer
  directionalLight(200,100,20,  890,15,-700);           //creamos una luz que representará el atardecer
  }
  rotateY(40);                                          //rotaremos el planeta
  rotateX(40);
  shape(earth, 0,0);                                     //dibujaremos la tierra
  popMatrix();
  
  pushMatrix();                                           //Luna
  directionalLight(0,255,255,   200,200,0);              //la luz que representará la luz que refleja del sol
  translate((height)-80,0);                              //donde se dibujará
  noStroke();   
  shape(Luna);                                           //dibujamos luna
  popMatrix();
                                                              //Sol
  pushMatrix(); 
  pointLight(255,255,100,   20,20,200);                  //Luz del sol
  translate((-height)+85,0);   
  noStroke();
  shape(Sol);                                            //dibujamos sol
  popMatrix();
  
  if (rotacion >=7.7997484){                   //aqui la rotacion se reinicia a un valor clave, para que el la luz de atardecer
  rotacion = 1.5180068;                        //se respete
  }
  rotacion+=0.003;
}
