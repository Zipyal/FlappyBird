int birdY, birdVelocity, gravity, jump;
int pipeX, pipeWidth, pipeGap, pipeY;
boolean gameOver, gameStarted;
int score;

// Настройки
void setup() {
  size(400, 600); 
  resetGame();
}

// Основной цикл отрисовки
void draw() {
  if (!gameStarted) {
    drawMainMenu();
  } else {
    playGame();
  }
}

// Основной игровой процесс
void playGame() {
  background(135, 206, 235); // фон - цвет неба
  
  // Отображение птицы
  fill(255, 204, 0); // цвет птицы
  ellipse(100, birdY, 30, 30);
  
  // Обновление положения птицы
  birdVelocity += gravity; 
  birdY += birdVelocity;
  
  // Проверка на столкновение с верхом и низом экрана
  if (birdY > height || birdY < 0) {
    gameOver = true;
    birdDeathAnimation();
  }
  
  // Отображение труб
  fill(0, 128, 0); // цвет труб
  rect(pipeX, 0, pipeWidth, pipeY); // верхняя труба
  rect(pipeX, pipeY + pipeGap, pipeWidth, height - (pipeY + pipeGap)); // нижняя труба
  
  // Перемещение трубы влево
  pipeX -= 3;
  
  // Если труба выходит за пределы экрана, создаём новую трубу
  if (pipeX < -pipeWidth) {
    pipeX = width;
    pipeY = int(random(100, 300));
    score++; // увеличиваем счёт при прохождении трубы
  }
  
  // Отображение счётчика
  textSize(32);
  fill(0);
  text("Score: " + score, 10, 40);
  
  // Проверка на столкновение с трубами
  if ((100 > pipeX && 100 < pipeX + pipeWidth) && 
      (birdY < pipeY || birdY > pipeY + pipeGap)) {
    gameOver = true;
    birdDeathAnimation();
  }
  
  // Если игра окончена, показываем сообщение и останавливаем игру
  if (gameOver) {
    textSize(32);
    fill(255, 0, 0);
    text("Game Over", width/2 - 80, height/2);
    noLoop(); // останавливаем игру
  }
}

// Отображение главного меню
void drawMainMenu() {
  background(135, 206, 235);
  textSize(36);
  fill(0);
  textAlign(CENTER);
  text("Flappy Bird", width / 2, height / 3);
  textSize(20);
  text("Press SPACE to Start", width / 2, height / 2);
  textAlign(LEFT);
}

// Анимация смерти птицы (падение)
void birdDeathAnimation() {
  fill(255, 50, 50); // красный оттенок для эффекта
  ellipse(100, birdY, 40, 40);
}

// Обработка нажатий клавиш
void keyPressed() {
  if (key == ' ') {
    if (!gameStarted) {
      gameStarted = true;
      resetGame();
      loop();
    } else if (!gameOver) { // прыжок при нажатии пробела
      birdVelocity = jump;
    }
  }
  
  if (gameOver) { // перезапуск игры
    resetGame();
    loop(); // перезапускаем цикл draw
  }
}

// Сброс игры
void resetGame() {
  birdY = 200;             // начальное положение птицы по оси Y
  birdVelocity = 0;        // начальная скорость птицы
  gravity = 1;             // сила гравитации
  jump = -10;              // сила прыжка
  pipeX = width;           // начальное положение трубы по оси X
  pipeWidth = 80;          // ширина трубы
  pipeGap = 150;           // расстояние между верхней и нижней трубами
  pipeY = int(random(100, 300)); // положение разрыва трубы по оси Y
  gameOver = false;        // флаг окончания игры
  score = 0;               // сброс счёта
}
