import ray;
import vec3;

struct HitRecord
{
    Point p;
    Vec3 normal;
    double t;
    bool frontFace;

pragma(inline):
    void setFaceNormal(Ray r, Vec3 outwardNormal)
    {
        frontFace = r.direction.dot(outwardNormal) < 0;
        normal = frontFace ? outwardNormal : -outwardNormal;
    }
}

interface Hittable
{
    bool hit(Ray r, double tMin, double tMax, ref HitRecord rec);
}
