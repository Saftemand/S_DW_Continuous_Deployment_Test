<%@ Page Language="vb" MasterPageFile="/Admin/Content/Management/EntryContent.Master" AutoEventWireup="false" CodeBehind="EcomAdvConfigImages_Edit.aspx.vb" Inherits="Dynamicweb.Admin.EcomAdvConfigImages_Edit" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>

<asp:Content ContentPlaceHolderID="HeadContent" runat="server">

    <script language="javascript" type="text/javascript">
        var page = SettingsPage.getInstance();
        
        page.onSave = function() {
            <% Dynamicweb.eCommerce.Products.Group.ClearCache()%>
            document.getElementById('MainForm').submit();
        }
        
        page.onHelp = function() {
            <%=Gui.help("", "administration.controlpanel.ecom.images") %>
        }

    </script>
</asp:Content>

<asp:Content ContentPlaceHolderID="MainContent" runat="server" >

    <div id="PageContent">
        <table border="0" cellpadding="2" cellspacing="0" class="tabTable">
            <tr>
                <td valign="top" width="600px">
	                <%=Gui.GroupBoxStart(Translate.Translate("Product default images"))%>
		                <table cellpadding="2" cellspacing="0" border="0">
			                <colgroup>
				                <col width="170px" />
				                <col />
			                </colgroup>
			                <tr>
				                <td><%=Translate.Translate("Lille")%></td>
				                <td><%= Gui.FileManager(Base.GetGs("/Globalsettings/Ecom/Picture/NoPicture/Small"), Dynamicweb.Content.Management.Installation.ImagesFolderName, "/Globalsettings/Ecom/Picture/NoPicture/Small", "", True, "std", True)%></td>
			                </tr>
			                <tr>
				                <td><%=Translate.Translate("Medium")%></td>
				                <td><%= Gui.FileManager(Base.GetGs("/Globalsettings/Ecom/Picture/NoPicture/Medium"), Dynamicweb.Content.Management.Installation.ImagesFolderName, "/Globalsettings/Ecom/Picture/NoPicture/Medium", "", True, "std", True)%></td>
			                </tr>
			                <tr>
				                <td><%=Translate.Translate("Stor")%></td>
				                <td><%= Gui.FileManager(Base.GetGs("/Globalsettings/Ecom/Picture/NoPicture/Large"), Dynamicweb.Content.Management.Installation.ImagesFolderName, "/Globalsettings/Ecom/Picture/NoPicture/Large", "", True, "std", True)%></td>
			                </tr>
		                </table>
	                    <%=Gui.GroupBoxEnd%>	

                       <%=Gui.GroupBoxStart(Translate.Translate("Group default images"))%>
		                <table cellpadding="2" cellspacing="0" border="0">
			                <colgroup>
				                <col width="170px" />
				                <col />
			                </colgroup>
			                <tr>
				                <td><%=Translate.Translate("Lille")%></td>
				                <td><%= Gui.FileManager(Base.GetGs("/Globalsettings/Ecom/Picture/Group/NoPicture/Small"), Dynamicweb.Content.Management.Installation.ImagesFolderName, "/Globalsettings/Ecom/Picture/Group/NoPicture/Small", "", True, "std", True)%></td>
			                </tr>
			                <tr>
				                <td><%=Translate.Translate("Stor")%></td>
				                <td><%= Gui.FileManager(Base.GetGs("/Globalsettings/Ecom/Picture/Group/NoPicture/Large"), Dynamicweb.Content.Management.Installation.ImagesFolderName, "/Globalsettings/Ecom/Picture/Group/NoPicture/Large", "", True, "std", True)%></td>
			                </tr>
		                </table>
	                    <%=Gui.GroupBoxEnd%>	
		            
	                    <%=Gui.GroupBoxStart(Translate.Translate("Image pattern"))%>
	                     <table cellpadding="2" cellspacing="0" border="0">
			                <colgroup>
				                <col width="170px" />
				                <col />
			                </colgroup>
			                <tr>
				                <td><%=Translate.Translate("Pattern")%></td>
				                <td>
				                <input type="text" name="/Globalsettings/Ecom/Picture/ImagePattern" id="/Globalsettings/Ecom/Picture/ImagePattern" value="<%=Base.GetGs("/Globalsettings/Ecom/Picture/ImagePattern")%>" class="std" /> 
				                </td>
			                </tr>
		                </table>
	                    <%=Gui.GroupBoxEnd%>	
		            
		                <%=Gui.GroupBoxStart(Translate.Translate("Autoscale"))%>
		                <table cellpadding="2" cellspacing="0" border="0">
			                <colgroup>
				                <col width="170px" />
				                <col width="50px" />
				                <col />
			                </colgroup>
                            <tr>
						        <td></td>
						        <td><strong><%=Translate.JsTranslate("Active")%></strong></td>
						        <td><strong><%=Translate.JsTranslate("Width")%>&nbsp;&nbsp;&nbsp;<%=Translate.JsTranslate("Height")%></strong></td>
					        </tr>				        
			                <tr>
				                <td><%=Translate.Translate("Lille")%></td>
						        <td><input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Ecom/Picture/Autoscale/Small/Active") = "True", "CHECKED", "")%> id="/Globalsettings/Ecom/Picture/Autoscale/Small/Active" name="/Globalsettings/Ecom/Picture/Autoscale/Small/Active" Onclick="ChkAutoScaleOn();" /></td>
				                <td id="as_Small">
				                    <input type="text" name="/Globalsettings/Ecom/Picture/Autoscale/Small/Width" id="/Globalsettings/Ecom/Picture/Autoscale/Small/Width" value="<%=Base.GetGs("/Globalsettings/Ecom/Picture/Autoscale/Small/Width")%>" maxlength="255" size=4 style="text-align:right;" class="stdNoWidth" /> 
				                    <span style="color:Gray">x</span>
				                    <input type="text" name="/Globalsettings/Ecom/Picture/Autoscale/Small/Height" id="/Globalsettings/Ecom/Picture/Autoscale/Small/Height" value="<%=Base.GetGs("/Globalsettings/Ecom/Picture/Autoscale/Small/Height")%>" maxlength="255" size=4 style="text-align:right;" class="stdNoWidth" /> 
				                    <span style="color:Gray"><%=Translate.JsTranslate("px")%></span>
				                </td>
			                </tr>
			                <tr>
				                <td><%=Translate.Translate("Medium")%></td>
						        <td><input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Ecom/Picture/Autoscale/Medium/Active") = "True", "CHECKED", "")%> id="/Globalsettings/Ecom/Picture/Autoscale/Medium/Active" name="/Globalsettings/Ecom/Picture/Autoscale/Medium/Active" Onclick="ChkAutoScaleOn();" /></td>
                                <td id="as_Medium">
				                    <input type="text" name="/Globalsettings/Ecom/Picture/Autoscale/Medium/Width" id="/Globalsettings/Ecom/Picture/Autoscale/Medium/Width" value="<%=Base.GetGs("/Globalsettings/Ecom/Picture/Autoscale/Medium/Width")%>" maxlength="255" size=4 style="text-align:right;" class="stdNoWidth" /> 
				                    <span style="color:Gray">x</span>
				                    <input type="text" name="/Globalsettings/Ecom/Picture/Autoscale/Medium/Height" id="/Globalsettings/Ecom/Picture/Autoscale/Medium/Height" value="<%=Base.GetGs("/Globalsettings/Ecom/Picture/Autoscale/Medium/Height")%>" maxlength="255" size=4 style="text-align:right;" class="stdNoWidth" /> 
				                    <span style="color:Gray"><%=Translate.JsTranslate("px")%></span>
				                </td>
			                </tr>
			                <tr>
				                <td><%=Translate.Translate("Stor")%></td>
						        <td><input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Ecom/Picture/Autoscale/Large/Active") = "True", "CHECKED", "")%> id="/Globalsettings/Ecom/Picture/Autoscale/Large/Active" name="/Globalsettings/Ecom/Picture/Autoscale/Large/Active" Onclick="ChkAutoScaleOn();" /></td>
                                   <td id="as_Large">
				                    <input type="text" name="/Globalsettings/Ecom/Picture/Autoscale/Large/Width" id="/Globalsettings/Ecom/Picture/Autoscale/Large/Width" value="<%=Base.GetGs("/Globalsettings/Ecom/Picture/Autoscale/Large/Width")%>" maxlength="255" size=4 style="text-align:right;" class="stdNoWidth" /> 
				                    <span style="color:Gray">x</span>
				                    <input type="text" name="/Globalsettings/Ecom/Picture/Autoscale/Large/Height" id="/Globalsettings/Ecom/Picture/Autoscale/Large/Height" value="<%=Base.GetGs("/Globalsettings/Ecom/Picture/Autoscale/Large/Height")%>" maxlength="255" size=4 style="text-align:right;" class="stdNoWidth" /> 
				                    <span style="color:Gray"><%=Translate.JsTranslate("px")%></span>
				                </td>
			                </tr>
		                </table>
	                    <%=Gui.GroupBoxEnd%>
                </td>
            </tr>
        </table>
    </div>

    <% Translate.GetEditOnlineScript() %>

    <script language="javascript" type="text/javascript">

    function ChkAutoScaleOn() {
        //SMALL
        var as_sm = document.getElementById("/Globalsettings/Ecom/Picture/Autoscale/Small/Active");
        if (as_sm.checked) {
            document.getElementById("as_Small").style.filter = "";
        } else {
		    document.getElementById('as_Small').style.filter = "progid:DXImageTransform.Microsoft.Alpha(opacity=30)progid:DXImageTransform.Microsoft.BasicImage(grayscale=1);-moz-opacity: 0.4;";
        }  

        //MEDIUM
        var as_me = document.getElementById("/Globalsettings/Ecom/Picture/Autoscale/Medium/Active");
        if (as_me.checked) {
            document.getElementById("as_Medium").style.filter = "";
        } else {
            document.getElementById("as_Medium").style.filter = "progid:DXImageTransform.Microsoft.Alpha(opacity=30)progid:DXImageTransform.Microsoft.BasicImage(grayscale=1);-moz-opacity: 0.4;";
        }  

        //LARGE
        var as_lr = document.getElementById("/Globalsettings/Ecom/Picture/Autoscale/Large/Active");
        if (as_lr.checked) {
            document.getElementById("as_Large").style.filter = "";
        } else {
            document.getElementById("as_Large").style.filter = "progid:DXImageTransform.Microsoft.Alpha(opacity=30)progid:DXImageTransform.Microsoft.BasicImage(grayscale=1);-moz-opacity: 0.4;";
        }  
    }
    ChkAutoScaleOn();

    </script>

</asp:Content>
