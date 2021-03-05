import std.algorithm.comparison : clamp;
import std.conv : to;
import std.format : format;
import std.stdio : writeln;

import hittable;
import ray;
import sphere;
import util;
import vec3;

alias Color = Vec3;

void writeColor(Color pixelColor, int samplesPerPixel)
{
    // Divide the color by the number of samples
    auto scale = 1.0 / samplesPerPixel;
    auto r = 256 * clamp(pixelColor.x * scale, 0.0, 0.999);
    auto g = 256 * clamp(pixelColor.y * scale, 0.0, 0.999);
    auto b = 256 * clamp(pixelColor.z * scale, 0.0, 0.999);

    writeln(format("%d %d %d", r.to!int, g.to!int, b.to!int));
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
