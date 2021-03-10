import std.math : sqrt;

import hittable;
import material;
import ray;
import vec3;

class Sphere : Hittable
{
    this(Point center, double radius, Material mat)
    {
        _center = center;
        _radius = radius;
        _mat = mat;
    }

    override bool hit(ref Ray r, double tMin, double tMax, ref HitRecord rec)
    {
        auto oc = r.origin - _center;
        const auto a = r.direction.lengthSquared;
        const auto halfB = oc.dot(r.direction);
        const auto c = oc.lengthSquared - _radius * _radius;

        const auto discriminant = halfB * halfB - a * c;
        if (discriminant < 0)
        {
            return false;
        }
        immutable auto sqrtd = discriminant.sqrt;

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
        rec.mat = _mat;
        Vec3 outwardNormal = (rec.p - _center) / _radius;
        rec.setFaceNormal(r, outwardNormal);

        return true;
    }

private:
    Point _center;
    double _radius;
    Material _mat;
}
