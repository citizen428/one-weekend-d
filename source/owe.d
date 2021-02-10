import std.conv : to;
import std.format : format;
import std.range : iota;
import std.stdio;

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
      auto r = to!double(i) / (imageWidth - 1);
      auto g = to!double(j) / (imageHeight - 1);
      auto b = 0.25;

      const int ir = to!int(255.999 * r);
      const int ig = to!int(255.999 * g);
      const int ib = to!int(255.999 * b);

      write(format("%d %d %d\n", ir, ig, ib));
    }
  }
  stderr.writeln("\nDone.");
}
