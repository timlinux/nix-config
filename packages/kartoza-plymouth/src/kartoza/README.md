Kartoza Theme by Tim

Based on work by https://github.com/Hugopikachu/plymouth-theme-chain

I used their script to assign Kartoza colours:

```
nix-shell -p bc
./change-color.sh background "#FFFFFF"
./change-color.sh main "#DF9E2F"
./change-color.sh secondary "#569FC6"
```

Images must be 1920x1080

Render with synfig then use the rename script to remove trailing zeros from
sequence numbers.
