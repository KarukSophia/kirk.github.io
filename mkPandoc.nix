{pkgs, ...}:
pkgs.writeShellApplication {
  name = "my-script";
  runtimeInputs = with pkgs; [ pandoc ];
  text = ''
    mkdir -p out
    mkdir -p out/articles
    cp -r ./articles ./styling ./documents ./out

    pandoc \
      --standalone \
      --highlight-style styling/gruvbox.theme \
      --template template.html \
      --metadata date="$(date -u '+%Y-%m-%d - %H:%M:%S %Z')" \
      --css=styling/style.css \
      -V lang=en \
      -V --mathjax \
      -f markdown+smart \
      -o out/index.html \
      index.md

    pandoc \
      --standalone \
      --highlight-style styling/gruvbox.theme \
      --template template.html \
      --metadata date="$(date -u '+%Y-%m-%d - %H:%M:%S %Z')" \
      --css styling/style.css \
      -V lang=en \
      -V --mathjax \
      -f markdown+smart \
      -o out/articles/index.html \
      articles/index.md
  '';
}
