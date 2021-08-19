{ lib, stdenv, fetchPypi, fetchFromGitHub, writeText, buildPythonPackage
, absl-py, jaxlib, numpy, opt-einsum, pytest
}:

buildPythonPackage rec {
  pname = "jax";
  version = "0.2.19";

  # Fetching from pypi doesn't allow us to run the test suite. See https://discourse.nixos.org/t/pythonremovetestsdir-hook-being-run-before-checkphase/14612/3.
  src = fetchFromGitHub {
    owner = "google";
    repo = pname;
    rev = "jax-v${version}";
    sha256 = "sha256-pVn62G7pydR7ybkf7gSbu0FlEq2c0US6H2GTBAljup4=";
  };

  propagatedBuildInputs =
    [
      absl-py
      jaxlib
      numpy
      opt-einsum
    ];

  # >>> import jax
  # >>> import jax.numpy as jnp
  # >>> jnp.array([1, 2, 3])
  # Segmentation fault: 11

  # Test suite has loads of segfaults.
  doCheck = false;
  checkInputs = [ pytest ];
  checkPhase = "pytest tests/";

  meta = with lib; {
    description = "Differentiate, compile, and transform Numpy code.";
    homepage    = "https://github.com/google/jax";
    license     = licenses.asl20;
    maintainers = with maintainers; [ samuela ];
  };
}
