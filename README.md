# Custom kube-prometheus

This repository is intended to be a simple implementation using [kube-prometheus](https://github.com/coreos/kube-prometheus#customizing-kube-prometheus) to customize [prometheus-operator](https://github.com/helm/charts/tree/master/stable/prometheus-operator#prometheus-operator) default chart manifests. 

- [Installation](README.md#installation)
    - [Prerequisites](README.md#prerequisites)
- [Local Development](README.md#local-development)
    - [Manifests](README.md#manifests)
    - [Dependencies](README.md#dependencies)

## [Installation](#installation)
-----

### [Prerequisites](#prerequisites)

- [Golang](https://github.com/golang/go)
- [Jsonnet](https://github.com/google/jsonnet)
- [jsonnet-bundler](https://github.com/jsonnet-bundler/jsonnet-bundler)
- [gojsontoyaml](https://github.com/brancz/gojsontoyaml)

If you already have Golang installed but none of the requirements, you can use these built-in helper commands to install dependencies:
```bash
make install-jsonnet
make install-jsonnetbundler
make install-gojsontoyaml
```

<br>


## [Local Development](#local-development)

-----

## [Manifests](#manifests)

- Generate new manifests after changing your input file. This process takes around 10s to finish.
```bash
make FILENAME=main.jsonnet MANIFESTS_FOLDER=manifests
```

## [Dependencies](#dependencies)

- Update jsonnet-bundler dependencies
```bash
make update
```