<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.backend" %>
<%@ Page ValidateRequest="false" Language="vb" AutoEventWireup="false" Codebehind="Department_Add.aspx.vb" Inherits="Dynamicweb.Admin.Employee.Department_Add" %>
<%@Register TagPrefix="cust" Namespace="Dynamicweb.Employee" assembly="Dynamicweb.Compatibility"%>
<%@Register TagPrefix="emp" TagName="MultiSelect" src="MultiSelect.ascx"%>
<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
<script type="text/javascript" src="/Admin/Editor/fckeditor.js"></script>

<SCRIPT language="javascript">

function Validate()
{
    if (typeof(Page_ClientValidate) == 'function') Page_ClientValidate();
}

function ShowTab(tab)
{
	if (tab[0])
		tab[0].click();
}

function TryValidate()
{
    Validate();
    if (ValidatorOnSubmit()) 
    {
        Send();
        return true; 
    }
    else 
        ShowTab(document.all.Tab1);
}

function Send()
{
	if (typeof(dw_HTMLMode) != "undefined" && dw_HTMLMode == false) 
		document.forms.theForm._comment.value = DWEditor.DOM.body.innerHTML;
}

</SCRIPT>
<LINK href="/Admin/Stylesheet.css" type="text/css" rel="STYLESHEET">
<FORM id="theForm" name="theForm" runat="server">
	<input type=hidden value="<%=_id%>" name="ID"> <input type=hidden value="<%=_dept%>" name="Dept">
	<%=Gui.MakeHeaders("", Translate.Translate("Afdeling") & ", " & Translate.Translate("Kommentarer"), "all")%>
	<div id="Tab1" style="display:">
	<TABLE class="TabTable" id="Table1" cellSpacing="0" cellPadding="0" width="100%">
		<tr>
			<td colSpan="5">&nbsp;</td>
			<td>
				<%=Gui.GroupBoxStart(Translate.Translate("Oplysninger"))%>
				<table>
					<tr>
						<td width="5">&nbsp;</td>
						<td width="110"><%=Translate.Translate("Navn")%></td>
						<td><asp:textbox id=_name runat="server" Text='<%# Field("AccessUserName") %>' CssClass="std" maxLength = "50"></asp:textbox></td>
						<td><asp:requiredfieldvalidator id="_NameValidator" runat="server" ControlToValidate="_name" ErrorMessage="Name should not be empty"></asp:requiredfieldvalidator></td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td><%=Translate.Translate("Adresse")%></td>
						<td colspan="2">
							<asp:textbox id=_address runat="server" Text='<%# Field("AccessUserAddress") %>' CssClass="std" maxLength = "100">
							</asp:textbox>&nbsp;<asp:CheckBox id="_inherited" runat="server" Text="Inherited" OnCheckedChanged="InheritedClicked"
								AutoPostBack="True"></asp:CheckBox></td>
					<tr>
						<td>&nbsp;</td>
						<td><%=Translate.Translate("Postnummer")%></td>
						<td><asp:textbox id=_zip runat="server" Text='<%# Field("AccessUserZip") %>' CssClass="std" maxLength = "10"></asp:textbox></td>
						<td></td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td><%=Translate.Translate("By")%></td>
						<td><asp:textbox id=_city runat="server" Text='<%# Field("AccessUserCity") %>' CssClass="std" maxLength = "100"></asp:textbox></td>
						<td></td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td><%=Translate.Translate("Land")%></td>
						<td><asp:textbox id=_country runat="server" Text='<%# Field("AccessUserCountry") %>' CssClass="std" maxLength = "30"></asp:textbox></td>
						<td></td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td><%=Translate.Translate("Telefon")%></td>
						<td><asp:textbox id=_phone runat="server" Text='<%# Field("AccessUserPhone") %>' CssClass="std" maxLength = "255"></asp:textbox></td>
						<td></td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td><%=Translate.Translate("Telefax")%></td>
						<td><asp:textbox id=_fax runat="server" Text='<%# Field("AccessUserFax") %>' CssClass="std" maxLength = "50"></asp:textbox></td>
						<td></td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td><%=Translate.Translate("Website")%></td>
						<td><asp:textbox id=_web runat="server" Text='<%# Field("AccessUserWeb") %>' CssClass="std" maxLength = "255"></asp:textbox></td>
						<td></td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td><%=Translate.Translate("Aktiv")%></td>
						<td colSpan="2"><asp:checkbox id="_active" runat="server" Checked='<%# Active %>'></asp:checkbox></td>
					</tr>
				</table>
    			<%=Gui.GroupBoxEnd()%>
			    
			    					<cust:customfields id="_custFields" runat="server" NameWidth="80" RowID="<%#_id%>" Table="AccessCustomFieldDepartment">
					</cust:customfields>
				<%=Gui.GroupBoxStart(Translate.Translate("Overordnet"))%>
			    <table width="100%">
					<tr>
						<td align="center">
							<emp:multiselect id="_managers" runat="server" AccessDepartment="<%#_id%>" WorkMode = "<%#MultiSelect.WorkMode.EditDepartment%>" EnableValidate=False>
							</emp:multiselect>
						</td>
					</tr>
				</table>
    			<%=Gui.GroupBoxEnd()%>
				<table width="100%">
					<tr>
						<td colSpan="2">&nbsp;</td>
						<td vAlign="bottom" colSpan="3" align="right">
							<table id="Table3">
								<tr>
									<td align="right">
										<asp:Button id="_ok" runat="server" CssClass="buttonSubmit" Text="OK" OnCommand="OnSubmit"></asp:Button>
										<asp:Button id="_cancel" runat="server" CssClass="buttonSubmit" Text="Cancel" CausesValidation="False"
											OnCommand="OnCancel"></asp:Button>
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</td>
			<td width="5">&nbsp;</td>
		</tr>
	</TABLE>
    </div>
	<div id="Tab2" style="display:none">
	<TABLE class="TabTable" id="Table2" cellSpacing="0" cellPadding="0" width="100%">
		<tr>
			<td colSpan="5">&nbsp;</td>
			<td>
				<table  width="100%">
					<tr>
						<td>&nbsp;
            				<%=Gui.Editor("_comment", 550, 300, Field("AccessUserComment"))%>
						</td>
					</tr>
					<tr>
						<td align="right">
							<asp:Button id="_ok2" runat="server" CssClass="buttonSubmit" Text="OK" OnCommand="OnSubmit"></asp:Button>
							<asp:Button id="_cancel2" runat="server" CssClass="buttonSubmit" Text="Cancel" CausesValidation="False"
								OnCommand="OnCancel"></asp:Button>
						</td>
					</tr>
				</table>
			</td>
			<td width="5">&nbsp;</td>
		</tr>
	</TABLE>
    </div>
	<%Translate.GetEditOnlineScript()%>
</FORM>
