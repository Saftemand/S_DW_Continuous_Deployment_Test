
<script language="Javascript">

function __showContextMenu(ev, menu, nodes, nodeSrc)
{
//    if (nodes == null) return false;
	var evt = ev || window.event;	
	var Ex = evt.pageX || document.body.scrollLeft + evt.clientX;
	var Ey = evt.pageY || document.body.scrollTop + evt.clientY;	

	if (nodes!=null && nodes.length>0){
	    var src_id = (evt.srcElement) ? evt.srcElement.id : evt.target.id;	
        var re = new RegExp("\\D+","");
        var selectedNodeID = src_id.replace(re, "");
	    if (nodeSrc != null && nodeSrc.length > 0 ){
	        var elm = document.getElementById(nodeSrc);
	        if (elm!=null){
	            elm.value = selectedNodeID;
	        }
	    }
	    for (var i = 0; i < nodes.length; i++) {
	        if (selectedNodeID == nodes[i]){
	            ShowMenu(menu,Ex,Ey,evt);                
                return false;
            }            
        }
    }
    else{
        ShowMenu(menu,Ex,Ey,evt);
        return false;
    }
    return true;
}

function ShowMenu(menu,Ex,Ey,evt)
{
    var leftBorder = 25;
    var menuOffset = 2;
    if (Ex < leftBorder)
        menu.style.left = '25px';
    else
        menu.style.left = (Ex - menuOffset)+'px';
    menu.style.top = (Ey - menuOffset)+'px';	
    menu.style.display = "block";
    evt.cancelBubble = true;             
}

function __trapESC(ev,menu)
{
	var evt = (ev!=null)?ev:window.event;
	var key = evt.keyCode;
	if (key == 27)
	{
		menu.style.display = 'none';
	}
}

</script>
