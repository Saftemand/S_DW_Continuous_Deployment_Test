<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Edit.aspx.vb" Inherits="Dynamicweb.Admin.Edit4" %>

<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
	<dw:ControlResources runat="server">
	</dw:ControlResources>

	<script src="Comments.js" type="text/javascript"></script>
	<script type="text/javascript">
	var commentid = <%=cID %>;
	var ItemID = '<%=ItemID %>';
	var Type = '<%=Type %>';
	var LangID = '<%=LangID %>';
	</script>
</head>
<body>
    <form id="form1" runat="server">
		<input type="hidden" name="id" id="CommentID" runat="server" />
		<dw:Toolbar ID="Toolbar1" runat="server">
			<dw:ToolbarButton ID="ToolbarButton1" runat="server" Divide="None" Image="Save" Text="Save" OnClientClick="document.getElementById('form1').submit()" ShowWait="true">
			</dw:ToolbarButton>
			<dw:ToolbarButton ID="ToolbarButton2" runat="server" Divide="None" Image="Cancel" Text="Cancel" OnClientClick="location.href = 'List.aspx?Type=' + Type + '&ItemID=' + ItemID + '&LangID=' + LangID;" ShowWait="true">
			</dw:ToolbarButton>
			<dw:ToolbarButton ID="ToolbarButton3" runat="server" Divide="None" Image="Delete" Text="Slet" OnClientClick="del(commentid);" ShowWait="true">
			</dw:ToolbarButton>
		</dw:Toolbar>
		<h2 class="subtitle"><dw:TranslateLabel ID="TranslateLabel2" runat="server" Text="Rediger" /></h2>
    <div>
		<dw:GroupBox ID="GroupBox1" runat="server" Title="Egenskaber">
			<table width="100%">
				<tr>
					<td width="170">
						<dw:TranslateLabel ID="TranslateLabel1" runat="server" Text="Navn" />
					</td>
					<td>
						<input id="name" type="text" runat="server" class="std" />
					</td>
				</tr>
				<tr>
					<td>
						<dw:TranslateLabel ID="TranslateLabel3" runat="server" Text="E-mail" />
					</td>
					<td>
						<input id="email" type="text" runat="server" class="std" />
					</td>
				</tr>
				<tr>
					<td>
						<dw:TranslateLabel ID="TranslateLabel4" runat="server" Text="Website" />
					</td>
					<td>
						<input id="website" type="text" runat="server" class="std" />
					</td>
				</tr>
                <tr>
					<td>
						<label for="active"><dw:TranslateLabel ID="TranslateLabel8" runat="server" Text="Status" /></label>
					</td>
					<td>
						<input id="active" type="checkbox" runat="server" value="True" /> <label for="active"><dw:TranslateLabel ID="TranslateLabel7" runat="server" Text="Active" /></label>
					</td>
				</tr>
				<tr>
					<td>
						<dw:TranslateLabel ID="TranslateLabel6" runat="server" Text="Rating" />
					</td>
					<td>
						<select id="rating" runat="server" class="std">
                            <option value="0" runat="server"></option>
							<option value="1" runat="server">1</option>
							<option value="2" runat="server">2</option>
							<option value="3" runat="server">3</option>
							<option value="4" runat="server">4</option>
							<option value="5" runat="server">5</option>
						</select>
					</td>
				</tr>
				<tr>
					<td valign="top">
						<dw:TranslateLabel ID="TranslateLabel5" runat="server" Text="Kommentar" />
					</td>
					<td>
						<textarea id="comment" cols="20" rows="5" runat="server"></textarea>
					</td>
				</tr>
			</table>
		</dw:GroupBox>
    </div>
    </form>
</body>
</html>
