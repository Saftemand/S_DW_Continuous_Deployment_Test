<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Default.aspx.vb" Inherits="Dynamicweb.Admin.LinkSearch" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<dw:ControlResources IncludePrototype="true" runat="server"></dw:ControlResources>

<html>
	<head>
		<title>
			<%=strTopTrans%>
		</title>
		<script language="VB" runat="Server">
		    Dim ShowSettings As Boolean = True
		    Dim tabstart As String
		    Dim tabTrans As String
		    Dim strTopTrans As String
		    Dim tabDisplay As String
		</script>
        <%If Request("ShowSettings") <> "" Then
            ShowSettings = False
        End If

        If ShowSettings Then
            tabstart = "1"
            tabTrans = Translate.Translate("Link management", 9)
            strTopTrans = Translate.Translate("Link management", 9)
            tabDisplay = ""
        ElseIf Not Base.HasAccess("LinkSearch", "") And Base.HasVersion("18.9.1.0") Then
            tabstart = "1"
            tabTrans = Translate.Translate("Generelt")
            strTopTrans = Translate.Translate("Egenskaber")
            tabDisplay = "none"
        Else
            tabstart = "2"
            tabTrans = Translate.Translate("Generelt") & ", " & Translate.Translate("Referencer")
            strTopTrans = Translate.Translate("Egenskaber")
            tabDisplay = "none"
        End If%>
        
		<script type="text/javascript" language="JavaScript">
		function cc(objRow){ //Change color of row when mouse is over... (ChangeColor)
			objRow.style.backgroundColor='#E1DED8';
		}

		function ccb(objRow){ //Remove color of row when mouse is out... (ChangeColorBack)
			objRow.style.backgroundColor='';
		}
		
		function findReferences() {
		    var a = "<%=Request("ShowSettings")%>";
		    var b = "<%=Request("ShowAll")%>";
		    var c = "<%=Request("SearchAll")%>";
		    var d = "<%=Request("resultMode")%>";
		    var e = "<%=Request("ActualFolder")%>";
		    var f = "<%=Request("keyWord")%>";
		    f = encodeURIComponent(f);
		    
		    document.getElementById("loadingblock").style.display = "";
		    document.getElementById("findRefBut").disabled = true;
		    
		    var url = "Default.aspx?ShowSettings=" + a + "&ShowAll=" + b + "&SearchAll=" + c + "&resultMode=" + d + "&ActualFolder=" + e + "&keyWord=" + f + "&List=true&Tab=2";
		    document.location.href = url;
		    return false;
		}
		
		function saveSearchSettings() {
		    var params = {
		        "InternalLinks": $(linkTypeInternal).checked,
		        "ExternalLinks": $(linkTypeExternal).checked,
		        "Files": $(linkTypeFiles).checked
		    };
		    new Ajax.Request('/Admin/Module/LinkSearch/Default.aspx', {
		        method: 'POST',
		        parameters: {
		            "ajax": "save",
		            "param": JSON.stringify(params),
		            "dt": new Date().getTime()
		        },
		        onSuccess: function (transport) {
		            alert(transport.responseText);
		        },
		    });
		}
		//-->
		</script>
		
		<link rel="STYLESHEET" type="text/css" href="../../Stylesheet.css">
		<meta name="Generator" content="EditPlus">
		<meta name="Author" content="">
		<meta name="Keywords" content="">
		<meta name="Description" content="">
		<%Response.Write(Gui.MakeHeaders(strTopTrans, tabTrans, "All", false, ""))%>
	</head>
	<%If Request("Tab") <> "" Then%>
		<script language="javascript" type="text/javascript"> document.body.onload = function(){TabClick(document.getElementById("Tab<%=Request("Tab") %>_head"));}</script>
    <%End If%>
	
    <body>
		<%If Not ShowSettings Then%>
		<div ID="Tab1">
			<table border="0" cellspacing="0" cellpadding="0" class="tabTable">
				<tr height="5">
					<td colspan="2"></td>
				</tr>
				<tr>
					<td valign="top" width="65%">
					<asp:Label id="fileProperties" runat="server"></asp:Label>
					</td>
				</tr>
			</table>
		</div>
		<%End If%>
		<div ID="Tab<%=tabstart%>" STYLE="display:<%=tabDisplay%>;">
			<table border="0" cellspacing="0" cellpadding="0" class="tabTable">
			    <tr>
                    <td valign="top">
				        <form runat="server" >
                            <table width="100%">
					            <tr height="5" style="display: <%=tabDisplay %>">
						            <td colspan="2"></td>
					            </tr>
					            <%If Base.HasAccess("LinkSearch", "") Then%>
					                <tr style="display: <%=Base.IIf(tabDisplay = "", "none", "").ToString%>;">
						            <td valign="top" colspan="2">
							            <fieldset style="MARGIN: 5px;">
								            <legend class="gbTitle"><%=Translate.Translate("Referencesøgning") %></legend>
                                            <input type="button" name="findRefBut" id="findRefBut" value="<%=Translate.JsTranslate("Find referencer")%>" onclick="findReferences();" />
                                            <div id="loadingblock" style="display:none;"><%=Dynamicweb.eCommerce.Common.Gui.LoadLayer%></div>
							            </fieldset>
						            </td>
					            </tr>
                			    <%End If%>
					            <%If ShowSettings Then%>
					                <tr>
						                <td valign="top" colspan="2">
							                <fieldset style="MARGIN: 5px;">
								                <legend class="gbTitle">
									                <%=Translate.Translate("Søg")%>
								                </legend>
								                <table border="0" cellspacing="0" cellpadding="2" width="100%">
									                <%If Base.IsModuleInstalled("Area") Then%>
									                <tr>
										                <td width="170"><%=Translate.Translate("Sprog",9)%></td>
										                <td>
                                                            <asp:label id="linkAreaSelect" runat="server"></asp:label>
										                </td>
									                </tr>
									                <tr>
										                <td colspan="2">&nbsp;</td>
									                </tr>
									                <%End If%>
									                <tr valign="top">
										                <td width="170">
                                                            <%=Translate.Translate("Søg i")%>
										                </td>
										                <td>
											                <input type="checkbox" name="linkPage" id="linkPage" value="ON" runat="server">
											                <label for="linkPage">
												                <%=Translate.Translate("Sider")%>
											                </label>
											                <br>
											                <input type="checkbox" name="linkParagraph" id="linkParagraph" value="ON" runat="server">
											                <label for="linkParagraph">
												                <%=Translate.Translate("Afsnit")%>
											                </label>
											                <%If Base.IsModuleInstalled("News") Then%>
											                <br>
											                <input type="checkbox" name="linkNews" id="linkNews" value="ON" runat="server">
											                <label for="linkNews">
												                <%=Translate.Translate("Nyheder")%>
											                </label>
											                <%End If%>
											                <%If Base.IsModuleInstalled("Calender") Then%>
											                <br>
											                <input type="checkbox" name="linkCalendar" id="linkCalendar" value="ON" runat="server">
											                <label for="linkCalendar">
												                <%=Translate.Translate("Kalender")%>
											                </label>
											                <%End If%>
											                <%If Base.IsModuleInstalled("Shop") Then%>
											                <br>
											                <input type="checkbox" name="linkShop" id="linkShop" value="ON" runat="server">
											                <label for="linkShop">
												                <%=Translate.Translate("Varekatalog")%>
											                </label>
											                <%End If%>
										                </td>
									                </tr>
									                <tr valign="top">
										                <td width="170"><%=Translate.Translate("Søg efter")%></td>
										                <td>
											                <input type="checkbox" name="linkTypeInternal" id="linkTypeInternal" value="ON" runat="server">
											                <label for="linkTypeInternal">
												                <%=Translate.Translate("Interne links")%>
											                </label>
											                <br>
											                <input type="checkbox" name="linkTypeExternal" id="linkTypeExternal" value="ON" runat="server">
											                <label for="linkTypeExternal">
												                <%=Translate.Translate("Eksterne links")%>
											                </label>
											                <br>
											                <input type="checkbox" name="linkTypeFiles" id="linkTypeFiles" value="ON" runat="server">
											                <label for="linkTypeFiles">
												                <%=Translate.Translate("Filer")%>
											                </label>
										                </td>
									                </tr>
									                <tr valign="top">
										                <td width="170"><%=Translate.Translate("Sensitivity")%></td>
										                <td>
										                    <select id="linkTimeout" name="linkTimeout" class="std">
										                        <option value="5000" <%= Base.IIf(Base.Request("linkTimeout") = "5000", "selected='selected'", "") %>>5 <%=Translate.Translate("seconds")%></option>
										                        <option value="10000" <%= Base.IIf(Base.Request("linkTimeout") = "10000", "selected='selected'", "") %>>10 <%=Translate.Translate("seconds")%></option>
										                        <option value="15000" <%= Base.IIf(Base.Request("linkTimeout") = "15000", "selected='selected'", "") %>>15 <%=Translate.Translate("seconds")%></option>
										                        <option value="30000" <%= Base.IIf(Base.Request("linkTimeout") = "30000", "selected='selected'", "") %>>30 <%=Translate.Translate("seconds")%></option>
										                    </select>
										                </td>
									                </tr>
									                <tr>
										                <td colspan="2">&nbsp;</td>
									                </tr>
									                <tr>
										                <td width="170"><%=Translate.Translate("Validering")%></td>
										                <td><input type="checkbox" name="linkValid" id="linkValid" value="ON" runat="server">
											                <label for="linkValid">
												                <%=Translate.Translate("Valider links")%>
											                </label>
										                </td>
									                </tr>
									                <tr>
										                <td></td>
										                <td><input type="checkbox" name="ShowInvalid" id="ShowInvalid" value="ON" runat="server">
											                <label for="ShowInvalid">
												                <%=Translate.Translate("Vis kun invalide links")%>
											                </label>
										                </td>
									                </tr>
								                </table>
							                </fieldset>
						                </td>
					                </tr>
					                <tr>
						                <td align="right">
							                <table>
									            <tr>
										            <td align="right" valign="bottom"><%=Gui.Button(Translate.JsTranslate("Søg"), "this.form.submit()", 0, False)%></td>
										            <td><%=Gui.Button(Translate.Translate("Save settings"), "saveSearchSettings()", 0)%></td>
										            <td><%=Gui.Button(Translate.Translate("Luk"), "location='../../Content/Moduletree/EntryContent.aspx'", 0)%></td>
										            <td><%=Gui.HelpButton("LinkManagement", "modules.linksearch.general")%></td>
					                            </tr>
                			                </table>
			                            </td>
					                </tr>
			                    <%End If%>
                            </table>
                        </form>
			    <tr valign="top">
				    <td colspan="2">
                        <asp:label id="linkSearchContent" runat="server"></asp:label>
				    </td>
			    </tr>
			</table>
		</div>
		<%
Translate.GetEditOnlineScript()
%>
	</body>
</html>
