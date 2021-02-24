import std.conv : to;
import std.format : format;
import std.stdio : writeln;

import ray;
import sphere;
import vec3;

alias Color = Vec3;

void writeColor(Color pixelColor)
{
    const int r = to!int(255.999 * pixelColor.x);
    const int g = to!int(255.999 * pixelColor.y);
    const int b = to!int(255.999 * pixelColor.z);

    writeln(format("%d %d %d", r, g, b));
}

Color rayColor(Ray r)
{
    auto t = new Sphere(new Point(0, 0, -1), 0.5).hit(r);
    if (t > 0.0)
    {
        auto n = (r.at(t) - new Vec3(0, 0, -1));
        return 0.5 * new Color(n.x + 1, n.y + 1, n.z + 1);
    }
    auto unitDirection = r.direction.unitVector;
    t = 0.5 * (unitDirection.y + 1.0);
    // linearly blend white and blue
    return (1.0 - t) * new Color(1.0, 1.0, 1.0) + t * new Color(0.5, 0.7, 1.0);
}
