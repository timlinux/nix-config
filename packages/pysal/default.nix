{ lib
, buildPythonPackage
, fetchPypi

# build-system
, setuptools-scm

# dependencies
, attrs
, pluggy
, py
, setuptools
, six

# tests
, hypothesis
 }:

buildPythonPackage rec {
  pname = "pysal";
  version = "23.01";
  format = "setuptools";

  src = fetchPypi {
    inherit pname version;
    hash = "";
  };

  postPatch = ''
    # don't test bash builtins
    rm testing/test_argcomplete.py
  '';

  nativeBuildInputs = [
    setuptools-scm
  ];

  propagatedBuildInputs = [
    attrs
    py
    setuptools
    six
    pluggy
  ];

  nativeCheckInputs = [
    hypothesis
  ];

  meta = with lib; {
    changelog = "https://github.com/pysal/pysal/releases/tag/${version}";
    description = "Python Spatial Analysis Library";
    homepage = "https://github.com/pysal/pysal";
    license = licenses.bsd3;
    maintainers = with maintainers; [ timlinux ];
  };
}
