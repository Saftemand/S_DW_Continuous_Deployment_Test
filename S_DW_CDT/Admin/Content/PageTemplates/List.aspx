<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="List.aspx.vb" Inherits="Dynamicweb.Admin.List2" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Import Namespace="Dynamicweb" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
	<title></title>
	<dw:ControlResources ID="ControlResources1" runat="server">
	</dw:ControlResources>
	<link href="List.css" rel="stylesheet" type="text/css" />
	<style id="styleNewPage" type="text/css" runat="server" visible="true">
		.newPage
		{
			display:none;
		}
	</style>
	
	<style id="styleList" type="text/css" runat="server" visible="true">
		.List
		{
			display:none;
		}
	</style>
	
	<script type="text/javascript">
		var ParentPageID = <%=Base.ChkInteger(Base.Request("ParentPageID")) %>;
		var AreaID = <%=Base.Request("AreaID")%>;
		function over(row) {
			row.className = "over";
		}
		function out(row) {
			row.className = "";
		}
		function doClick(id) {
			if (!document.getElementById("styleNewPage")) {
				newPage(id);
			} else {
				location = "../ParagraphList.aspx?PageID=" + id;
			}
		}
		var chosenTemplateID = 0;
		function newPage(id) {
			chosenTemplateID = id;
			dialog.show("NewPageDialog");
			document.getElementById("ChosenTemplateName").innerText = document.getElementById("TemplateName" + id).innerText;
			document.getElementById("PageName").select();
		}
		function newPageCancel() {
			dialog.hide("NewPageDialog");
		}
		function newPageOk() {
			if (document.getElementById("PageName").value.length < 1) {
				alert('<%=Translate.JsTranslate("Der skal angives en værdi i: %%", "%%", Translate.JsTranslate("Navn"))%>');
				document.getElementById("PageName").select();
				return false;
			}
            var __o = new overlay('__ribbonOverlay');
            __o.message('');
            __o.show();
			var pageName = document.getElementById("PageName").value;
			var url = "List.aspx?cmd=createpage&ParentPageID=" + ParentPageID + "&AreaID=" + AreaID + "&TemplateID=" + chosenTemplateID + "&PageName=" + encodeURI(pageName);
			location = url;
		}
		function updateBreadCrumb() {
			if (document.getElementById("PageName").value.length > 0) {
				document.getElementById("BreadcrumbActive").innerText = document.getElementById("PageName").value;
			}
		}
	</script>

</head>
<body>
    <dw:Overlay ID="__ribbonOverlay" runat="server" Message="" ShowWaitAnimation="True" />
	<h1 class="title" id="title" runat="server">
		<dw:TranslateLabel ID="TranslateLabel1" runat="server" Text="Templates" />
	</h1>
	<h2 class="subtitle" id="subtitle" runat="server"><dw:TranslateLabel ID="TranslateLabel2" runat="server" Text="Rediger" />
	</h2>
	<div id="breadcrumb" runat="server">
		</div>
	<div runat="server" id="myContent">
	
	<asp:Repeater ID="TemplatesRepeater" runat="server" EnableViewState="false">
		<HeaderTemplate>
			<table>
				<tr onmouseover="over(this)" onmouseout="out(this)" class="newPage" onclick="newPage(0);">
					<td>
						<div class="hover">
							<table>
								<tr>
									<td valign="top">
										<img src="/Admin/Images/Ribbon/Icons/Paragraph.png" alt="" /></td>
									<td valign="top">
										<h1><a href="#" id="TemplateName0"><dw:TranslateLabel ID="TranslateLabel2" runat="server" Text="Blank page" /></a></h1>
										<h2><dw:TranslateLabel ID="TranslateLabel3" runat="server" Text="Choose this to create a new blank page" /></h2>
									</td>
								</tr>
							</table>
						</div>
					</td>
				</tr>
				<tr class="newPage">
					<td><hr /></td>
				</tr>
		</HeaderTemplate>
		<ItemTemplate>
			<tr onmouseover="over(this)" onmouseout="out(this)" onclick="doClick(<%#Eval("ID")%>);">
				<td>
					<div class="hover">
						<table>
							<tr>
								<td valign="top">
									<img src="/Admin/Images/Ribbon/Icons/document_new.png" alt="" /></td>
								<td valign="top">
									<h1><a href="#" id="TemplateName<%#Eval("ID")%>"><%#Eval("Menutext")%></a></h1>
									<h2><%#Eval("TemplateDescription")%></h2>
									<span class="List">
									<br><br>
									<small><span class="label">Created:</span>
										<%#Eval("CreatedDate", "{0:ddd, dd MMM yyyy HH':'mm':'ss}")%><br>
										<span class="label">Edited:</span>
										<%#Eval("UpdatedDate", "{0:ddd, dd MMM yyyy HH':'mm':'ss}")%></small> </td>
									</span>
							</tr>
						</table>
					</div>
				</td>
			</tr>
		</ItemTemplate>
		<FooterTemplate>
			</table>
		</FooterTemplate>
	</asp:Repeater>
	</div>
	
	<dw:Dialog ID="NewPageDialog" runat="server" Title="Ny side" ShowOkButton="true" ShowCancelButton="true" ShowClose="false" CancelAction="newPageCancel();" OkAction="newPageOk(); ">
		<table border="0" style="width:350px;">
			<tr>
				<td style="width:100px;"><dw:TranslateLabel ID="TranslateLabel10" runat="server" Text="Sidenavn" /></td>
				<td><input type="text" runat="server" id="PageName" name="PageName" class="NewUIinput" maxlength="255" onkeyup="updateBreadCrumb();" />
				</td>
			</tr>
			<tr><td style="height:3px;"></td></tr>
			<tr>
				<td><dw:TranslateLabel ID="TranslateLabel9" runat="server" Text="Skabelon" /></td>
				<td><span id="ChosenTemplateName"></span>
				</td>
			</tr>
		</table>
		<br />
		<br />
	</dw:Dialog>
	
	<div id="BottomInformationBg">
	<table border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td rowspan="2"><img src="/Admin/Images/Ribbon/Icons/document_new.png" alt="" /></td>
			<td align="right"><span class="label"><span id="TemplateCount" runat="server"></span> <dw:TranslateLabel ID="TranslateLabel5" runat="server" Text="Skabeloner" /></span></td>
		</tr>
		<tr>
			<td>&nbsp;</td>
		</tr>
	</table>
	</div>
</body>
<%  Dynamicweb.Backend.Translate.GetEditOnlineScript()
    %>
</html>
