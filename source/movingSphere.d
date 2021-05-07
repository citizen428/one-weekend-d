import std.math : sqrt;

import hittable;
import material;
import ray;
import vec3;

class MovingSphere : Hittable
{
    this(Point cen0, Point cen1, double _time0, double _time1, double r, ref Material mat)
    {
        center0 = cen0;
        center1 = cen1;
        time0 = _time0;
        time1 = _time1;
        radius = r;
        material = mat;
    }

    Point center(double time)
    {
        return center0 + ((time - time0) / (time1 - time0)) * (center1 - center0);
    }

    override bool hit(ref Ray r, double tMin, double tMax, ref HitRecord rec)
    {
        auto oc = r.origin - this.center(r.time);
        const auto a = r.direction.lengthSquared;
        const auto halfB = oc.dot(r.direction);
        const auto c = oc.lengthSquared - radius * radius;

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
        rec.mat = material;
        Vec3 outwardNormal = (rec.p - this.center(r.time)) / radius;
        rec.setFaceNormal(r, outwardNormal);

        return true;
    }

public:
    Point center0, center1;
    double time0, time1;
    double radius;
    Material material;
}
