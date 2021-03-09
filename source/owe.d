import std.conv : to;
import std.format : format;
import std.math : cos;
import std.stdio;

import camera;
import color;
import dielectric;
import hittableList;
import lambertian;
import metal;
import ray;
import sphere;
import util;
import vec3;

version (unittest)
{
    // Do nothing here, dub takes care of that
}
else
{
    void main()
    {
        // Image
        const auto aspectRatio = 16.0 / 9.0;
        const int imageWidth = 400;
        const imageHeight = to!int(imageWidth / aspectRatio);
        const int samplesPerPixel = 100;
        const int maxDepth = 50;

        // World
        auto world = new HittableList();

        auto materialGround = new Lambertian(new Color(0.8, 0.8, 0.0));
        auto materialCenter = new Lambertian(new Color(0.1, 0.2, 0.5));
        auto materialLeft = new Dielectric(1.5);
        auto materialRight = new Metal(new Color(0.8, 0.6, 0.2), 0.0);

        world.add(new Sphere(new Point(0.0, -100.5, 1), 100, materialGround));
        world.add(new Sphere(new Point(0, 0, -1), 0.5, materialCenter));
        world.add(new Sphere(new Point(-1, 0, -1), 0.5, materialLeft));
        world.add(new Sphere(new Point(-1, 0, -1), -0.4, materialLeft));
        world.add(new Sphere(new Point(1, 0, -1), 0.5, materialRight));

        // Camera
        auto lookFrom = new Point(-2, 2, 1);
        auto lookAt = new Point(0, 0, -1);
        auto vup = new Vec3(0, 1, 0);
        auto camera = new Camera(lookFrom, lookAt, vup, 20, aspectRatio);

        // Render
        writeln(format("P3\n%s %s\n255", imageWidth, imageHeight));
        for (int j = imageHeight - 1; j >= 0; --j)
        {
            stderr.write(format("\rScanlines remaining: %d", j));
            for (int i = 0; i < imageWidth; ++i)
            {
                auto pixelColor = new Color(0, 0, 0);
                for (int s = 0; s < samplesPerPixel; ++s)
                {
                    auto u = (i + randomDouble) / (imageWidth - 1);
                    auto v = (j + randomDouble) / (imageHeight - 1);
                    auto r = camera.getRay(u, v);
                    pixelColor += r.rayColor(world, maxDepth);
                }
                writeColor(pixelColor, samplesPerPixel);
            }
        }
        stderr.writeln("\nDone.");
    }
}
