import std.algorithm.comparison : clamp;
import std.conv : to;
import std.format : format;
import std.math : sqrt;
import std.stdio : writeln;

import hittable;
import hittableList;
import ray;
import sphere;
import util;
import vec3;

alias Color = Vec3;

void writeColor(Color pixelColor, int samplesPerPixel)
{
    // Divide the color by the number of samples and gamma correct
    auto scale = 1.0 / samplesPerPixel;
    auto r = 256 * (pixelColor.x * scale).sqrt.clamp(0.0, 0.999);
    auto g = 256 * (pixelColor.y * scale).sqrt.clamp(0.0, 0.999);
    auto b = 256 * (pixelColor.z * scale).sqrt.clamp(0.0, 0.999);

    writeln(format("%d %d %d", r.to!int, g.to!int, b.to!int));
}

Color rayColor(Ray r, ref HittableList world, int depth)
{
    HitRecord rec;

    if (depth <= 0) { return new Color(0, 0, 0); }

    if (world.hit(r, 0, infinity, rec))
    {
        Point target = rec.p + rec.normal + Vec3.randomInUnitSphere;
        auto newRay = new Ray(rec.p, target - rec.p);
        return 0.5 * rayColor(newRay, world, depth - 1);
    }

    auto unitDirection = r.direction.unitVector;
    auto t = 0.5 * (unitDirection.y + 1.0);
    // linearly blend white and blue
    return (1.0 - t) * new Color(1.0, 1.0, 1.0) + t * new Color(0.5, 0.7, 1.0);
}
