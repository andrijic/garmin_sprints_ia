using Toybox.WatchUi as Ui;
using Toybox.Timer as Timer;
using Toybox.Time as Time;
using Toybox.Graphics as Gfx;
using Toybox.Time.Gregorian; 
using Toybox.Application;
using Toybox.Math;
using Toybox.System;
using Toybox.Time.Gregorian;

var startTime = 0;
var pausedTime = 0;
var delta = 0;
var running = false;

var timer1 = null;
var childViewCreated = false;

class CyclesWidgetView extends Ui.View {

	var PREFIX;
	var SUFIX;
	var LABEL;
	var PERIOD_DURATION;
	var OFFSET_DAYS;

	function secondPassedEvent(){
		Ui.requestUpdate();
	}

    function initialize() {
        View.initialize();
        restorePersistedSettings();
    }

    // Load your resources here
    function onLayout(dc) {
        setLayout(Rez.Layouts.MainLayout(dc));
        View.onUpdate(dc);
		
		if(childViewCreated == false){
		      System.println("new view 0"); 
		      childViewCreated = true;   
		      Ui.pushView(new CyclesWidgetView(), new MyInputDelegate(), Ui.SLIDE_IMMEDIATE);
		}	
        
        onUpdate(dc); 
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
    }
    
    
    
    // Update the view
    function onUpdate(dc) {
        
        dc.setColor(Gfx.COLOR_DK_RED, Gfx.COLOR_WHITE  );
        dc.clear();
        dc.setColor(Gfx.COLOR_DK_RED, Gfx.COLOR_TRANSPARENT);
        
        //draw top label
        dc.drawText( dc.getWidth()/2,  40, Gfx.FONT_LARGE, LABEL, Gfx.TEXT_JUSTIFY_CENTER);

     	dc.drawLine(0, 80, dc.getWidth(), 80);
//     	System.println(getDayOfYear() );
		var sprintValue = Math.floor((getDayOfYear() - OFFSET_DAYS) / PERIOD_DURATION);
		
		//draw sprint value
		var rezult = PREFIX + sprintValue + SUFIX;
		dc.setColor(Gfx.COLOR_DK_RED, Gfx.COLOR_TRANSPARENT);
        dc.drawText( dc.getWidth()/2, (dc.getHeight() / 2) - 20, Gfx.FONT_MEDIUM, rezult, Gfx.TEXT_JUSTIFY_CENTER );
        
        //draw ramining days
        var current = getDayOfYear() - sprintValue * PERIOD_DURATION + 1;
//        var remains = (sprintValue + 1) * PERIOD_DURATION - getDayOfYear();
         dc.drawText( dc.getWidth()/2, (dc.getHeight() / 2) +10, Gfx.FONT_MEDIUM, "Day:" + current + "/" + PERIOD_DURATION, Gfx.TEXT_JUSTIFY_CENTER );
        
        //draw week number
         dc.drawText( dc.getWidth()/2, (dc.getHeight() / 2) +40, Gfx.FONT_MEDIUM, "W"+getWeekOfYear(), Gfx.TEXT_JUSTIFY_CENTER );
        
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    	
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
  

}
