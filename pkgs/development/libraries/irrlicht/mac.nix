{ stdenv, fetchzip, libGLU_combined, unzip, fetchFromGitHub, cmake, Cocoa, OpenGL, IOKit }:

let
  version = "1.8.4";

  irrlichtZip = fetchzip {
    name = "irrlichtZip";
    url = "mirror://sourceforge/irrlicht/irrlicht-${version}.zip";
    sha256 = "02sq067fn4xpf0lcyb4vqxmm43qg2nxx770bgrl799yymqbvih5f";
  };

in

stdenv.mkDerivation rec {
  pname = "irrlicht-mac";
  inherit version;

  src = fetchFromGitHub {
    owner = "quiark";
    repo = "IrrlichtCMake";
    rev = "09dcbacef1bc65da780f45ad4a4c4dad561b3949";
    sha256 = "1fzlrdynqhfc514pn054xwp2p8h6smjrvzrgk5csjy5nslblv2cs";
  };

  postUnpack = ''
    cp -r ${irrlichtZip}/* $sourceRoot/
    chmod -R 777 $sourceRoot
  '';

  patches = [ ./mac_device.patch ];
  dontFixCmake = true;

  cmakeFlags = [
    "-DCMAKE_FRAMEWORK_PATH=${OpenGL}/Library/Frameworks/"
    "-DIRRLICHT_STATIC_LIBRARY=ON"
    "-DIRRLICHT_BUILD_EXAMPLES=OFF"
    "-DIRRLICHT_INSTALL_MEDIA_FILES=OFF"
    "-DIRRLICHT_ENABLE_X11_SUPPORT=OFF"
    "-DIRRLICHT_BUILD_TOOLS=OFF"
  ];

  nativeBuildInputs = [ cmake ];
  buildInputs = [ unzip Cocoa OpenGL IOKit ];

  meta = {
    homepage = http://irrlicht.sourceforge.net/;
    license = stdenv.lib.licenses.zlib;
    description = "Open source high performance realtime 3D engine written in C++";
    platforms = stdenv.lib.platforms.darwin;
  };
}
