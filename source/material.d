import std.math : fmin, pow, sqrt;

import color;
import hittable;
import material;
import ray;
import util;
import vec3;

abstract class Material
{
    abstract bool scatter(ref Ray rIn, ref HitRecord rec, ref Color attenuation, ref Ray scattered);
}

class Dielectric : Material
{
    this(double refractionIndex)
    {
        ri = refractionIndex;
    }

    override bool scatter(ref Ray rIn, ref HitRecord rec, ref Color attenuation, ref Ray scattered)
    {
        attenuation = new Color(1, 1, 1);
        double refractionRatio = rec.frontFace ? (1.0 / ri) : ri;

        Vec3 unitDirection = rIn.direction.unitVector;
        const double cosTheta = (-unitDirection).dot(rec.normal).fmin(1.0);
        const double sinTheta = (1.0 - cosTheta * cosTheta).sqrt;

        const bool cannotRefract = refractionRatio * sinTheta > 1.0;
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
    double ri;

    static double reflectance(double cosine, double refIdx)
    {
        // Use Schlick's approximation for reflectance
        auto r0 = (1 - refIdx) / (1 + refIdx);
        r0 = r0 * r0;
        return r0 + (1 - r0) * (1 - cosine).pow(5);
    }
}

class Lambertian : Material
{
    this(Color a)
    {
        albedo = a;
    }

    override bool scatter(ref Ray rIn, ref HitRecord rec, ref Color attenuation, ref Ray scattered)
    {
        auto scatterDirection = rec.normal + Vec3.randomUnitVector;

        // catch degenerate scatter direction
        if (scatterDirection.nearZero)
        {
            scatterDirection = rec.normal;
        }

        scattered = new Ray(rec.p, scatterDirection);
        attenuation = albedo;
        return true;
    }

private:
    Color albedo;
}

class Metal : Material
{
    this(Color a, double f)
    {
        albedo = a;
        fuzz = f < 1 ? f : 1;
    }

    override bool scatter(ref Ray rIn, ref HitRecord rec, ref Color attenuation, ref Ray scattered)
    {
        Vec3 reflected = rIn.direction.unitVector.reflect(rec.normal);
        scattered = new Ray(rec.p, reflected + fuzz * Vec3.randomInUnitSphere);
        attenuation = albedo;
        return scattered.direction.dot(rec.normal) > 0;
    }

private:
    Color albedo;
    double fuzz;
}
