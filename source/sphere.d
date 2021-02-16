import ray;
import vec3;

class Sphere
{
    this(Point center, double radius)
    {
        _center = center;
        _radius = radius;
    }

    bool hitBy(Ray r)
    {
        auto oc = r.origin - _center;
        auto a = r.direction.dot(r.direction);
        auto b = 2.0 * oc.dot(r.direction);
        auto c = oc.dot(oc) - _radius * _radius;
        auto discriminant = b * b - 4 * a * c;
        return discriminant > 0;
    }

private:
    Point _center;
    double _radius;
}
