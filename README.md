# Matplotlib Test Images

This repo contains Github actions that generate test images for matplotlib for various architectures with system freetype. Intended to be used in the Alpine Linux APKBUILD for matplotlib for testing purposes but might be useful in other places as well. Images can be downloaded from the published releases and overlayed into the matplotlib install. You can start by running the docker container.

# Bumping the matploblib version

Bumping the matplotlib version is not too hard. Simply bump the the `matplotlib_version` variable to the desired version under the `env` tag in `.github/workflows/main.yml`.
