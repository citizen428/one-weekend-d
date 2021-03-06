import color;
import hittable;
import material;
import ray;
import vec3;

class Metal : Material
{
    this(Color a, double f)
    {
        _albedo = a;
        _fuzz = f < 1 ? f : 1;
    }

    override bool scatter(Ray rIn, HitRecord rec, ref Color attenuation, ref Ray scattered)
    {
        Vec3 reflected = rIn.direction.unitVector.reflect(rec.normal);
        scattered = new Ray(rec.p, reflected + _fuzz * Vec3.randomInUnitSphere);
        attenuation = _albedo;
        return scattered.direction.dot(rec.normal) > 0;
    }

private:
    Color _albedo;
    double _fuzz;
}
