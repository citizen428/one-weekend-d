import std.conv : to;
import std.format : format;
import std.stdio : writeln;

import hittable;
import ray;
import sphere;
import util;
import vec3;

alias Color = Vec3;

void writeColor(Color pixelColor)
{
    const int r = to!int(255.999 * pixelColor.x);
    const int g = to!int(255.999 * pixelColor.y);
    const int b = to!int(255.999 * pixelColor.z);

    writeln(format("%d %d %d", r, g, b));
}

Color rayColor(Ray r, Hittable world)
{
    HitRecord rec;
    if (world.hit(r, 0, infinity, rec))
    {
        return 0.5 * (rec.normal + new Color(1.0, 1.0, 1.0));
    }

    auto unitDirection = r.direction.unitVector;
    auto t = 0.5 * (unitDirection.y + 1.0);
    // linearly blend white and blue
    return (1.0 - t) * new Color(1.0, 1.0, 1.0) + t * new Color(0.5, 0.7, 1.0);
}
