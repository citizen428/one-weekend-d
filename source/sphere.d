import std.math : sqrt;

import ray;
import vec3;

class Sphere
{
    this(Point center, double radius)
    {
        _center = center;
        _radius = radius;
    }

    double hit(Ray r)
    {
        auto oc = r.origin - _center;
        auto a = r.direction.lengthSquared;
        auto halfB = oc.dot(r.direction);
        auto c = oc.lengthSquared - _radius * _radius;
        auto discriminant = halfB * halfB - a * c;

        if (discriminant < 0)
        {
            return -1.0;
        }
        else
        {
            return (-halfB - discriminant.sqrt) / a;
        }
    }

private:
    Point _center;
    double _radius;
}
