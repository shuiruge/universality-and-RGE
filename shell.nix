# shell.nix
with import <nixpkgs> { };
let
  pythonPackages = python3Packages;
in pkgs.mkShell rec {
  name = "impurePythonEnv";
  venvDir = "./.venv";
  buildInputs = [
    # A python interpreter including the 'venv' module is required to bootstrap
    # the environment.
    pythonPackages.python

    # This execute some shell code to initialize a venv in $venvDir before
    # dropping into the shell
    pythonPackages.venvShellHook
  ];

  # See: https://discourse.nixos.org/t/how-to-solve-libstdc-not-found-in-shell-nix/25458/16
  LD_LIBRARY_PATH = lib.makeLibraryPath [ pkgs.stdenv.cc.cc ];

  # Now we can execute any commands within the virtual environment.
  # This is optional and can be left out to run pip manually.
  postShellHook = ''
    if [ ! -d .venv ]; then
      # pip install --no-cache-dir -r requirements.txt
      pip install --no-cache-dir -r requirements.txt -i https://pypi.tuna.tsinghua.edu.cn/simple  # for Chinese user.
    else
      echo "Skipping pip install, './.venv' already exists."
    fi
  '';

}
