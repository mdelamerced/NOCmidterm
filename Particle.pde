
// class Spore extends the class "VerletParticle2D"
class Particle extends VerletParticle2D {

  float r;
  float lifespan;

  Particle (Vec2D loc) {
    super(loc);
    r = 8;
    physics.addParticle(this);
    physics.addBehavior(new AttractionBehavior(this, r*2, 1));
  }

  void display () {
    lifespan = 100.0;
    lifespan -= 2.5;
    image(img, x, y);
    tint(255, lifespan);
  }
}

