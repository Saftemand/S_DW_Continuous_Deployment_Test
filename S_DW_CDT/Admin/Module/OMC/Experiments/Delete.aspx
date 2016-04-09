<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Delete.aspx.vb" Inherits="Dynamicweb.Admin.Delete1" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Register TagPrefix="de" Namespace="Dynamicweb.Extensibility" Assembly="Dynamicweb" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<dw:ControlResources ID="ControlResources1" runat="server" IncludeUIStylesheet="true" IncludePrototype="false"/>
    <title></title>
	<link rel="StyleSheet" href="Setup.css" type="text/css" />
	<script type="text/javascript">

        function deleteExperiment() {
            var o = new overlay('forward');
	        o.show();
			if (!document.getElementById("deleteConfirm").checked) {
			    alert('<%= Dynamicweb.Backend.Translate.Translate("Please confirm to delete this split test.")%>');
                o.hide();
				return false;
            }
            document.getElementById("deleteForm").submit();
        }

		function close() {
		    var reloadLocation = parent.location.toString().replace("#", "");
		    if (reloadLocation.indexOf("omc") < 0) {
		        if (reloadLocation.indexOf("?") < 0) {
				    reloadLocation += "?omc=true";
                }
                else{
				    reloadLocation += "&omc=true";
                }
			}
			parent.location = reloadLocation;
		}
	</script>
</head>
<body>
      <dw:Overlay ID="forward" Message="Please wait" runat="server">
        </dw:Overlay>
	<div runat="server" id="closeJs" visible="false">
		<script type="text/javascript">
			close();
		</script>
	</div>
    <form id="deleteForm" runat="server" action="Delete.aspx" method="post">
	<input type="hidden" runat="server" id="id" name="id" />
    <div id="step1Delete">
        <div class="header">
            <h1 id="title"><%= Dynamicweb.Backend.Translate.Translate("Stop split test.")%></h1>
        </div>
        <div class="mainArea">
			<div class="option2"><img src="/Admin/Images/Ribbon/Icons/media_stop_red.png" /> <b><%= Dynamicweb.Backend.Translate.Translate("Stop experiment?")%></b>
				<ul>
					<li><%= Dynamicweb.Backend.Translate.Translate("All data on visitors and conversions will be deleted.")%></li>
					<li><%= Dynamicweb.Backend.Translate.Translate("Disable the split test instead if data is still needed.")%></li>
				</ul>
				<input type="checkbox" id="deleteConfirm" /> <label for="deleteConfirm"><%= Dynamicweb.Backend.Translate.Translate("Yes, stop this split test!")%></label><br /><br />
				<div id="optionsDiv" name="optionsDiv" runat="server">
                <b><%= Dynamicweb.Backend.Translate.Translate("What do you want to do with your test variations?")%></b><br />
				<dw:RadioButton id="WhatToKeepAll" runat="server" FieldName="WhatToKeep" FieldValue="All" SelectedFieldValue="All" /> <label for="WhatToKeepAll"><%= Dynamicweb.Backend.Translate.Translate("Keep all versions, with original published")%></label><br />
				<dw:RadioButton ID="WhatToKeep1" runat="server" FieldName="WhatToKeep" FieldValue="1" /> <label for="WhatToKeep1"><%= Dynamicweb.Backend.Translate.Translate("Keep original and delete variation")%></label><br />
				<dw:RadioButton ID="WhatToKeep2" runat="server" FieldName="WhatToKeep" FieldValue="2" /> <label for="WhatToKeep2"><%= Dynamicweb.Backend.Translate.Translate("Keep variation and delete original")%></label><br />
                <dw:RadioButton ID="WhatToKeep3" runat="server" FieldName="WhatToKeep" FieldValue="Best" /> <label for="WhatToKeepBest"><%= Dynamicweb.Backend.Translate.Translate("Keep the best performing version and delete the other")%></label><br />
                </div>
             </div>
        </div>
        <div class="footer">
			<input type="button" value="OK" id="Button1" onclick="deleteExperiment();" />
        </div>
    </div>
    </form>
</body>
<%Dynamicweb.Backend.Translate.GetEditOnlineScript()%>
</html>
