import std.conv : to;
import std.format : format;
import std.stdio;

import color;
import hittableList;
import ray;
import sphere;
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

        // World
        auto world = new HittableList();
        world.add(new Sphere(new Point(0, 0, -1), 0.5));
        world.add(new Sphere(new Point(0, -100.5, -1), 100));

        // Camera
        auto viewportHeight = 2.0;
        auto viewportWidth = aspectRatio * viewportHeight;
        auto focalLenght = 1.0;

        auto origin = new Point(0, 0, 0);
        auto horizontal = new Vec3(viewportWidth, 0, 0);
        auto vertical = new Vec3(0, viewportHeight, 0);
        auto lowerLeftCorner = origin - horizontal / 2 - vertical / 2 - new Vec3(0, 0, focalLenght);

        // Render
        writeln(format("P3\n%s %s\n255", imageWidth, imageHeight));
        for (int j = imageHeight - 1; j >= 0; --j)
        {
            stderr.write(format("\rScanlines remaining: %d", j));
            for (int i = 0; i < imageWidth; ++i)
            {
                auto u = to!double(i) / (imageWidth - 1);
                auto v = to!double(j) / (imageHeight - 1);
                auto r = new Ray(origin, lowerLeftCorner + u * horizontal + v * vertical - origin);
                Color pixelColor = rayColor(r, world);
                writeColor(pixelColor);
            }
        }
        stderr.writeln("\nDone.");
    }
}
