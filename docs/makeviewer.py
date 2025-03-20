import os
import pathlib
from pathlib import Path

# dir containing this script, /docs
DOCS_DIR = pathlib.Path(__file__).parent.resolve()

# list of relate image paths to insert into viewer
PATHS: list[Path] = ["./notes/" + fname for fname in sorted(os.listdir(DOCS_DIR / "notes"))]
print(PATHS)
with open(DOCS_DIR / "index.html", "w") as f:
    f.write(f"""<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>saffron's matrices notes</title>
    <link rel="stylesheet" href="./style.css">
  </head>
  <body>
    <img src={" /><img src=".join(path for path in PATHS)} />
  </body>
</html>
""")