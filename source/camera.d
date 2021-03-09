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
            double aspectRatio,
            double aperture,
            double focusDist
        )
    {
        auto theta = vFov.degreesToRadians;
        auto h = (theta / 2).tan;
        auto viewportHeight = h * 2.0;
        auto viewportWidth = aspectRatio * viewportHeight;

        w = (lookFrom - lookAt).unitVector;
        u = vup.cross(w).unitVector;
        v = w.cross(u);

        origin = lookFrom;
        horizontal = focusDist * viewportWidth * u;
        vertical = focusDist * viewportHeight * v;
        lowerLeftCorner = origin - horizontal / 2 - vertical / 2 - focusDist * w;

        lensRadius = aperture / 2;
    }

    Ray getRay(double s, double t)
    {
        Vec3 rd = lensRadius * Vec3.randomInUnitDisk;
        Vec3 offset = u * rd.x + v * rd.y;

        return new Ray(origin + offset, lowerLeftCorner + s * horizontal +
                t * vertical - origin - offset);
    }

    private:
    Point origin;
    Point lowerLeftCorner;
    Vec3 horizontal;
    Vec3 vertical;
    Vec3 u;
    Vec3 v;
    Vec3 w;
    double lensRadius;
}
