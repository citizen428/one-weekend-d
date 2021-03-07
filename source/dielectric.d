import std.math : fmin, pow, sqrt;

import color;
import hittable;
import material;
import ray;
import util;
import vec3;

class Dielectric : Material
{
    this(double refractionIndex)
    {
      _ri = refractionIndex;
    }

    override bool scatter(Ray rIn, HitRecord rec, ref Color attenuation, ref Ray scattered)
    {
        attenuation = new Color(1, 1, 1);
        double refractionRatio = rec.frontFace ? (1.0 / _ri) : _ri;

        Vec3 unitDirection = rIn.direction.unitVector;
        double cosTheta = (-unitDirection).dot(rec.normal).fmin(1.0);
        double sinTheta = (1.0 - cosTheta * cosTheta).sqrt;

        bool cannotRefract = refractionRatio * sinTheta > 1.0;
        Vec3 direction;

        if (cannotRefract || reflectance(cosTheta, refractionRatio) > randomDouble)
        {
            direction = unitDirection.reflect(rec.normal);
        }
        else
        {
            direction = unitDirection.refract(rec.normal, refractionRatio);
        }

        scattered = new Ray(rec.p, direction);
        return true;
    }

private:
    double _ri;

    static double reflectance(double cosine, double refIdx)
    {
        // Use Schlick's approximation for reflectance
        auto r0 = (1 - refIdx) / (1 + refIdx);
        r0 = r0 * r0;
        return r0 + (1 - r0) * (1 - cosine).pow(5);
    }
}
