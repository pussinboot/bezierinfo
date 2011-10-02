// Dependencies are in the "common" directory
// © 2011 Mike "Pomax" Kamermans of nihongoresources.com

Point[] points;
int steps = 12;
double curvelength;
long ms=0;
int boxsize = 200;

// REQUIRED METHOD
void setup()
{
	size(boxsize+100,boxsize+100);
	noLoop();
	setupPoints();
	text("",0,0);
}

/**
 * Set up three points, to form a quadratic curve
 */
void setupPoints()
{
	points = new Point[3];
	points[0] = new Point(170, 20);
	points[1] = new Point(205, 210);
	points[2] = new Point(20,175);
}

// REQUIRED METHOD
void draw()
{
	noFill();
	stroke(0);
	background(255);
	drawCurves();
	drawExtras();
}

/**
 * Run through the entire interval [0,1] for 't', and generate
 * the corresponding flattened curve.
 */
void drawCurves()
{
	// first the quadratic curve
	double range = 200;
	stroke(0);
	for(float t = 0; t<1.0; t+=1.0/range) {
		float mt = (1-t);
		double x = computeQuadraticBaseValue(t, points[0].getX(), points[1].getX(), points[2].getX());
		double y = computeQuadraticBaseValue(t, points[0].getY(), points[1].getY(), points[2].getY());
		drawPoint(x,y); }
	
	// determine the arc length using guass quadrature
	if(steps<2) { steps=2; }
	if(steps>=Cvalues.length) { steps = Cvalues.length-1; }
	long start = millis();
  curvelength = computeQuadraticCurveLength(1.0, steps, points[0].getX(), points[0].getY(), points[1].getX(), points[1].getY(), points[2].getX(), points[2].getY());
	ms = (millis()-start);
}

/**
 * For nice visuals, make the curve's fixed points stand out,
 * and draw the lines connecting the start/end and control point.
 * Also, we label each coordinate with its x/y value, for clarity.
 */
void drawExtras()
{
	showPoints(points);
	stroke(0,75);
	drawLine(points[0].getX(), points[0].getY(), points[1].getX(), points[1].getY());
	drawLine(points[1].getX(), points[1].getY(), points[2].getX(), points[2].getY());
	fill(0);
  drawText("Estimated arc length of this curve: "+curvelength, 5,height-20);	
  drawText("number of used strips: "+steps+", time required: "+ms+"ms", 5,height-10);
}