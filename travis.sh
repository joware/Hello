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

echo ====== Build Demo Project======
cd DemoTest
ant clean
ant emma debug
cd ..

echo ======= copy output apk ======
rm -rf output
mkdir output
cp Demo/bin/Demo-instrumented.apk output/Demo.apk
cp DemoTest/bin/DemoTest-debug.apk output/DemoTest.apk

	echo ======= install apk =====
	cd output
	adb uninstall com.oops.demo
	adb uninstall com.oops.demo.test
	adb install Demo.apk
	adb install DemoTest.apk
    cd ..


	echo ======== Run Unit test ========
	cd Demo

    adb shell am instrument -w -e reportDir /sdcard/ut/ -e reportFile UnitTestReport.xml -e coverage true -e coverageFile /sdcard/ut/coverage.ec com.oops.demo.test/com.zutubi.android.junitreport.JUnitReportTestRunner

    echo ========= get Report =========
    adb pull /sdcard/ut/UnitTestReport.xml
    adb pull /sdcard/ut/coverage.ec
    java -cp ${ANDROID_HOME}/tools/lib/emma.jar emma report -r xml -in bin/coverage.em -in coverage.ec  -sp ./src/
    java -cp ${ANDROID_HOME}/tools/lib/emma.jar emma report -r html -in bin/coverage.em -in coverage.ec  -sp ./src/
	cd ..





