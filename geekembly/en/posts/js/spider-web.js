function setup() {
  const canvas = createCanvas(400, 400);
  canvas.parent("p5-canvas-container");
}

function draw() {
  background(220);
  circle(50, 50, 25);
  circle(100, 50, 25);
}
