#!/bin/sh
export ANDROID_TARGET=android-19

echo ================== Update projects ==================
echo ====== Update Demo ======
cd Demo
rm -rf ant.properties
rm -rf project.properties
android update project --name Demo --path . --target $ANDROID_TARGET
cd ..

echo ====== Update Demo Test project ======
cd DemoTest
rm -rf ant.properties
rm -rf project.properties
android update test-project -m ../Demo -p .
cd ..

echo ====== Build Demo & Test Project======
cd DemoTest
ant clean

ant emma debug
cd ..

echo ======= copy output apk ======
rm -rf output
mkdir output
cp Demo/bin/Demo-instrumented.apk output/Demo.apk
cp DemoTest/bin/DemoTest-debug.apk output/DemoTest.apk






