import color;
import hittable;
import ray;

abstract class Material
{
    abstract bool scatter(Ray rIn, HitRecord rec, ref Color attenuation, ref Ray scattered);
}
