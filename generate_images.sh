#!/bin/sh
version=$matplotlib_version
curl -L https://github.com/matplotlib/matplotlib/archive/refs/tags/v$version.tar.gz > matplotlib-$version.tar.gz
tar -xf matplotlib-$version.tar.gz
rm matplotlib-$version.tar.gz
cd ./matplotlib-$version
patch -p1 < ../outputAllImagesOnTestFailure.patch
sed -e 's|#system_freetype = False|system_freetype = True|' -e 's|#system_qhull = False|system_qhull = True|' mplsetup.cfg.template > mplsetup.cfg
sed -i 's|#tests = False|tests = True|' mplsetup.cfg
python3 -m build --wheel --no-isolation --skip-dependency-check
python3 -m installer dist/*.whl
job_count_prelim=$(nproc)
job_count=$((job_count_prelim<12 ? job_count_prelim : 12))
python3 -m pytest -n $job_count --pyargs matplotlib mpl_toolkits.tests
cd result_images
find . -name *expected* -exec rm -rf {} \;
find . -name *failed-diff* -exec rm -rf {} \;
find . -name "*\[*\]*" -exec rm -rf {} \;
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
mkdir ../../output/mpl_toolkits
mkdir ../../output/matplotlib
for mpl_toolkit_folder in $mpl_toolkits_folders
do
    mv ./$mpl_toolkit_folder ../../output/mpl_toolkits/$mpl_toolkit_folder
done
for directory in ./*
do
    mv $directory ../../output/matplotlib/$directory
done
