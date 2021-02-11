import std.conv : to;
import std.format : format;
import std.stdio : write;
import vec3;

alias Color = Vec3;

void writeColor(Color pixelColor)
{
    const int r = to!int(255.999 * pixelColor.x);
    const int g = to!int(255.999 * pixelColor.y);
    const int b = to!int(255.999 * pixelColor.z);

    write(format("%d %d %d\n", r, g, b));
}
