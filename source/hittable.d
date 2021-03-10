import std.array;

import material;
import ray;
import vec3;

struct HitRecord
{
    Point p;
    Vec3 normal;
    Material mat;
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
    bool hit(ref Ray r, double tMin, double tMax, ref HitRecord rec);
}

class HittableList : Hittable
{
    this()
    {
        objects = [];
    }

    this(Hittable object)
    {
        this();
        this.add(object);
    }

    void clear()
    {
        objects = [];
    }

    void add(Hittable object)
    {
        objects ~= object;
    }

    override bool hit(ref Ray r, double tMin, double tMax, ref HitRecord rec)
    {
        HitRecord tempRec;
        bool hitAnything = false;
        auto closestSoFar = tMax;

        foreach (object; objects)
        {
            if (object.hit(r, tMin, closestSoFar, tempRec))
            {
                hitAnything = true;
                closestSoFar = tempRec.t;
                rec = tempRec;
            }
        }

        return hitAnything;
    }

private:
    Hittable[] objects;
}
