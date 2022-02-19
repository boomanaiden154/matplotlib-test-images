#!/bin/sh
version=3.5.1
curl -L https://github.com/matplotlib/matplotlib/archive/refs/tags/v$version.tar.gz > matplotlib-$version.tar.gz
tar -xf matplotlib-$version.tar.gz
rm matplotlib-$version.tar.gz
cd ./matplotlib-$version
sed -e 's|#system_freetype = False|system_freetype = True|' -e 's|#system_qhull = False|system_qhull = True|' mplsetup.cfg.template > mplsetup.cfg
sed -i 's|#tests = False|tests = True|' mplsetup.cfg
python3 setup.py build
python3 setup.py install --skip-build
python3 -m pytest -n $(nproc) --pyargs matplotlib mpl_toolkits.tests
cd result_images
find . -name *expected* -exec rm -rf {} \;
mpl_toolkits_folders="test_axes_grid
    test_axes_grid1
    test_axisartist_axis_artist
    test_axisartist_axislines
    test_axisartist_clip_path
    test_axisartist_floating_axes
    test_axisartist_grid_helper_curvelinear
    test_mplot3d
    "
mkdir ../../output
mkdir ../../output/mpl_toolkits-x86_64
mkdir ../../output/matplotlib-x86_64
for mpl_toolkit_folder in $mpl_toolkits_folders
do
    mv ./$mpl_toolkit_folder ../../output/mpl_toolkits-x86_64/$mpl_toolkit_folder
done
for directory in ./*
do
    mv ./$directory ../../output/matplotlib-x86_64/$directory
done
