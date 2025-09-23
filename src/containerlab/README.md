
# Containerlab (containerlab)

Setup Containerlab in a devcontainer

## Example Usage

```json
"features": {
    "ghcr.io/evilhamsterman/containerlab-devcontainer-features/containerlab:1": {}
}
```

## Options

| Options Id | Description | Type | Default Value |
|-----|-----|-----|-----|
| version | Set the version of containerlab to install. Default: latest | string | latest |

## Customizations

### VS Code Extensions

- `srl-labs.vscode-containerlab`
- `redhat.vscode-yaml`

# Containerlab Devcontainer Feature

Installs `containerlab` in a devcontainer.

# Requirements

* Docker: We recommend either the [Docker-in-Docker Feature](https://github.com/devcontainers/features/tree/main/src/docker-in-docker) or the [Docker-outside-of-Docker Feature](https://github.com/devcontainers/features/tree/main/src/docker-outside-of-docker)


---

_Note: This file was auto-generated from the [devcontainer-feature.json](https://github.com/evilhamsterman/containerlab-devcontainer-features/blob/main/src/containerlab/devcontainer-feature.json).  Add additional notes to a `NOTES.md`._
