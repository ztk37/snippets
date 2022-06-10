let
  pkgs = import <nixpkgs> {};

  inherit (pkgs) writeScriptBin  mkShell;

  doSomething = writeScriptBin "something" ''
    echo Something
  '';

  doSomethingElse = writeScriptBin "something-else" ''
    echo SomethingElse
  '';

  doSomethingDifferent = writeScriptBin "some-script" ''
    echo SomethingDifferent
  '';

in mkShell {
  name = "shell";

  buildInputs = [
    doSomething
    doSomethingElse
    doSomethingDifferent
  ];

  shellHook = ''
     echo "=> Hooked..."
  '';
}
