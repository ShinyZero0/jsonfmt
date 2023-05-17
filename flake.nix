{
  description = "A very basic .NET flake";

  inputs = { nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable"; };
  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      dotnetPkgs = with pkgs;
        (with dotnetCorePackages; combinePackages [ sdk_7_0 sdk_6_0 ]);
    in {
      devShells.x86_64-linux.default = pkgs.mkShell {
        name = "jsonfmt";
        buildInputs = with pkgs; [ dotnetPkgs clang zlib omnisharp-roslyn ];
        shellHook = ''
          export DOTNET_ROOT=${dotnetPkgs}
        '';
      };
      packages.${system}.default = pkgs.stdenv.mkDerivation {
        pname = "jsonfmt";
        version = "0.0.1";
        # unpackPhase = ":";
        src = pkgs.fetchFromGitHub {
          owner = "ShinyZero0";
          repo = "jsonfmt";
          rev = "0.0.1";
          sha256 = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
        };
        nativeBuildInputs = with pkgs; [ zlib ];
        buildInputs = with pkgs; [ icu ];
        buildPhase = ''
          					HOME=$PWD/home
          					PATH=${pkgs.dotnet-sdk_7}/bin:$PATH
          					DOTNET_ROOT=${pkgs.dotnet-sdk_7}

          					mkdir -p $HOME
                    dotnet publish -o ./out/
        '';

        installPhase = ''
          mkdir -p $out/bin
          cp ./out/jsonfmt $out/bin/
        '';
      };
    };
}
