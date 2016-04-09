<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Admin/Content/Management/EntryContent.Master" CodeBehind="EcomAdvConfigOrderDiscounts_Edit.aspx.vb" Inherits="Dynamicweb.Admin.EcomAdvConfigOrderDiscounts_Edit" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <script language="javascript" type="text/javascript">
        var page = SettingsPage.getInstance();

        page.onSave = function () {    
            close = document.getElementById('hiddenSource').value != "ManagementCenterSave";
            if(document.getElementsByName('/Globalsettings/Ecom/Order/Discounts/OrderDiscountsUseOnly')[0].checked != <%=Base.ChkBoolean(Base.GetGs("/Globalsettings/Ecom/Order/Discounts/OrderDiscountsUseOnly")).ToString.ToLower()%>)
            {   
                top.left.location.reload(true);                
                document.getElementById('MainForm').action += "OpenTo=" + "OpenTo=" + (close ? "ManagementCenter" : "Ecom7Settins_ORDERDISCOUNTS");
            }
        
        document.getElementById('MainForm').submit();
        }

        page.onHelp = function () {
            <%=Gui.help("", "administration.controlpanel.ecom.discount") %>
        }
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
      <div id="PageContent">
        <table border="0" cellpadding="2" cellspacing="0" class="tabTable">
            <tr>
                <td valign="top" width="600px">
				    <%=Gui.GroupBoxStart(Translate.Translate("Indstillinger"))%>
				        <table cellpadding="2" cellspacing="0" border="0" style="margin: 5px;">
					        <colgroup>
						        <col width="200px" />
						        <col />
					        </colgroup>
					        <tr>
				    	        <td><%=Translate.Translate("Valg af rabat")%></td>
						        <td>
							        <select class="std" style="width: 254px;" name="/Globalsettings/Ecom/Order/Discounts/Selection" id="/Globalsettings/Ecom/Order/Discounts/Selection">
							        <%	
							            Dim selection As String = Base.GetGs("/Globalsettings/Ecom/Order/Discounts/Selection")
							            Dim selections As New Generic.Dictionary(Of String, String)() From {{"acc", "Akkumuleret"}, {"high", "Højest"}, {"low", "Lavest"}}

							            For Each sel As Generic.KeyValuePair(Of String, String) In selections
							                Response.Write(String.Format("<option value=""{0}""{1}>{2}</option>", sel.Key, If(selection.Equals(sel.Key, StringComparison.InvariantCultureIgnoreCase), " selected=""selected""", ""), Translate.Translate(sel.Value)))
							            Next
							        %>
							        </select>
						        </td>
					        </tr>
                            <tr>
				    	        <td><%=Translate.Translate("Only use order discounts")%></td>
                                <td>
                                    <input type="checkbox" name="/Globalsettings/Ecom/Order/Discounts/OrderDiscountsUseOnly"  <%=If(Base.ChkBoolean(Base.GetGs("/Globalsettings/Ecom/Order/Discounts/OrderDiscountsUseOnly")), "checked", "")%> />
                                </td>
                            </tr>
			            </table>
				    <%=Gui.GroupBoxEnd%>
                </td>
            </tr>
        </table>
    </div>

    <% Translate.GetEditOnlineScript() %>
</asp:Content>
