import color;
import hittable;
import material;
import ray;
import vec3;

class Lambertian : Material
{
    this(Color a)
    {
        _albedo = a;
    }

    override bool scatter(Ray rIn, HitRecord rec, ref Color attenuation, ref Ray scattered)
    {
        auto scatterDirection = rec.normal + Vec3.randomUnitVector;

        // Catch degenerate scatter direction
        if (scatterDirection.nearZero) { scatterDirection = rec.normal; }

        scattered = new Ray(rec.p, scatterDirection);
        attenuation = _albedo;
        return true;
    }

private:
    Color _albedo;
}
