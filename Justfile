# Run unit tests
test:
    @dub test

# Render image
render name: build
    #!/usr/bin/env bash
    set -euo pipefail
    ppm="{{ name }}.ppm"
    png="{{ name }}.png"
    bin/rtow > "$ppm"
    magick "$ppm" "$png"
    rm "$ppm"
    optipng -o9 -strip all "$png"

# Build release version
build:
    @dub build -c=application -b release

# Clean up bin/
clean:
    @rm -f bin/*
