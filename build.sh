cd xray-16
mkdir bin
cd bin
cmake ..
/bin/sh -c "make -j$(nproc)"
echo "Project successfully built in $PWD"
