{
  lib,
  stdenv,
  fetchurl,
  makeWrapper,
  patchelf,
  ripgrep,
  wayland,
}:
# opencode v2 (beta). nixpkgs only ships the 1.x series for now, see
# https://github.com/NixOS/nixpkgs/pull/569770
# To bump: update `version` and the src hash
# (tarball: https://registry.npmjs.org/@opencode/cli-linux-x64/-/cli-linux-x64-<version>.tgz,
#  integrity: `nix hash file --sri <tgz>`)
stdenv.mkDerivation (finalAttrs: {
  pname = "opencode";
  version = "2.0.32";

  src = fetchurl {
    url = "https://registry.npmjs.org/@opencode/cli-linux-x64/-/cli-linux-x64-${finalAttrs.version}.tgz";
    hash = "sha512-Q50ofBQ3gdwjD6ZQhrVR8fVlm8D2xPMshy4dynY6l6b+qLdKgBSJ9WpoaDyrQX1YWmf2s7IN4RbXmoXXdJitDA==";
  };

  nativeBuildInputs = [
    makeWrapper
    patchelf
  ];

  dontStrip = true;
  dontAutoPatchelf = true;

  installPhase = ''
    runHook preInstall

    install -Dm755 bin/opencode $out/bin/opencode
    chmod u+w $out/bin/opencode
    patchelf --set-interpreter "$(stdenv.cc.bintools.dynamicLinker)" $out/bin/opencode
  '';

  postFixup = ''
    wrapProgram $out/bin/opencode \
      --set OPENCODE_DISABLE_AUTOUPDATE true \
      --prefix PATH : ${lib.makeBinPath [ ripgrep ]} \
      --prefix LD_LIBRARY_PATH : ${lib.getLib wayland}/lib
  '';

  meta = {
    description = "AI coding agent built for the terminal";
    homepage = "https://opencode.ai";
    license = lib.licenses.mit;
    mainProgram = "opencode";
    platforms = [ "x86_64-linux" ];
  };
})
