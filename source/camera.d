import std.math : tan;

import ray;
import util;
import vec3;

class Camera
{
    this(
            Point lookFrom,
            Point lookAt,
            Vec3 vup,
            double vFov,
            double aspectRatio
        )
    {
        auto theta = vFov.degreesToRadians;
        auto h = (theta / 2).tan;
        auto viewportHeight = h * 2.0;
        auto viewportWidth = aspectRatio * viewportHeight;

        auto w = (lookFrom - lookAt).unitVector;
        auto u = vup.cross(w).unitVector;
        auto v = w.cross(u);

        origin = lookFrom;
        horizontal = viewportWidth * u;
        vertical = viewportHeight * v;
        lowerLeftCorner = origin - horizontal / 2 - vertical / 2 - w;

    }

    Ray getRay(double s, double t)
    {
        return new Ray(origin, lowerLeftCorner + s * horizontal + t * vertical -
                origin);
    }

    private:
    Point origin;
    Point lowerLeftCorner;
    Vec3 horizontal;
    Vec3 vertical;
}
