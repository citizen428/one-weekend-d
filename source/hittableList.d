import std.array;

import hittable;
import ray;

class HittableList : Hittable
{
    this()
    {
        _objects = [];
    }

    this(Hittable object)
    {
        this();
        add(object);
    }

    void clear()
    {
        _objects = [];
    }

    void add(Hittable object)
    {
        _objects ~= object;
    }

    override bool hit(Ray r, double tMin, double tMax, ref HitRecord rec)
    {
        HitRecord tempRec;
        bool hitAnything = false;
        auto closestSoFar = tMax;

        foreach (object; _objects)
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
    Hittable[] _objects;
}
