
// Checks the browser and adds classes to the body to reflect it.
// Adapted from: http://www.tvidesign.co.uk/blog/CSS-Browser-detection-using-jQuery-instead-of-hacks.aspx

$(document).ready(function(){
    
    var userAgent = navigator.userAgent.toLowerCase();
    $.browser.chrome = /chrome/.test(navigator.userAgent.toLowerCase()); 
    
    // Is this a version of IE?
    if($.browser.msie){
        $('html').addClass('browserIE');
        
        // Add the version number
        $('html').addClass('browserIE' + $.browser.version.substring(0,1));
    }
    
    
    // Is this a version of Chrome?
    if($.browser.chrome){
    
        $('html').addClass('browserChrome');
        
        //Add the version number
        userAgent = userAgent.substring(userAgent.indexOf('chrome/') +7);
        userAgent = userAgent.substring(0,1);
        $('html').addClass('browserChrome' + userAgent);
        
        // If it is chrome then jQuery thinks it's safari so we have to tell it it isn't
        $.browser.safari = false;
    }
    
    // Is this a version of Safari?
    if($.browser.safari){
        $('html').addClass('browserSafari');
        
        // Add the version number
        userAgent = userAgent.substring(userAgent.indexOf('version/') +8);
        userAgent = userAgent.substring(0,1);
        $('html').addClass('browserSafari' + userAgent);
    }
    
    // Is this a version of Mozilla?
    if($.browser.mozilla){
        
        //Is it Firefox?
        if(navigator.userAgent.toLowerCase().indexOf('firefox') != -1){
            $('html').addClass('browserFirefox');
            
            // Add the version number
            userAgent = userAgent.substring(userAgent.indexOf('firefox/') +8);
            userAgent = userAgent.substring(0,1);
            $('html').addClass('browserFirefox' + userAgent);
        }
        // If not then it must be another Mozilla
        else{
            $('html').addClass('browserMozilla');
        }
    }
    
    // Is this a version of Opera?
    if($.browser.opera){
        $('html').addClass('browserOpera');
    }
    
    
});