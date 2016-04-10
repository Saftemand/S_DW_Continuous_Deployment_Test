<%@ Control Language="vb" AutoEventWireup="false" Codebehind="ClassMethodSelector.ascx.vb" Inherits="Dynamicweb.Admin.ScheduledTask_cpl.ClassMethodSelector" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<script language="javascript">

var __classMethodValidationEnabled = true;

function OnBrowseClassMethod(id)
{
	window.open("ClassBrowser.aspx?ParentID=" + id, "class_browser", "height=600,width=800,location=no,menubar=no,status=no,toolbar=no,top=50,left=50,resizable=yes,scrollbars=yes");
}

function ValidateLibrary(source, arguments)
{
	var lib = document.getElementById("<%=MLibrary.UniqueID%>");
	arguments.IsValid = !__classMethodValidationEnabled || lib.value.length > 0;
}

function ValidateNamespace(source, arguments)
{
	var nmsp = document.getElementById("<%=MNamespace.UniqueID%>");
	arguments.IsValid = !__classMethodValidationEnabled || nmsp.value.length > 0;
}

function ValidateClass(source, arguments)
{
	var cls = document.getElementById("<%=MClass.UniqueID%>");
	arguments.IsValid = !__classMethodValidationEnabled || cls.value.length > 0;
}

function ValidateMethod(source, arguments)
{
	var method = document.getElementById("<%=Method.UniqueID%>");
	arguments.IsValid = !__classMethodValidationEnabled || method.value.length > 0;
}

function OnClickParam(num)
{
	var idChck = "<%=chckParam0.UniqueID%>";
	var idText = "<%=Param0.UniqueID%>";
	
	idChck = idChck.substr(0, idChck.length-1);
	idText = idText.substr(0, idText.length-1);

	if (!document.getElementById(idChck + num).checked)
	{
		document.getElementById(idText + num).value = "";
		var i = 0;
		for (i = num + 1; i < 5; i++)
		{
			document.getElementById(idChck + i).checked = false;
			document.getElementById(idText + i).value = "";
		}
	}
}
</script>
<table>
	<tr>
		<td width="100"><%=Translate.translate("Library")%></td>
		<td>
			<asp:TextBox id="MLibrary" MaxLength="255" runat="server" CssClass="std"></asp:TextBox>&nbsp;
			<asp:CustomValidator id="LibraryValidator" ClientValidationFunction="ValidateLibrary" Display="Dynamic"
				ErrorMessage="*" runat="server" />
		</td>
	</tr>
	<tr>
		<td><%=Translate.translate("Namespace")%></td>
		<td><asp:TextBox id="MNamespace" MaxLength="255" runat="server" CssClass="std"></asp:TextBox>&nbsp;
			<asp:CustomValidator id="NamespaceValidator" ClientValidationFunction="ValidateNamespace" Display="Dynamic"
				ErrorMessage="*" runat="server" />
		</td>
	</tr>
	<tr>
		<td><%=Translate.translate("Class")%></td>
		<td><asp:TextBox id="MClass" MaxLength="255" runat="server" CssClass="std"></asp:TextBox>&nbsp;
			<asp:CustomValidator id="ClassValidator" ClientValidationFunction="ValidateClass" Display="Dynamic" ErrorMessage="*"
				runat="server" />
		</td>
	</tr>
	<tr>
		<td><%=Translate.translate("Method")%></td>
		<td><asp:TextBox id="Method" MaxLength="255" runat="server" CssClass="std"></asp:TextBox><img style="MARGIN-LEFT: 2px;CURSOR: hand" align="absBottom" src="/Admin/images/Icons/Page_int.gif" alt="Browse" onclick="OnBrowseClassMethod('<%=ID%>')"></img>&nbsp;
			<asp:CustomValidator id="MethodValidator" ClientValidationFunction="ValidateMethod" Display="Dynamic"
				ErrorMessage="*" runat="server" />
		</td>
	</tr>
	<tr>
		<td valign="top"><%=Translate.translate("Parameters")%></td>
		<td>
			<fieldset>
				<asp:CheckBox id="chckParam0" runat="server" onclick="OnClickParam(0)"></asp:CheckBox>Parameter 
				1<asp:TextBox id="Param0" MaxLength="255" runat="server" CssClass="std"></asp:TextBox><br>
				<asp:CheckBox id="chckParam1" runat="server" onclick="OnClickParam(1)"></asp:CheckBox>Parameter 
				2<asp:TextBox id="Param1" MaxLength="255" runat="server" CssClass="std"></asp:TextBox><br>
				<asp:CheckBox id="chckParam2" runat="server" onclick="OnClickParam(2)"></asp:CheckBox>Parameter 
				3<asp:TextBox id="Param2" MaxLength="255" runat="server" CssClass="std"></asp:TextBox><br>
				<asp:CheckBox id="chckParam3" runat="server" onclick="OnClickParam(3)"></asp:CheckBox>Parameter 
				4<asp:TextBox id="Param3" MaxLength="255" runat="server" CssClass="std"></asp:TextBox><br>
				<asp:CheckBox id="chckParam4" runat="server" onclick="OnClickParam(4)"></asp:CheckBox>Parameter 
				5<asp:TextBox id="Param4" MaxLength="255" runat="server" CssClass="std"></asp:TextBox><br>
			</fieldset>
		</td>
	</tr>
</table>
