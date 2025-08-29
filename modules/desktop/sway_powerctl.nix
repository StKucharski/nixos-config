{ pkgs }:

pkgs.stdenv.mkDerivation {
  pname = "powerctl";
  version = "1.0";

  phases = [ "installPhase" ];

  installPhase = ''
    mkdir -p $out/bin
    cat > $out/bin/powerctl <<'EOF'
#!/usr/bin/env bash

lock_command="swaylock --screenshots --clock --indicator --indicator-radius 100 --indicator-thickness 7 --effect-blur 7x5 --effect-vignette 0.5:0.5 --ring-color 7f7f7f --key-hl-color 2F4F4F --line-color 00000000 --inside-color 00000088 --separator-color 00000000 --grace 2 --fade-in 0.2 --text-color ffffff --text-ver-color ffffff --inside-ver-color 00000000 --ring-ver-color 00000000 --text-clear-color ffffff --inside-clear-color 00000000 --ring-clear-color 00000000 &"

case "$1" in
  lock)
    eval "$lock_command"
    ;;
  suspend)
    eval "$lock_command"
    sleep 2
    systemctl suspend
    ;;
  locked_suspend)
    systemctl suspend
    ;;
  *)
    echo "Usage: powerctl {lock|suspend|locked_suspend}"
    exit 1
    ;;
esac
EOF
    chmod +x $out/bin/powerctl
  '';
}
