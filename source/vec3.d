import std.format : format;
import std.math : sqrt;

class Vec3
{
    this(double e1, double e2, double e3)
    {
        _x = e1;
        _y = e2;
        _z = e3;
    }

    this()
    {
        this(0, 0, 0);
    }

    double x() const
    {
        return _x;
    }

    double y() const
    {
        return _y;
    }

    double z() const
    {
        return _z;
    }

    // Operators
    Vec3 opUnary(string op)() if (op == "-")
    {
        return new Vec3(-x, -y, -z);
    }

    override bool opEquals(Object o) const
    {
        if (auto other = cast(Vec3) o)
        {
            return x == other.x && y == other.y && z == other.z;
        }
        else
        {
            return false;
        }
    }

    void opOpAssign(string op)(const Vec3 vec) if (op == "+")
    {
        _x += vec.x;
        _y += vec.y;
        _z += vec.z;
    }

    void opOpAssign(string op)(const double t) if (op == "*")
    {
        _x *= t;
        _y *= t;
        _z *= t;
    }

    Vec3 opBinary(string op)(Vec3 v)
    {
        static if (op == "+")
            return new Vec3(x + v.x, y + v.y, z + v.z);
        else static if (op == "-")
            return new Vec3(x - v.x, y - v.y, z - v.z);
        else static if (op == "*")
            return new Vec3(x * v.x, y * v.y, z * v.z);
    }

    Vec3 opBinary(string op)(const double t)
    {
        static if (op == "*")
            return new Vec3(x * t, y * t, z * t);
        else static if (op == "/")
            return this * (1 / t);
    }

    Vec3 opBinaryRight(string op)(const double t) if (op == "*")
    {
        return this * t;
    }

    // Methods
    double length() const
    {
        return sqrt(lengthSquared);
    }

    double lengthSquared() const
    {
        return x * x + y * y + z * z;
    }

    double dot(Vec3 v) const
    {
        return x * v.x + y * v.y + z * v.z;
    }

    Vec3 cross(Vec3 v) const
    {
        return new Vec3(y * v.z - z * v.y, z * v.x - x * v.z, x * v.y - y * v.x);
    }

    Vec3 unitVector()
    {
        return this / this.length;
    }

    override string toString()
    {
        return format("{X: %s, Y: %s, Z: %s}", x, y, z);
    }

private:
    double _x;
    double _y;
    double _z;
}

unittest
{
    // Constructors
    assert((new Vec3).toString == "{X: 0, Y: 0, Z: 0}");
    auto vec = new Vec3(1.1, 2.2, 3.3);
    assert(vec.toString == "{X: 1.1, Y: 2.2, Z: 3.3}");

    // Operators
    assert((-vec).toString == "{X: -1.1, Y: -2.2, Z: -3.3}");
    vec += new Vec3(1, 1, 1);
    assert(vec.toString == "{X: 2.1, Y: 3.2, Z: 4.3}");
    vec *= 2.0;
    assert(vec.toString == "{X: 4.2, Y: 6.4, Z: 8.6}");

    auto v1 = new Vec3(1, 2, 3);
    auto v2 = new Vec3(3, 2, 1);
    assert((v1 + v2).toString == "{X: 4, Y: 4, Z: 4}");
    assert((v1 - v2).toString == "{X: -2, Y: 0, Z: 2}");
    assert((v1 * v2).toString == "{X: 3, Y: 4, Z: 3}");
    assert((v1 * 2.0).toString == "{X: 2, Y: 4, Z: 6}");
    assert((2.0 * v1).toString == "{X: 2, Y: 4, Z: 6}");
    assert((v1 / 2.0).toString == "{X: 0.5, Y: 1, Z: 1.5}");

    // Methods
    assert((new Vec3(0, 3.0, 4.0)).length == 5.0);
    assert((new Vec3(0, 3.0, 4.0)).lengthSquared == 25.0);
    assert(v1.dot(v2) == 10);
    assert(v1.cross(v2).toString == "{X: -4, Y: 8, Z: -4}");
    auto vec3 = new Vec3(1, 5, 1);
    auto expected = vec3 / vec3.length;
    assert(vec3.unitVector.toString == expected.toString);
}
