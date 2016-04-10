<%@ Page Language="vb" EnableViewState="false" AutoEventWireup="false" Codebehind="Default1.aspx.vb" Inherits="Dynamicweb.Admin.NewsLetterV3._Default2"%>
<%@ Register TagPrefix="uc" TagName="buttons" Src="UCButtons.ascx" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Import Namespace="Dynamicweb" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
<%@ Register Assembly="Dynamicweb.Admin" Namespace="Dynamicweb.Admin.ModulesCommon.ContextMenu" TagPrefix="cm" %>
<!DOCTYPE html PUBLIC  "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head id="Head1" runat="server">
    <title></title>
    <link rel="stylesheet" type="text/css" href="/Admin/Stylesheet.css" />
    <link rel="stylesheet" type="text/css" href="/Admin/Module/Common/Stylesheet.css" />
	<dw:ControlResources ID="ControlResources1" runat="server"></dw:ControlResources>

    <style type="text/css">
        td.title
        {
            margin: 0px;
            padding-left: 5px;
            border-bottom: solid 1px #9FAEC2;
            background: url('/Admin/Images/Ribbon/UI/List/PipeL.gif' ) top left repeat-x;
            height: 25px;
            line-height: 23px;
            vertical-align: middle;
            color: #15428b;
            font-family: Arial, Microsoft JhengHei;
            font-weight: bolder;
            font-size: 14px;
        }
    </style>

    <script type="text/javascript">
		//opens the menu (or rather unhides it)
		function openMenu()
		{
			document.getElementById('TreeView').style.display='';
			document.getElementById('MenuOpen').style.display='none';
		}

		function changeReportSrc(reportScript) {
		    var rpt = window.document.getElementById("ListRight");
		    rpt.src = reportScript;
		    //changeMenuGui(changeGuiParam);
		}

		function reloadTreeFrame(params) {
		    var tree = window.document.getElementById("_iftree");
		    tree.src = "TreeView.aspx" + params;
		}

		function OnRightLoaded() {
		    var frm = window.frames['ListRight'];
		    if (navigator.userAgent.toLowerCase().indexOf('msie') != -1) 
			{
			    var tab = document.getElementById('tabToolBar');
                var showScroll = (document.body.clientHeight - tab.clientHeight < frm.document.body.scrollHeight + 10);
			    frm.document.body.scroll = showScroll ? 'yes' : 'no';
		    }
		}
		function OnRightLoaded_TabClick() {
		    var frm = window.frames['ListRight'];
		    if (navigator.userAgent.toLowerCase().indexOf('msie') != -1) {
		        var tab = document.getElementById('tabToolBar');
		        var showScroll = (document.body.clientHeight - tab.clientHeight < frm.document.body.scrollHeight + 10);
		        frm.document.body.scroll = showScroll ? 'yes' : 'no';
		    }
		}		
    </script>
	
</head>
<body onresize="OnRightLoaded();" style="margin: 0px; height: 100%; background-color: <%=Dynamicweb.Gui.NewUIbgColor%>">
	<table cellspacing="0" cellpadding="0" border="0" height="100%" width="100%" id="MenuTable">
        <tr bgcolor="#ffffff">
			<td width="0" bgcolor="<%=Dynamicweb.Gui.NewUIbgColor%>" rowspan="2" nowrap="nowrap"></td>
            <td id="MenuOpen" style="display: none; background: url(/Admin/Images/Ribbon/UI/ContentBG2.gif) #6591cd repeat-x left top;
                width: 22px; padding-top:3px;" align="center" valign="top">
                <img src="/Admin/images/OpenTreeView_off.gif" title="Show" onmouseover="this.src='/Admin/images/OpenTreeView_on.gif'"
                    onmouseout="this.src='/Admin/images/OpenTreeView_off.gif'" onmousedown="this.src='/Admin/images/OpenTreeView_press.gif'"
                    onmouseup="this.src='/Admin/images/OpenTreeView_on.gif'" onclick="openMenu();"
                    alt="" />
            </td>
			<td id="TreeView" valign="top" style="width: 200px" nowrap="nowrap">
				<table height="100%" cellspacing="0" cellpadding="0" width="100%" border="0">
					<tr id="TreeStart">
						<td style="height:20px; width:90%">
						    <h1 class="title"><%= Translate.Translate("Newsletter")%></h1>
                        </td>
                        <td class="title">
                            <img src="/Admin/images/CloseTreeView_off.gif" title="Hide" onmouseover="this.src='/Admin/images/CloseTreeView_on.gif'"
                                                onmouseout="this.src='/Admin/images/CloseTreeView_off.gif'" onmousedown="this.src='/Admin/images/CloseTreeView_press.gif'"
                                                onmouseup="this.src='/Admin/images/CloseTreeView_on.gif'" onclick="document.getElementById('TreeView').style.display='none';document.getElementById('MenuOpen').style.display='';"
                                                height="17" width="20" alt="" />
                        </td>
                    </tr>
                    <tr>
                        <td  style="height:18px" colspan="2">
						    <h2 class="subtitle"><%= Translate.Translate("Mail folders")%></h2>
						</td>

					</tr>
					<tr>
						<td colspan="2">
							<iframe width="100%" height="100%" src="TreeView.aspx" frameborder="0" marginheight="0" marginwidth="0" name="_iftree" id="_iftree"></iframe>
						</td>
					</tr>

				</table>
			</td>
			<td width="1" bgcolor="<%=Dynamicweb.Gui.NewUIbordercolor%>" rowspan="2" nowrap></td>
            <td nowrap="nowrap">
				<table height="100%" cellspacing="0" cellpadding="0" width="100%" border="0">
                    <!--TopMenu-->
				    <tr valign="top" height="27">
                        <td><uc:buttons ID="_buttons2" runat="server"></uc:buttons>
                        </td>
                    </tr>
                    <!--/TopMenu-->
					<tr>
						<td align="left">
							<table cellspacing="0" cellpadding="0" border="0" width="100%" height="100%">
								<tr>
									<td width="100%">
                                        <!--Right frame-->
										<iframe runat="server" id="ListRight" name="ListRight" width="100%" height="100%" src="" frameborder="0" marginheight="0" marginwidth="0"></iframe>
                                        <!--/Right frame-->
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</td>
        </tr>
    </table>
</body>
</html>
<%  Translate.GetEditOnlineScript() %>
