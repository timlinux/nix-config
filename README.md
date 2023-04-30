See other examples such as https://github.com/michaelpj/nixos-config


## Flake

```
# Run gnu hello
nix build
nix run

# Run cowsay
nix build .\#thing1.thing2
nix run .\#thing1.thing2 hello
```
