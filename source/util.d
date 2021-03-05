const double infinity = double.infinity;
const double pi = 3.1415926535897932385;

pragma(inline):
double degreesToRadians(double degrees)
{
    return degrees * pi / 180.0;
}
