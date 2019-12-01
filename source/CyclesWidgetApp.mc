using Toybox.Application as App;
using Toybox.WatchUi as Ui;
using Toybox.Attention;



class CyclesWidgetApp extends App.AppBase {

	var myView;
	var myInputDelegate;

    function initialize() {
        AppBase.initialize();
    }

    // onStart() is called on application start up
    function onStart(state) {
    }

    // onStop() is called when your application is exiting
    function onStop(state) {
    }

    // Return the initial view of your application here
    function getInitialView() {
    	myView = new CyclesWidgetView();
    	myInputDelegate = new MyInputDelegate();
    	
        return [ myView, myInputDelegate];
    }
    
     // New app settings have been received so trigger a UI update
    function onSettingsChanged() {
        CyclesWidgetView.requestUpdate();
        if(myView != null){
        	myView.handleSettingsChanged();
        }
    }
   
}


 class MyInputDelegate extends Ui.InputDelegate {
 
// 	var counterInter;
 	
//	function initialize() {
//		MenuInputDelegate.initialize();	       	       
//	}
    
    
    function onKey(event){    	
    	var key = event.getKey();
    	    	
        if(key == Ui.KEY_ESC){   
        	System.println("BACK1 "+startTime+", "+running+", "+childViewCreated);
        }
        
        if(key == Ui.KEY_ENTER){
        	System.println("ENTER "+running);  
        
        }
        
        return false;
    }
    
    
  function vibrate(){
  		if (Attention has :vibrate) {
	    	var vibeData =
			    [
			        new Attention.VibeProfile(20, 500) // On for two seconds			        
			    ];
			Attention.vibrate(vibeData);
		}
	}
}
