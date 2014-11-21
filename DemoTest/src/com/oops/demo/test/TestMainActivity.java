package com.oops.demo.test;

import com.oops.demo.MainActivity;

import android.app.Activity;
import android.test.ActivityInstrumentationTestCase2;

public class TestMainActivity extends ActivityInstrumentationTestCase2<MainActivity> {

	private Activity mainActivity;
	
	public TestMainActivity(Class<MainActivity> activityClass) {
		super(activityClass);
	}
	
	public TestMainActivity() {
		super(MainActivity.class);
	}
	
	@Override
	protected void setUp() throws Exception {
		super.setUp();
		mainActivity = getActivity();
	}
	
	@Override
	protected void tearDown() throws Exception {
		super.tearDown();
	}
	
	public void testCondition() {
		assertNotNull(mainActivity);
	}

}
