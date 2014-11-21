#!/bin/sh
export ANDROID_TARGET=android-19

echo ================== Update projects ==================

echo ====== Update Demo ======
pushd Demo
rm -rf ant.properties
rm -rf project.properties
android update project --name Demo --path . --target $ANDROID_TARGET
popd

echo ====== Update Demo Test project ======
pushd DemoTest
rm -rf ant.properties
rm -rf project.properties
android update test-project -m ../Demo -p .
popd

echo ====== Build Demo & Test Project======
pushd DemoTest
ant clean

ant emma debug
popd

echo ======= copy output apk ======
rm -rf output
mkdir output
cp Demo/bin/Demo-instrumented.apk output/Demo.apk
cp DemoTest/bin/DemoTest-debug.apk output/DemoTest.apk






