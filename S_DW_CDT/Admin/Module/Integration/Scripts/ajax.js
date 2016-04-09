  var pendingrequests = 0;
  
  function Pipelinetrafic() {
    var value = "<img src=/admin/Module/Integration/Images/trafficlight_green.png border=0>"
    if (pendingrequests != 0) {
        // Hide/Dim save button
        value = "<img src=/admin/Module/Integration/Images/trafficlight_red.png border=0>"
    }

    return value;
  }
  
  
  function UpdateDesigner(params)
  {
    pendingrequests++;
    document.getElementById('SpanHolder').innerHTML = Pipelinetrafic();

    params = (params) ? "?"+ params : "";
    
    var url = '/admin/Module/Integration/DesignerUpdate.aspx' + params;
  
    new Ajax.Request(url,   
    {
        method:'get',     
        
        onSuccess: function(transport)
        {   
	        pendingrequests--;        
	        document.getElementById('SpanHolder').innerHTML = Pipelinetrafic();
            
            var response = transport.responseText || "no response text";
  	        document.getElementById('PipelineDesigner').innerHTML = response;
  	        document.getElementById('PipelineDesigner').focus();
	        window.setTimeout("ResetDropZones();",100);
        },             
        onFailure: function()
        {
          alert('Something went wrong... 1') }   
        }
    ); 
    
  }		
		

  function UpdateToolbox()
  {
    pendingrequests++;
    document.getElementById('SpanHolder').innerHTML = Pipelinetrafic();

    var url = '/admin/Module/Integration/DesignerUpdate.aspx?action=toolbox';

    new Ajax.Request(url,   
    {
        method:'get',     
        
        onSuccess: function(transport)
        {   
	        pendingrequests--;        
	        document.getElementById('SpanHolder').innerHTML = Pipelinetrafic();
            
            var response = transport.responseText || "no response text";
  	        document.getElementById('DesignerToolbox').innerHTML = response;
  	        document.getElementById('DesignerToolbox').focus();
	        //window.setTimeout("ResetDropZones();",100);
        },             
        onFailure: function()
        {
          alert('Something went wrong... 2') }   
        }
    ); 
    
  }		

  function UpdateProperties(activity)
  {
    pendingrequests++;
    document.getElementById('pending').innerHTML = pendingrequests;

    var url = '/admin/Module/Integration/DesignerUpdate.aspx?action=properties&activity='+activity

    new Ajax.Request(url,   
    {
        method:'get',     
        
        onSuccess: function(transport)
        {   
	        pendingrequests--;        
	        document.getElementById('SpanHolder').innerHTML = Pipelinetrafic();
            
            var response = transport.responseText || "no response text";
            //document.getElementById('DesignerProperties').innerHTML = response;
  	        document.getElementById('DesignerProperties').innerHTML = "adas";
  	        document.getElementById('DesignerProperties').focus();
        },             
        onFailure: function()
        {
          alert('Something went wrong... 3') }   
        }
    ); 
    
  }		
		
      
      
Rico.CustomDropzone = Class.create();

Rico.CustomDropzone.prototype = {

   initialize: function( htmlElement ) {
      this.htmlElement  = $(htmlElement);
      this.absoluteRect = null;
   },

   getHTMLElement: function() {
      return this.htmlElement;
   },

   clearPositionCache: function() {
      this.absoluteRect = null;
   },

   getAbsoluteRect: function() {
      if ( this.absoluteRect == null ) {
         var htmlElement = this.getHTMLElement();
         var pos = RicoUtil.toViewportPosition(htmlElement);

         this.absoluteRect = {
            top:    pos.y,
            left:   pos.x,
            bottom: pos.y + htmlElement.offsetHeight,
            right:  pos.x + htmlElement.offsetWidth
         };
      }
      return this.absoluteRect;
   },

   activate: function() {
      var htmlElement = this.getHTMLElement();
      if (htmlElement == null  || this.showingActive)
         return;
    htmlElement.className = 'arrow3';
      this.showingActive = true;
      this.saveBackgroundColor = htmlElement.style.backgroundColor;

      var fallbackColor = "#ffea84";
      var currentColor = Rico.Color.createColorFromBackground(htmlElement);
//      if ( currentColor == null )
//         htmlElement.style.backgroundColor = fallbackColor;
//      else {
//         //currentColor.isBright() ? currentColor.darken(0.2) : currentColor.brighten(0.2);
//         //htmlElement.style.backgroundColor = currentColor.asHex();
//      }
   },

   deactivate: function() {
   
      var htmlElement = this.getHTMLElement();
      if (htmlElement == null || !this.showingActive) return;
      htmlElement.className = 'arrow';
      htmlElement.style.backgroundColor = this.saveBackgroundColor;
      this.showingActive = false;
      this.saveBackgroundColor = null;
   },

   showHover: function() {
      var htmlElement = this.getHTMLElement();
      if ( htmlElement == null || this.showingHover )
         return;

        htmlElement.className = 'arrow4';
      this.saveBorderWidth = htmlElement.style.borderWidth;
      this.saveBorderStyle = htmlElement.style.borderStyle;
      this.saveBorderColor = htmlElement.style.borderColor;

      this.showingHover = true;
      //htmlElement.style.borderWidth = "1px";
      //htmlElement.style.borderStyle = "solid";
      //htmlElement.style.borderColor = "#ff9900";
      //htmlElement.style.borderColor = "#ffff00";
   },

   hideHover: function() {
      var htmlElement = this.getHTMLElement();
      if ( htmlElement == null || !this.showingHover )
         return;

      htmlElement.className = 'arrow3';
      htmlElement.style.borderWidth = this.saveBorderWidth;
      htmlElement.style.borderStyle = this.saveBorderStyle;
      htmlElement.style.borderColor = this.saveBorderColor;
      this.showingHover = false;
   },

   canAccept: function(draggableObjects) {
      // CONSTRAINS CHECK
      var returnValue = false; // default false
      
      var DropObject = this.getHTMLElement();
      var DragObject = draggableObjects[0].getDroppedGUI();
      
      var input = DragObject.getAttribute('inputformat');
      var output = DragObject.getAttribute('outputformat');

      var firstPosition = false;
      var lastPosition = false;
      
      var prevOutput = "";
      var prevObjtype = "";
      var prevObj = DropObject.previousSibling;
      if (prevObj) {
        prevOutput = prevObj.getAttribute("outputformat");

        obj = prevObj.getElementsByTagName("TABLE");
        if (obj.length > 0) {
            prevOutput = obj[0].getAttribute("outputformat");    
        }
      } else {
        prevOutput = null;
        firstPosition = true;
      }

      var nextInput = "";
      var nextObj = DropObject.nextSibling;
      if (nextObj) {
        nextInput = nextObj.getAttribute("inputformat");

        obj = nextObj.getElementsByTagName("TABLE");
        if (obj.length > 0) {
            nextInput = obj[0].getAttribute("inputformat");    
        }
      } else {
        nextInput = null;
      }
      
      if (firstPosition == false && prevOutput == "*" && input != "" || firstPosition == false && prevOutput != "" && input == "*" || firstPosition == false && prevOutput == input && input != "" && prevOutput != "") {
        returnValue = true;
      } else if (firstPosition && input == "") {
        returnValue = true;
      } 
      
      return returnValue;
   },

   accept: function(draggableObjects) {
     try
     {
        var DropObject = this.getHTMLElement();
        var DragObject = draggableObjects[0].getDroppedGUI();
        
        if (DropObject && DragObject) 
        {
            qs = "";
            qs += "action=" + DragObject.getAttribute('dragaction');
            qs += "&";
            qs += "sequence=" + DropObject.getAttribute('sequence');
            qs += "&";
            qs += "activity=" + DragObject.getAttribute('id');
            qs += "&";
            qs += "activity-type=" + DragObject.getAttribute('activitytype')
            qs += "&";
            qs += "activity-before=" + DropObject.getAttribute('activity-before');
            qs += "&"
            qs += "activity-after=" + DropObject.getAttribute('activity-after');
            
            UpdateDesigner(qs);
            
        }
     }
     catch (e)
     {
     }
   }
   
}   
   
   
var CustomDraggable = Class.create();

CustomDraggable.prototype = (new Rico.Draggable()).extend( {

   initialize: function( type, htmlElement ) {
      this.type          = type;
      this.htmlElement   = $(htmlElement);
      this.selected      = false;
   },

   /**
    *   Returns the HTML element that should have a mouse down event
    *   added to it in order to initiate a drag operation
    *
    **/
   getMouseDownHTMLElement: function() {
      return this.htmlElement;
   },

   select: function() {
      this.selected = true;
      if ( this.showingSelected ) return;
      this.showingSelected = true;
   },

   deselect: function() {
      this.selected = false;
      if ( !this.showingSelected ) return;

      //var htmlElement = this.getMouseDownHTMLElement();
//htmlElement.style.position = 'relative';
      //htmlElement.style.backgroundColor = this.saveBackground;
      this.showingSelected = false;
   },

   isSelected: function() {
      return this.selected;
   },

   startDrag: function() {
   },

   cancelDrag: function() {
       if (pendingrequests < 1) UpdateDesigner("");
       htmlElement.style.backgroundColor = this.saveBackground;
   },

   endDrag: function() {
    htmlElement.style.backgroundColor = this.saveBackground;
   },

   getSingleObjectDragGUI: function() {
        var oDiv=document.createElement("DIV");
        oDiv.className = 'activity-drag';
        oDiv.innerHTML = this.htmlElement.outerHTML;
        document.body.appendChild(oDiv);
        
        

      //return this.htmlElement;
      return oDiv;
   },

   getMultiObjectDragGUI: function( draggables ) {
      return this.htmlElement;
   },

   getDroppedGUI: function() {
      return this.htmlElement;
   },

   toString: function() {
      return this.type + ":" + this.htmlElement + ":";
   }
   

} );
   
   
   function DesignerSelectActivity(activityId)
   {
     UpdateDesigner("action=select&activity="+activityId);
   }
   
   function PopupProperties(activityId)
   {
     page = "/admin/Module/Integration/DesignerProperties.aspx?activity=" + activityId;
     wleft = 400;
     wtop = 300;
     wwidth = 500;
     wheight = 400;
     var returnvalue = window.open(page,"Properties","displayWindow,left="+wleft+",top="+wtop+",screenX="+wleft+",screenY="+wtop+",width="+wwidth+",height="+wheight+",scrollbars=no");
   }
   

  function ResetDropZones()
  {
    // Clear existing dropzones
    dndMgr.clearDropZones();
    dndMgr.draggables = null;
    dndMgr.draggables = new Array();
    
    // Find all <div> with dragable or dropzone attribute and set their d&d behaviour
    var xx = null;
    var xx = document.getElementsByTagName("div");
    for (i=0; i<xx.length; i++)
    {
      if (xx[i].getAttribute('dragable') == 'true')
      {
        dndMgr.registerDraggable(new CustomDraggable(xx[i].getAttribute('id'),xx[i].getAttribute('id')));
      }
      if (xx[i].getAttribute('dropzone') == 'true')
      {
        dndMgr.registerDropZone( new Rico.CustomDropzone(xx[i]))
      }
    }
    
    // Find all <table> with dragable or dropzone attribute and their d&d behaviour
    var xx = document.getElementsByTagName("table");
    for (i=0; i<xx.length; i++)
    {
      if (xx[i].getAttribute('dragable') == 'true')
      {
        dndMgr.registerDraggable(new CustomDraggable(xx[i].getAttribute('id'),xx[i].getAttribute('id')));
      }
    }
  }  
  
  function SavePipeline(fname, showPrompt)
  {
    if (showPrompt)
    {
      X = prompt("Save File As",fname);
      if (X != null) 
      {
        FileName = X;
        UpdateDesigner("action=saveas&filename="+FileName);
      }
    }
    else
    {
        UpdateDesigner("action=save&filename="+FileName);
    }
  }

  function LoadPipeline(filename)
  {
    if (filename == "")
    {
      FileName = prompt("Open",FileName);
    }
    UpdateDesigner("action=load&filename="+FileName);
  }

  function NewPipeline()
  {
    FileName = "";
    UpdateDesigner("action=new");
  }


  function DeleteActivity()
  {
    UpdateDesigner("action=delete");
  }

  function KeyHandler(e)
  {
      var keynum;
      var keychar;
      var numcheck;
      
      if (window.event)
      {
        keynum = e.keyCode
      }
      else if (e.which)
      {
        keynum = e.which
      }
     
      if (keynum == 46)
      {
        DeleteActivity();
      }
      
      return true;
  }
  

//*************************
// Tip box
//*************************  
function toolboxitem(element, type) {
    if (type == "hover") {
	    element.className = "toolboxitem_hover";
	} else if (type == "default") {    
	    element.className = "toolboxitem_default";
	}    
}
  

//*************************
// Tip box
//*************************
var tipElem;
var tipBubble;
var tipEnable = false;

function ActivityTip(evt, tipText, tipWidth, tipColor) {
    if (typeof tipText != "undefined" && tipText != "") {
        tipElem = document.getElementById("activityTipElement");
        tipBubble = document.getElementById("activityTipElementBaloon");
    
        if (typeof tipWidth != "undefined" && tipWidth != "") {
            tipElem.style.width = tipWidth + "px";
        }    
        if (typeof tipColor != "undefined" && tipColor != "") {
            tipElem.style.backgroundColor = tipColor;
        }            
    
        tipElem.innerHTML = tipText;
    
        tipEnable = true;
        ShowActivityTip(evt);
    }    
    
    return false;
}

function ietruebody(){
    return (document.compatMode && document.compatMode!="BackCompat")? document.documentElement : document.body;
}

function ShowActivityTip(evt) {

    // crossbrowser-thingie-magickie to get the event
    var e = (window.event) ? window.event : evt;
    
    if (tipEnable) {
        var nondefaultpos = false;
        var offsetfromcursorX=12; 
        var offsetfromcursorY=10; 
        var offsetdivfrompointerX=10; 
        var offsetdivfrompointerY=14;   
             
        var curX = e.clientX + ietruebody().scrollLeft;
        var curY = e.clientY + ietruebody().scrollTop;
            
        var winwidth = ietruebody().clientWidth; // window.innerWidth-20
        var winheight = ietruebody().clientHeight; // window.innerHeight-20

        var rightedge = winwidth - e.clientX-offsetfromcursorX; // winwidth-evt.clientX-offsetfromcursorX
        var bottomedge = winheight - e.clientY-offsetfromcursorY; // winheight-evt.clientY-offsetfromcursorY

        var leftedge = (offsetfromcursorX < 0) ? offsetfromcursorX*(-1) : -1000;

        if (rightedge < tipElem.offsetWidth) {
            tipElem.style.left = curX - tipElem.offsetWidth + "px";
            nondefaultpos = true;
        } else if (curX < leftedge) {
            tipElem.style.left = "5px";
        } else {
            tipElem.style.left = curX + offsetfromcursorX - offsetdivfrompointerX + "px";
            tipBubble.style.left = curX + offsetfromcursorX + "px";
        }

        if (bottomedge < tipElem.offsetHeight) {
            tipElem.style.top = curY - tipElem.offsetHeight - offsetfromcursorY + "px";
            nondefaultpos=true;
        } else {
            tipElem.style.top = curY + offsetfromcursorY + offsetdivfrompointerY + "px";
            tipBubble.style.top = curY + offsetfromcursorY + "px";
        }

        tipElem.style.visibility = "visible";
        tipElem.style.display = "block";
        
        if (!nondefaultpos) {
            tipBubble.style.visibility = "visible";
            tipBubble.style.display = "block";
        } else {
            tipBubble.style.visibility = "hidden";
            tipBubble.style.display = "none";
        }
    }        
}

function HideActivityTip(){
    if (tipEnable) {
        tipEnable = false;
    
        tipElem.style.visibility = "hidden";
        tipElem.style.display = "none";
    
        tipBubble.style.visibility = "hidden";
        tipBubble.style.display = "none";
    
        tipElem.style.left = "-1000px";
        tipElem.style.backgroundColor = '';
        tipElem.style.width = '';
    }        
}

function DisableMenuButtons(){
    DisableMenuButton("PipeBut_Delete");
}

function DisableMenuButton(buttonName) {
    var elem = document.getElementById(buttonName);
    if (elem) {
	    document.getElementById(buttonName).style.filter = "progid:DXImageTransform.Microsoft.Alpha(opacity=30);progid:DXImageTransform.Microsoft.BasicImage(grayscale=1);-moz-opacity: 0.4;";
        document.getElementById(buttonName).onclick = "void();";
	    document.getElementById(buttonName).removeAttribute("href");
	    document.getElementById(buttonName).removeAttribute("onClick");
	    document.getElementById(buttonName).style.cursor = "default";
    }
}