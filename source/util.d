import std.random : uniform;

const double infinity = double.infinity;
const double pi = 3.1415926535897932385;

pragma(inline):
double degreesToRadians(double degrees)
{
    return degrees * pi / 180.0;
}

pragma(inline):
double randomDouble()
{
    return uniform(0.0, 1.0);
}

pragma(inline):
double randomDouble(double min, double max)
{
    return uniform(min, max);
}
