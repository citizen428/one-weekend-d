import std.math : sqrt;

import hittable;
import ray;
import vec3;

class Sphere : Hittable
{
    this(Point center, double radius)
    {
        _center = center;
        _radius = radius;
    }

    override bool hit(Ray r, double tMin, double tMax, ref HitRecord rec)
    {
        auto oc = r.origin - _center;
        auto a = r.direction.lengthSquared;
        auto halfB = oc.dot(r.direction);
        auto c = oc.lengthSquared - _radius * _radius;

        auto discriminant = halfB * halfB - a * c;
        if (discriminant < 0)
        {
            return false;
        }
        auto sqrtd = discriminant.sqrt;

        // Find the nearest root within acceptable range
        auto root = (-halfB - sqrtd) / a;
        if (root < tMin || root > tMax)
        {
            root = (-halfB + sqrtd) / a;
            if (root < tMin || root > tMax)
            {
                return false;
            }
        }

        rec.t = root;
        rec.p = r.at(rec.t);
        Vec3 outwardNormal = (rec.p - _center) / _radius;
        rec.setFaceNormal(r, outwardNormal);

        return true;
    }

    private:
    Point _center;
    double _radius;
}
