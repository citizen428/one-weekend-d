import color;
import std.conv : to;
import std.format : format;
import std.stdio;

version (unittest)
{
    // Do nothing here, dub takes care of that
}
else
{
    void main()
    {
        // Image
        const int imageWidth = 256;

        const imageHeight = 256;

        // Render
        write(format("P3\n%s %s\n255\n", imageWidth, imageHeight));
        for (int j = imageHeight - 1; j >= 0; --j)
        {
            stderr.write(format("\rScanlines remaining: %d", j));
            for (int i = 0; i < imageWidth; ++i)
            {
                auto color = new Color(to!double(i) / (imageWidth - 1),
                        to!double(j) / (imageHeight - 1),
                        0.25);

                writeColor(color);
            }
        }
        stderr.writeln("\nDone.");
    }
}
