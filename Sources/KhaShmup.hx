package;

import kha.Assets;
import kha.Color;
import kha.Framebuffer;
import kha.Image;
import kha.Key;
import kha.Scaler;
import kha.System;
import kha.input.Keyboard;

class KhaShmup {
  private static var bgColor = Color.fromValue(0x26004d);

  public static inline var screenWidth = 800;
  public static inline var screenHeight = 600;
  public static inline var gunSpeed = 0.25;

  private var backbuffer: Image;
  private var controls: Controls;
  private var initialized = false;
  private var ship: Ship;
  private var timer: Timer;

  public function new() {
    Assets.loadEverything(loadingFinished);
  }

  private function loadingFinished(): Void {
    initialized = true;

    // create a buffer to draw to
    backbuffer = Image.createRenderTarget(screenWidth, screenHeight);

    // create our player
    controls = new Controls();
    timer    = new Timer();
    Keyboard.get().notify(keyDown, keyUp);
    setupShip();
  }

  private function setupShip() {
    var shipImg     = Assets.images.playerShip;
    var bulletSound = Assets.sounds.bulletShoot;
    var bulletImg   = Assets.images.bullet;

    var gun = new Gun(gunSpeed, bulletImg, bulletSound);

    ship = new Ship(Std.int(screenWidth / 2) - Std.int(shipImg.width / 2),
      Std.int(screenHeight / 2) - Std.int(shipImg.height / 2),
      shipImg);

    ship.attachGun(gun);
  }

  public function render(framebuffer: Framebuffer): Void {
    if (!initialized) {
      return;
    }

    var g = backbuffer.g2;

    // clear and draw to our backbuffer
    g.begin(bgColor);
    ship.render(g);
    g.end();

    // draw our backbuffer onto the active framebuffer
    framebuffer.g2.begin();
    Scaler.scale(backbuffer, framebuffer, System.screenRotation);
    framebuffer.g2.end();

    update();
  }

  private function update() {
    timer.update();
    updateShip();
  }

  private function updateShip() {
    ship.update(controls, timer.deltaTime);

    // limit the ship to the width of the screen
    if (ship.x < 0) {
      ship.x = 0;
    } else if (ship.x + ship.width > screenWidth) {
      ship.x = screenWidth - ship.width;
    }

    // limit the ship to the height of the screen
    if (ship.y < 0) {
      ship.y = 0;
    } else if (ship.y + ship.height > screenHeight) {
      ship.y = screenHeight - ship.height;
    }
  }

  private function keyDown(key: Key, value: String): Void {
    controls.keyDown(key, value);
  }

  private function keyUp(key: Key, value: String): Void {
    controls.keyUp(key, value);
  }

}
