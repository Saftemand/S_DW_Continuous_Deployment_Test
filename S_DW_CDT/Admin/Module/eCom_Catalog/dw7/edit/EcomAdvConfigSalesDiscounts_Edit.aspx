<%@ Page Language="vb" MasterPageFile="/Admin/Content/Management/EntryContent.Master" AutoEventWireup="false" CodeBehind="EcomAdvConfigSalesDiscounts_Edit.aspx.vb" Inherits="Dynamicweb.Admin.EcomAdvConfigSalesDiscounts_Edit" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>

<asp:Content ContentPlaceHolderID="HeadContent" runat="server">

    <script language="javascript" type="text/javascript">
        var page = SettingsPage.getInstance();
        
        page.onSave = function() {

            document.getElementById('MainForm').submit();
        }
        
        page.onHelp = function() {
            <%=Gui.help("", "administration.controlpanel.ecom.discount") %>
        }

    </script>
</asp:Content>

<asp:Content ContentPlaceHolderID="MainContent" runat="server" >

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
						        <td><%=Translate.Translate("Differentiate on VAT Groups")%></td>
						        <td><input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Ecom/Order/VAT/DifferentiateDiscountOnVATGroup") = "True", "CHECKED", "")%> id="/Globalsettings/Ecom/Order/VAT/DifferentiateDiscountOnVATGroup" name="/Globalsettings/Ecom/Order/VAT/DifferentiateDiscountOnVATGroup" /></td>
					        </tr>
					        <tr><td colspan="2"><hr size="1" color="#efefef" /></td></tr>
					        <tr>
				    	        <td><%=Translate.Translate("Valg af rabat")%></td>
						        <td>
							        <select class="std" name="/Globalsettings/Ecom/Discount/DiscountSelection" id="/Globalsettings/Ecom/Discount/DiscountSelection">

							        <%	
							            Dim selA As String = ""
							            Dim selB As String = ""
							            Dim selC As String = ""
							
							            If Base.GetGs("/Globalsettings/Ecom/Discount/DiscountSelection") = "acc" Then
							                selA = "SELECTED"
							            ElseIf Base.GetGs("/Globalsettings/Ecom/Discount/DiscountSelection") = "high" Then
							                selB = "SELECTED"
							            ElseIf Base.GetGs("/Globalsettings/Ecom/Discount/DiscountSelection") = "low" Then
							                selC = "SELECTED"
							            End If

							            Response.Write("<option value=""acc"" " & selA & ">" & Translate.JsTranslate("Akkumuleret") & "</option>")
							            Response.Write("<option value=""high"" " & selB & ">" & Translate.JsTranslate("Højest") & "</option>")
							            Response.Write("<option value=""low"" " & selC & ">" & Translate.JsTranslate("Lavest") & "</option>")
							        %>
							        </select>
						        </td>
					        </tr>
                            <tr>
						        <td><%=Translate.Translate("Include product discounts")%></td>
						        <td><input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Ecom/Discount/IncludeProductDiscounts") = "True", "CHECKED", "")%> id="/Globalsettings/Ecom/Discount/IncludeProductDiscounts" name="/Globalsettings/Ecom/Discount/IncludeProductDiscounts" /></td>
					        </tr>
					        <tr>
					            <td colspan="2">
				                    <div style="color:Gray">				                        
				                        <%=Translate.Translate("When the option is not selected this setting does not effect the product discounts, as they are always accumulated.")%>
					                </div>		
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
