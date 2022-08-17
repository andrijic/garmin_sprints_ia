using Toybox.WatchUi as Ui;
using Toybox.Timer as Timer;
using Toybox.Time as Time;
using Toybox.Graphics as Gfx;
using Toybox.Time.Gregorian; 
using Toybox.Application;
using Toybox.Math;
using Toybox.System;
using Toybox.Time.Gregorian;

(:glance)
class CyclesGlanceView extends Ui.GlanceView {

	var PREFIX;
	var SUFIX;
	var LABEL;
	var PERIOD_DURATION;
	var OFFSET_DAYS;

	function secondPassedEvent(){
		Ui.requestUpdate();
	}

    function initialize() {
        GlanceView.initialize();
        restorePersistedSettings();
    }

    
    
    // Update the view
    function onUpdate(dc) {
        
        dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_WHITE  );
        //dc.drawRectangle(0, 0, dc.getWidth(), dc.getHeight());
    	 
		var sprintValue = Math.floor((getDayOfYear() - OFFSET_DAYS) / PERIOD_DURATION);
		//var sprintValue = "S333-3-3-3";
		
		 //draw ramining days
        var current = (getDayOfYear() - OFFSET_DAYS) - sprintValue * PERIOD_DURATION + 1;
		
		//draw sprint value
		var rezult = PREFIX + sprintValue + SUFIX+" "+current+"/"+PERIOD_DURATION;
		dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
        dc.drawText( 0, dc.getHeight()/2 - 20, Gfx.FONT_SMALL, rezult, Gfx.TEXT_JUSTIFY_LEFT );
        
        
    }

    
   function handleSettingsChanged(){
   
   		PREFIX = Application.getApp().getProperty("Prefix");
		SUFIX = Application.getApp().getProperty("Sufix");
		LABEL = Application.getApp().getProperty("TopLabel");
		PERIOD_DURATION = Application.getApp().getProperty("PeriodDuration");
		OFFSET_DAYS = Application.getApp().getProperty("OffsetDays");
		
		//persist change properties
		var app = Application.getApp();
    	
    	app.setProperty("Prefix", PREFIX);    	
    	app.setProperty("Sufix", SUFIX);
    	app.setProperty("TopLabel", LABEL);
    	app.setProperty("PeriodDuration", PERIOD_DURATION);
    	app.setProperty("OffsetDays", OFFSET_DAYS);
    	    	
    	app.saveProperties();
	}
	
	function restorePersistedSettings(){
    	//persist change properties
		var app = Application.getApp();
		
		PREFIX = getValidProperty(app, "Prefix", "S");
		SUFIX = getValidProperty(app, "Sufix", ".2019");
		LABEL = getValidProperty(app, "TopLabel", "Televend");
		PERIOD_DURATION = getValidProperty(app, "PeriodDuration", 14);
		OFFSET_DAYS = getValidProperty(app, "OffsetDays", 0);
    }
   
     function getValidProperty(app, param_name, default_value){
    	var input_value = app.getProperty(param_name);
    	
    	if(input_value == null){
    		return default_value;
    	}else{
    		return input_value;
    	}
    }
  
	function getDayOfYear() {
    	var date = Time.now();
     	var info = Gregorian.info(date, Time.FORMAT_LONG);
     	
    	var options = {
		    :year   => info.year,
		    :month  => 1,
		    :day    => 1,
		    :hour   => 0
		};
		
		var start_of_year = Gregorian.moment(options);

		var day_of_year = date.subtract(start_of_year);
		day_of_year = day_of_year.value() / Gregorian.SECONDS_PER_DAY + 1;
		
		return day_of_year;
    }
    
     function getWeekOfYear(){
     	return getDayOfYear()/7 + 1;
     }
}
