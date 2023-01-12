#!/bin/sh
set -e
# deps from the APKBUILD
apk add py3-cairo \
	py3-certifi \
	py3-contourpy \
	py3-cycler \
	py3-dateutil \
	py3-fonttools \
	py3-kiwisolver \
	py3-numpy \
	py3-packaging \
	py3-parsing \
	py3-pillow \
	py3-tz \
	python3-tkinter \
	freetype-dev \
	gfortran \
	libpng-dev \
	py3-gpep517 \
	py3-numpy-dev \
	py3-setuptools \
	py3-setuptools_scm \
	py3-wheel \
	python3-dev \
	qhull-dev \
	tk-dev \
	font-opensans \
	py3-pytest \
	py3-pytest-xdist
# other (normally) preinstalled build deps
apk add alpine-sdk
