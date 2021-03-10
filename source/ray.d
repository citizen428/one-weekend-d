import vec3;

alias Point = Vec3;

class Ray
{
    this()
    {
        this(new Point(0, 0, 0), new Vec3(0, 0, 0));
    }

    this(Point origin, Vec3 direction)
    {
        _origin = origin;
        _direction = direction;
    }

    Point origin()
    {
        return _origin;
    }

    Vec3 direction()
    {
        return _direction;
    }

    Point at(double t)
    {
        return origin + t * direction;
    }

private:
    Point _origin;
    Vec3 _direction;
}

unittest
{
    auto origin = new Point(1, 2, 3);
    auto direction = new Point(1, 2, 3);
    auto ray = new Ray(origin, direction);
    assert(ray.at(1) == new Point(2, 4, 6));
    assert(ray.at(-1) == new Point(0, 0, 0));
    assert(ray.at(2) == new Point(3, 6, 9));
}
