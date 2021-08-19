# For the moment we only support the CPU backend of jaxlib. GPU and TPU backends
# require some additional work. Their wheels are not located on PyPI.
#  * CPU/GPU: https://storage.googleapis.com/jax-releases/jax_releases.html
#  * TPU: https://storage.googleapis.com/jax-releases/libtpu_releases.html

{ lib, stdenv, fetchPypi, buildPythonPackage, isPy39
, absl-py, flatbuffers, scipy
}:

buildPythonPackage rec {
  pname = "jaxlib";
  version = "0.1.70";
  format = "wheel";

  # At the time of writing (8/19/21), there are releases for 3.7-3.9. Supporting
  # all of them is a pain, so we focus on 3.9, the current nixpkgs python3
  # version.
  disabled = !isPy39;

  src = fetchPypi {
    inherit pname version format;
    sha256 = "sha256-pRPXgoYO1n/uFlfGbkUlebYCSjoFvVumhNRKgAld8lA=";
    dist = "cp39";
    python = "cp39";
    platform = {
      x86_64-linux = "manylinux2010_x86_64";
      x86_64-darwin = "macosx_10_9_x86_64";
    }.${stdenv.hostPlatform.system} or (throw "unsupported platform");
  };

  propagatedBuildInputs =
    [
      absl-py
      flatbuffers
      scipy
    ];

  meta = with lib; {
    description = "XLA library for JAX";
    homepage    = "https://github.com/google/jax";
    license     = licenses.asl20;
    maintainers = with maintainers; [ samuela ];
    platforms = [ "x86_64-linux" "x86_64-darwin" ];
  };
}
