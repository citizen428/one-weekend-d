import ray;
import vec3;

class Camera
{
    this()
    {
        auto aspectRatio = 16.0 / 9.0;
        auto viewportHeight = 2.0;
        auto viewportWidth = aspectRatio * viewportHeight;
        auto focalLength = 1.0;

        _origin = new Point(0, 0, 0);
        _horizontal = new Vec3(viewportWidth, 0, 0);
        _vertical = new Vec3(0, viewportHeight, 0);
        _lowerLeftCorner = _origin - _horizontal / 2 - _vertical / 2 -
            new Vec3(0, 0, focalLength);
    }

    Ray getRay(double u, double v)
    {
        return new Ray(_origin, _lowerLeftCorner + u * _horizontal +
                v * _vertical - _origin);
    }

private:
    Point _origin;
    Point _lowerLeftCorner;
    Vec3 _horizontal;
    Vec3 _vertical;
}
