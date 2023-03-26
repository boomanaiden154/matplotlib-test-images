#!/bin/sh
set -e
version=$matplotlib_version
curl -L https://github.com/matplotlib/matplotlib/archive/refs/tags/v$version.tar.gz > matplotlib-$version.tar.gz
tar -xf matplotlib-$version.tar.gz
rm matplotlib-$version.tar.gz
cd ./matplotlib-$version
patch -p1 < ../outputAllImagesOnTestFailure.patch
sed -e 's|#system_freetype = False|system_freetype = True|' -e 's|#system_qhull = False|system_qhull = True|' mplsetup.cfg.template > mplsetup.cfg
sed -i 's|#tests = False|tests = True|' mplsetup.cfg
export SETUPTOOLS_SCM_PRETEND_VERSION=$version
gpep517 build-wheel \
	--wheel-dir dist \
	--output-fd 3 3>&1 >&2
python3 -m venv --clear --without-pip --system-site-packages test-env
test-env/bin/python3 -m installer dist/*.whl
job_count=$(nproc)
test-env/bin/python3 -m pytest -n $job_count --pyargs matplotlib || :
cd result_images
find . -name *expected* -exec rm -rf {} \;
find . -name *failed-diff* -exec rm -rf {} \;
find . -name "*\[*\]*" -exec rm -rf {} \;
mkdir ../../output
mkdir ../../output/matplotlib
for directory in ./*
do
    mv $directory ../../output/matplotlib/$directory
done
