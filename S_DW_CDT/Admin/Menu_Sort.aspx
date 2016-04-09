<%@ Page CodeBehind="Menu_Sort.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.Menu_Sort" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>

<%
If request.Form.Item("mode") = "1" Then
%>
	<script language="JavaScript">
		var pid = parseInt('<%=ParentPageID%>');
		if (pid>0){
			parent.right.location = "Paragraph/Paragraph_List.aspx?ID="+pid;
		}else{
			parent.right.location="MyPage/default.aspx";
		}
		parent.left.document.getElementById("Sort_<%=PageParentPageID%>"); 
		parent.left.UpdateMenuEntry(<%=ParentPageID%>);
	</script>
<% Else	%>
	<HTML>
	<HEAD>
	<META HTTP-EQUIV="Content-Type" CONTENT="text/html;charset=UTF-8">
	<TITLE></TITLE>
	<link rel="STYLESHEET" type="text/css" href="Stylesheet.css">
	<script language="JavaScript">
	function checkInput(theForm) {
		document.getElementById('rang').Pagesort.multiple = true;
		setTimeout("submitit()", 200);
	}

	function submitit(){
		for (i = 0; i < document.getElementById('rang').Pagesort.length; i++) {
			document.getElementById('rang').Pagesort.options[i].selected = true;
		}
		document.getElementById('rang').action = "Menu_sort.aspx";
		document.getElementById('rang').submit();
	}
	
	function MoveUp(){
		ID = document.getElementById('rang').Pagesort.selectedIndex
		if(ID != 0)
		{
			val1 = document.getElementById('rang').Pagesort[ID - 1].value;
			val2 = document.getElementById('rang').Pagesort[ID - 1].text;
			document.getElementById('rang').Pagesort.options[ID - 1] = new Option(document.getElementById('rang').Pagesort[ID].text, document.getElementById('rang').Pagesort[ID].value);
			document.getElementById('rang').Pagesort.options[ID] = new Option(val2, val1);
			document.getElementById('rang').Pagesort.options[ID - 1].selected = true;
			ToggleImage(ID - 1);
		}
	}
	
	function MoveDown(){
		ID = document.getElementById('rang').Pagesort.selectedIndex
		if(ID != document.getElementById('rang').Pagesort.length - 1)
		{
			val1 = document.getElementById('rang').Pagesort[ID + 1].value;
			val2 = document.getElementById('rang').Pagesort[ID + 1].text;
			document.getElementById('rang').Pagesort.options[ID + 1] = new Option(document.getElementById('rang').Pagesort[ID].text, document.getElementById('rang').Pagesort[ID].value);
			document.getElementById('rang').Pagesort.options[ID] = new Option(val2, val1);
			document.getElementById('rang').Pagesort.options[ID + 1].selected = true;
			ToggleImage(ID + 1);
		}
	}
	
	function ToggleImage(ID){
		if(ID > -1){
			if(ID == 0){
				document.images["up"].src = "/Admin/images/Collapse_inactive.GIF";
				document.images["up"].alt = "";
			}else{
				document.images["up"].src = "/Admin/images/Collapse.GIF";
				document.images["up"].alt = "<%=Translate.JsTranslate("Flyt op")%>";
			}
		
			if(ID == document.getElementById('rang').Pagesort.length - 1){
				document.images["down"].src = "/Admin/images/Expand_inactive.GIF";
				document.images["down"].alt = "";
			}else{
				document.images["down"].src = "/Admin/images/Expand_active.GIF";
				document.images["down"].alt = "<%=Translate.JsTranslate("Flyt ned")%>";
			}
		}else{
			document.images["up"].src = "/Admin/images/Collapse_inactive.GIF";
			document.images["up"].alt = "";
			document.images["down"].src = "/Admin/images/Expand_inactive.GIF";
			document.images["down"].alt = "";
		}
	}
	</script>
<%= Gui.MakeHeaders(translate.Translate("Sorter %%", "%%", translate.Translate("sider")), translate.Translate("Sortering"), "Javascript")%>
	</HEAD>
	<BODY onLoad="document.getElementById('rang').Pagesort.multiple = false;">
<form method="post" name="rang">
<%= Gui.MakeHeaders(translate.Translate("Sidesortering"), translate.Translate("Sortering"), "html")%>
<table border="0" cellpadding="0" cellspacing=0 class=tabTable style="height:200px;">
<input type=hidden name="ParentPageID" value="<%=ParentPageID%>">
<input type=hidden name="AreaID" value="<%=AreaID%>">
<input type=hidden name="Mode" value="1">
	<tr>
		<td valign=top>
			<DIV ID=Tab1><br>
			<%=Gui.Groupboxstart(Translate.Translate("Sider"))%>
			<table>
		  		<tr>
					<td>&nbsp;
						<select size=<%=intRecordcount + 1%> name=Pagesort style="width: 400px;" onChange="ToggleImage(this.selectedIndex);" class=std>
							<%= strSelectList %>
						</select>
					</td>
					<td>
					<a href="JavaScript:void(0);" onmousedown="MoveUp();"><img src="images/Collapse.GIF" width="16" height="16" alt="" border="0" name="up"></a>
					<br>
					<a href="JavaScript:void(0);" onmousedown="MoveDown();"><img src="images/Expand_active.GIF" width="16" height="16" alt="" border="0" name="down"></a>
		  			</td>
				</tr>
			</table>
			<%=Gui.Groupboxend%>

			</DIV>
		</td>
	</tr>
	<tr>
		<td align=right>
			<table>
				<tr>
					<td><%= Gui.Button(Translate.Translate("OK"), "checkInput(document.getElementById('rang'));", 0)%></td>
					<td><%=Gui.Button(Translate.Translate("Annuller"), "history.back();", 0)%></td>
					<%=Gui.HelpButton("page_sort", "gui.navigation.sort")%>
				</tr>
			</table>
		</td>
	</tr>
</table>
	</form>
</BODY>
</HTML>
<script language="JavaScript">
	document.getElementById('rang').Pagesort.selectedIndex = 0;
	ToggleImage(0);
</script>

<%	
End If
Translate.GetEditOnlineScript()
%>
