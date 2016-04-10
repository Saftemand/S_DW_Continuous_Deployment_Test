<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PreviewCombined.aspx.vb" Inherits="Dynamicweb.Admin.PreviewCombined" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Register TagPrefix="de" Namespace="Dynamicweb.Extensibility" Assembly="Dynamicweb" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title><dw:TranslateLabel ID="TranslateLabel1" runat="server" Text="Preview" /></title>
	<dw:ControlResources ID="ControlResources01" runat="server" IncludeUIStylesheet="true" IncludePrototype="true" />
    <link rel="StyleSheet" href="../Module/OMC/Experiments/Preview.css" type="text/css" />
    <script type="text/javascript" src="../Module/OMC/Experiments/Preview.js">
	</script>        
	<script type="text/javascript">
        //Change display size
	    function previewChangeSize() {
	        switch ($("prevSizeList").value) {
	            case "default":
	                window.resizeTo(screen.width, screen.height);
	                break;
	            case "desktop1":
	                window.resizeTo(1280, 1024);
	                break;
	            case "desktop2":
	                window.resizeTo(1024, 768);
	                break;
	            case "tablet1":
	                window.resizeTo(960, 540);
	                break;
	            case "tablet2":
	                window.resizeTo(768, 480);
	                break;
	            case "mobile":
	                window.resizeTo(480, 640);
	                break;
	        }
	    }

        //Select OMC view
	    function previewChangeOMC() {
	        var url;
	        var isDraft = $("isDraft");
	        var prevOMCList = $("prevOMCList");
	        var previewFrame = $("previewFrame");
	        
	        var draftUrl = ""
	        if (isDraft.value === "1") {
	            url = $("testurl").value + '&Preview=' + <%= PageID %>;
	        } else {
                url = $("testurl").value;
	        }

	        if (prevOMCList.value === "variants" && $("isOMC").value === "1") {
                previewFrame.src = url + '&variation=2';
	        } else if (prevOMCList.value === "original" && $("isOMC").value === "1") {
                previewFrame.src = url + '&variation=1';
            }
        }

        //Select Publish or Draft
	    function previewChangePubState() {
	        var variation = "none";
	        var isDraft = $("isDraft");
	        if ($("prevOMCList").value === "variants" && $("isOMC").value === "1") {
	            variation = "2"
	        } else if ($("prevOMCList").value === "original" && $("isOMC").value === "1") {
	            variation = "1"
	        }

	        switch ($("prevStateList").value) {
                case "published":
                    isDraft.value = "0";
                    $("previewFrame").src = $("testurl").value + "&variation=" + variation;
                    break;
                case "draft":
                    isDraft.value = "1";
                    var url = $("testurl").value + '&Preview=' + <%= PageID %> + "&variation=" + variation;
                    $("previewFrame").src = url;
                    break;
            }
	    }

	    //Change previewFrame size accroding to header height
	    function resizePreviewFrame() {
	        $("content").setStyle({
	            top: $("header").getHeight() + "px"
	        })
	    }

	    //Set default control sizes according to the longest control and window size
	    function setControlSize() {
	        window.resizeTo(screen.width, screen.height);

	        var temp;
	        var sections = $$(".section");
	        var previewDropDowns = $$(".previewDropDown");
	        var previewLabels = $$(".previewLabel");
	        var maxSection = 0;
	        var maxDropDown = 0;
	        var space = 0;
	        var minSpace = 0;
            
	        for (var i = 0; i < sections.length; ++i) {
	            if(previewDropDowns[i]){
	                temp = previewDropDowns[i].getWidth();
	                if (temp > maxDropDown) {
	                    maxDropDown = temp;
	                }
	            }
	        }

	        for (var i = 0; i < sections.length; ++i) {
	            if(previewDropDowns[i]){
	                previewDropDowns[i].setStyle({
	                    width: maxDropDown + "px"
	                })
	            }
	        }

	        for (var i = 0; i < sections.length; ++i) {
	            temp = sections[i].getWidth();
	            if (temp > maxSection) {
	                maxSection = temp;
	            }
	        }

	        for (var i = 0; i < sections.length; ++i) {
	            if(previewLabels[i]){
	                space = maxSection - previewLabels[i].getWidth() - maxDropDown;
	                if (space < 0) {
	                    space = 0;
	                }
	            }
	            if(previewDropDowns[i]){
	                previewDropDowns[i].setStyle({
	                    "margin-left": space + "px",
	                })
	            }
	        }
	    }	    
    </script>        

    <style type="text/css">        
        .DivCheckBoxList
        {
	        display:none;
	        background-color:White;
	        width:250px;
	        position:absolute;
	        height:200px;
	        overflow-y:auto; 
	        overflow-x:hidden;
	        border-style:solid;
	        border-color:Gray; 
	        border-width:1px;
            z-index:1000;
        }

        .CheckBoxList
        {
	        position:relative;
	        width:250px;
	        height:10px; 
	        overflow:scroll;
	        font-size:small;
        }
    </style>
    <script type="text/javascript">	        
        var timoutID;
        function ShowMList()
        {
            var divRef = document.getElementById("divCheckBoxList");
            if(divRef)
                divRef.style.display = "block";            
        }
    	
        function HideMList()
        {
            if(document.getElementById("divCheckBoxList"))
                document.getElementById("divCheckBoxList").style.display = "none";            
        }
	    
        function FindSelectedItems()
        {
            var cblstTable = document.getElementById("lstMultipleValues")
            var selectedValues = "";
            var selOrderId = "";
            if (cblstTable) {
                var textBoxID = "txtSelectedMLValues"            
                var checkBoxPrefix = cblstTable.id + "_";
                var noOfOptions = cblstTable.rows.length;
                var selectedText = "";
                
                for(i = 0; i < noOfOptions ; ++i)
                {
                    if(document.getElementById(checkBoxPrefix + i).checked)
                    {
                        var node = document.getElementById(checkBoxPrefix + i).parentNode;
                        if(node){
                            if(selectedText == ""){ 
                                if(node.lastChild){
                                    selectedText = node.lastChild.innerHTML;
                                }else{
                                    selectedText = node.innerHTML;
                                }                            
                                selectedValues = node.attributes["jsvalue"].value;
                            }else{
                                if(node.lastChild){
                                    selectedText = selectedText + "," + node.lastChild.innerHTML;
                                }else{
                                    selectedText = selectedText + "," + node.innerHTML;
                                }                            
                                selectedValues = selectedValues + "," + node.attributes["jsvalue"].value;
                            }
                        }
                    }
                }                
                if(document.getElementById(textBoxID))
                    document.getElementById(textBoxID).value = selectedText;
            }
            var previewOrder = document.getElementById("previewOrder")
            if (previewOrder) {
                selOrderId = previewOrder[previewOrder.selectedIndex].value;
            }
            var url;
            if (selectedValues.length > 0 || selOrderId.length > 0){
                url = "/Admin/Content/Previewcombined.aspx?PageID=" + <%=PageID%> + "&emailPrewiew=true&segmentID=" + selectedValues + "&orderID=" + selOrderId;
            }
            else{
                url = $("testurl").value;
            }
            document.getElementById("previewFrame").src = url;
        }
    </script>
</head>
<body onload="setControlSize(); resizePreviewFrame();">
    <script type="text/javascript">
        //Change previewFrame 'top' property on window resize
        window.onresize = resizePreviewFrame;
    </script>
	<form runat="server">
        <input type="hidden" id="testurl" value="<%=OriginalPage %>" />
        <input type="hidden" id="isDraft" value="" />
        <input type="hidden" runat="server" id="isOMC" value="" />
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>    
	    <div>
            <div id="header" style="height:auto; background-color: #EDF5FF;z-index:1000;" class="header">
                <div id="prevOMCdiv" runat="server" class="section">
                    <h1 runat="server" id="prevOMCHeader" class="previewLabel"></h1>
                    <asp:DropDownList CssClass="previewDropDown" runat="server" ID="prevOMCList" onchange="previewChangeOMC();"></asp:DropDownList>                    
                </div>
                <div id="prevProfileDiv" runat="server" class="section">
		            <h1 runat="server" id="prevProfile" class="previewLabel"><%= Dynamicweb.Backend.Translate.Translate("Preview for profile") & ": "%></h1>
                    <select class="previewDropDown" id="profilesList" runat="server" onchange="previewProfileTest();" ></select>
                </div>
                <div id="prevSegmentDiv" runat="server" class="section">
		            <h1 class="previewLabel"><%= Dynamicweb.Backend.Translate.Translate("Preview segment") & ": "%></h1>                    
                    <div class="section" style="vertical-align:middle;">
                        <asp:UpdatePanel runat="server">
                            <ContentTemplate>                     
                                <div runat="server" onmouseover="clearTimeout(timoutID);" onmouseout="timoutID = setTimeout('HideMList()', 750);">
                                    <table>
                                        <tr>
                                            <td align="right">
                                                <input id="txtSelectedMLValues" type="text" readonly="readonly" onclick="ShowMList()" style="width:229px;" runat="server" />
                                            </td>
                                            <td align="left">
                                                <img runat="server" alt="" src="/Admin/Images/Icons/DownArrow.gif" onclick="ShowMList()" align="left" />                
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2">
                                                <div>            	                            
                                                    <div runat="server" id="divCheckBoxList" class="DivCheckBoxList">
		                                                <asp:CheckBoxList ID="lstMultipleValues" runat="server" Width="250px" CssClass="CheckBoxList"></asp:CheckBoxList>						        			           			        
		                                            </div>
		                                        </div>
                                            </td>
                                        </tr>
                                    </table>
                                </div>                        
                            </ContentTemplate>
                        </asp:UpdatePanel>   
                    </div>
                </div>                               

                 <div class="section">
		            <h1 runat="server" id="prevSize" class="previewLabel"><%= Dynamicweb.Backend.Translate.Translate("Select preview size") & ": " %></h1>
                    <asp:DropDownList CssClass="previewDropDown" runat="server" ID="prevSizeList" onchange="previewChangeSize();"></asp:DropDownList>
                </div>
                <div id="prevPubStateDiv" runat="server" class="section">
		            <h1 runat="server" id="H1" class="previewLabel"><%= Dynamicweb.Backend.Translate.Translate("Publish state") & ": " %></h1>
                    <asp:DropDownList CssClass="previewDropDown" runat="server" ID="prevStateList" onchange="previewChangePubState();"></asp:DropDownList>
                </div>
                <div id="previewOrderDiv" runat="server" class="section" visible="false">
		            <h1 class="previewLabel"><%= Dynamicweb.Backend.Translate.Translate("Select order or cart") & ": "%></h1>
                    <asp:DropDownList CssClass="previewDropDown" runat="server" ID="previewOrder" onchange="FindSelectedItems(event)"></asp:DropDownList>
                </div>
            </div>
	        <div id="content" style="position:fixed;bottom:0px;right:0px;left:0px;">
		        <iframe id="previewFrame" src="<%=OriginalPage%>" style="border:0;width:100%;height:100%;"></iframe>
	        </div>
        </div>        
    </form>
</body>
<%Dynamicweb.Backend.Translate.GetEditOnlineScript()
    %>
</html>

