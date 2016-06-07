package;

import kha.Assets;
import kha.Color;
import kha.Framebuffer;
import kha.Image;
import kha.Scaler;
import kha.System;

class KhaShmup {
	private static var bgColor = Color.fromValue(0x26004d);
	public static inline var screenWidth = 800;
	public static inline var screenHeight = 600;

	private var backbuffer: Image;
	private var initialized = false;
	private var ship: Ship;


	public function new() {
		// backbuffer = Image.createRenderTarget(screenWidth, screenHeight);
		Assets.loadEverything(loadingFinished);
	}

	// function update(): Void {
	//
	// }
	private function loadingFinished(): Void {
		initialized = true;

		backbuffer = Image.createRenderTarget(screenWidth, screenHeight);
		var shipImg = Assets.images.playerShip;
		ship = new Ship(
			Std.int(screenWidth / 2) - Std.int(shipImg.width / 2),
			Std.int(screenHeight / 2) - Std.int(shipImg.height / 2),
			shipImg
		);
	}


	public function render(framebuffer: Framebuffer): Void {
		if (!initialized) {
			return;
		}


		var g = backbuffer.g2;

		g.begin(bgColor);
		ship.render(g);
		g.end();

		framebuffer.g2.begin();
		Scaler.scale(backbuffer, framebuffer, System.screenRotation);
		framebuffer.g2.end();
	}
}
