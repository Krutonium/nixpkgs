{ lib
, buildPythonPackage
, fetchPypi
, setuptools
, httpx
, importlib-metadata
, requests
, tokenizers
, aiohttp
, pythonOlder
}:

buildPythonPackage rec {
  pname = "anthropic";
  version = "0.2.7";
  format = "pyproject";

  disabled = pythonOlder "3.8";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-2v3WF8eRIruXvFNjRRno3LoXt+dlpaI3LHf243RBJ+U=";
  };

  nativeBuildInputs = [
    setuptools
  ];

  propagatedBuildInputs = [
    httpx
    requests
    tokenizers
    aiohttp
  ] ++ lib.optionals (pythonOlder "3.8") [
    importlib-metadata
  ];

  # try downloading tokenizer in tests
  # relates https://github.com/anthropics/anthropic-sdk-python/issues/24
  doCheck = false;

  pythonImportsCheck = [
    "anthropic"
  ];

  meta = with lib; {
    description = "Anthropic's safety-first language model APIs";
    homepage = "https://github.com/anthropics/anthropic-sdk-python";
    changelog = "https://github.com/anthropics/anthropic-sdk-python/releases/tag/v${version}";
    license = licenses.mit;
    maintainers = with maintainers; [ natsukium ];
  };
}
