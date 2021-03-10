import std.conv : to;
import std.format : format;
import std.math : cos;
import std.stdio;

import camera;
import color;
import hittable;
import material;
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
    HittableList randomScene()
    {
        auto world = new HittableList();

        auto groudMaterial = new Lambertian(new Color(0.5, 0.5, 0.5));
        world.add(new Sphere(new Point(0, -1000, 0), 1000, groudMaterial));

        foreach (a; -11 .. 11)
        {
            foreach (b; -11 .. 11)
            {
                const auto chooseMat = randomDouble;
                auto center = new Point(a + 0.9 * randomDouble, 0.2, b + 0.9 * randomDouble);

                if ((center - new Point(4, 0.2, 0)).length > 0.9)
                {
                    Material sphereMaterial;

                    if (chooseMat < 0.8)
                    {
                        // diffuse
                        auto albedo = Color.random * Color.random;
                        sphereMaterial = new Lambertian(albedo);
                    }
                    else if (chooseMat < 0.95)
                    {
                        // metal
                        auto albedo = Color.random(0.5, 1);
                        auto fuzz = randomDouble(0, 0.5);
                        sphereMaterial = new Metal(albedo, fuzz);
                    }
                    else
                    {
                        // glass
                        sphereMaterial = new Dielectric(1.5);
                    }
                    world.add(new Sphere(center, 0.2, sphereMaterial));
                }
            }
        }

        auto material1 = new Dielectric(1.5);
        world.add(new Sphere(new Point(0, 1, 0), 1, material1));

        auto material2 = new Lambertian(new Color(0.4, 0.2, 0.1));
        world.add(new Sphere(new Point(-4, 1, 0), 1, material2));

        auto material3 = new Metal(new Color(0.7, 0.6, 0.5), 0);
        world.add(new Sphere(new Point(4, 1, 0), 1, material3));

        return world;
    }

    void main()
    {
        // Image
        const auto aspectRatio = 3.0 / 2.0;
        const int imageWidth = 1200;
        const imageHeight = (imageWidth / aspectRatio).to!int;
        const int samplesPerPixel = 250;
        const int maxDepth = 50;

        // World
        auto world = randomScene;

        // Camera
        auto lookFrom = new Point(13, 2, 3);
        auto lookAt = new Point(0, 0, 0);
        auto vup = new Vec3(0, 1, 0);
        auto distToFocus = 10.0;
        auto aperture = 0.1;

        auto camera = new Camera(lookFrom, lookAt, vup, 20, aspectRatio, aperture, distToFocus);

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
