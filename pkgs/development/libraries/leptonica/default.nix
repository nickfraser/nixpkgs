{ stdenv, fetchFromGitHub, autoreconfHook, pkgconfig, which, gnuplot
, giflib, libjpeg, libpng, libtiff, libwebp, openjpeg, zlib
}:

stdenv.mkDerivation rec {
  pname = "leptonica";
  version = "1.79.0";

  src = fetchFromGitHub {
    owner = "DanBloomBerg";
    repo = "leptonica";
    rev = version;
    sha256 = "0pnab40fyn6jzprm1xm5ij98jndbmy6w5hgiviy9j7vd3gpfzn7q";
  };

  nativeBuildInputs = [ autoreconfHook pkgconfig ];
  buildInputs = [ giflib libjpeg libpng libtiff libwebp openjpeg zlib ];
  enableParallelBuilding = true;

  checkInputs = [ which gnuplot ];

  # Fails on pngio_reg for unknown reason
  doCheck = false; # !stdenv.isDarwin;

  meta = {
    description = "Image processing and analysis library";
    homepage = http://www.leptonica.org/;
    license = stdenv.lib.licenses.bsd2; # http://www.leptonica.org/about-the-license.html
    platforms = stdenv.lib.platforms.unix;
  };
}
