import color;
import hittable;
import material;
import ray;
import vec3;

class Metal : Material
{
    this(Color a)
    {
        _albedo = a;
    }

    override bool scatter(Ray rIn, HitRecord rec, ref Color attenuation, ref Ray scattered)
    {
        Vec3 reflected = rIn.direction.unitVector.reflect(rec.normal);
        scattered = new Ray(rec.p, reflected);
        attenuation = _albedo;
        return scattered.direction.dot(rec.normal) > 0;
    }

private:
    Color _albedo;
}
