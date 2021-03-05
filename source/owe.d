import std.conv : to;
import std.format : format;
import std.stdio;

import camera;
import color;
import hittableList;
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

        // World
        auto world = new HittableList();
        world.add(new Sphere(new Point(0, 0, -1), 0.5));
        world.add(new Sphere(new Point(0, -100.5, -1), 100));

        // Camera
        auto camera = new Camera();

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
                    pixelColor += r.rayColor(world);
                }
                writeColor(pixelColor, samplesPerPixel);
            }
        }
        stderr.writeln("\nDone.");
    }
}
