<%@ Page ValidateRequest="false" codebehind="Paragraph_List.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.Paragraph_List" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<HTML>
	<HEAD>
		<META HTTP-EQUIV="Content-Type" CONTENT="text/html;charset=UTF-8">
		<TITLE></TITLE>
		<link rel="STYLESHEET" type="text/css" href="../Stylesheet.css">
		<script language="JavaScript">
			InternalAllID = '<%=Request.QueryString("Caller")%>';
			mac = false;
			if(navigator.appVersion.toLowerCase().indexOf("mac") > 0){
				mac = true;
			}

			function ParagraphDelete(ID, PageID, ParagraphName, PageName){
				if (confirm("<%=Translate.JsTranslate("Slet %%?", "%%", Translate.JsTranslate("afsnit"))%>\n(" + ParagraphName + ")")){
					location = "Paragraph_Delete.aspx?ID=" + ID + "&PageID=" + PageID + "&ParagraphName=" + ParagraphName + "&PageName=" + PageName;
				}
			}

			function ParagraphDeleteAll(PageID, PageName){
				SelectedIDList = ""
			    for(var i=0;i<ParagraphListForm.elements.length;i++) {
					if(ParagraphListForm.elements[i].name=="SelectedID" && ParagraphListForm.elements[i].checked) {
						if(SelectedIDList=="") {
							SelectedIDList = ParagraphListForm.elements[i].value;
						} else {
							SelectedIDList = SelectedIDList + "," + ParagraphListForm.elements[i].value;
						}
					}
				}
				if(SelectedIDList=="") {
					alert('<%=Translate.JsTranslate("Vælg %%!", "%%", Translate.JsTranslate("afsnit",1))%>')
				} else {
					if (confirm('<%=Translate.JsTranslate("Slet %%?", "%%", Translate.JSTranslate("afsnit",1))%>')){
						location = "Paragraph_Delete.aspx?ID=" + SelectedIDList + "&PageID=" + PageID + "&PageName=" + PageName
					}
				}				
			}

			function SelectAll(obj){
			    for(var i=0;i<ParagraphListForm.elements.length;i++) {
					if(ParagraphListForm.elements[i].name=="SelectedID") {
						ParagraphListForm.elements[i].checked = obj.checked;
					}
				}
			}

			function ParagraphMove(ID, PageName) {
			}

			//
			// COPY PARAGRAPH AND MOVE PARAGRAPH
			//
			function ParagraphCopy(ID, PageName, AreaID) {
				copyWindow = window.open("../Menu.aspx?CopyID=" + ID + "&ShowTrashBin=no&Action=CopyParagraph&AreaID=" + AreaID, "_new", "resizable=yes,scrollbars=auto,toolbar=no,location=no,directories=no,status=yes,width=250,height=450,top=155,left=202");
			}

			function ParagraphMove(ID, PageName, AreaID) {
				moveWindow = window.open("../Menu.aspx?MoveID=" + ID + "&ShowTrashBin=no&Action=MoveParagraph&AreaID=" + AreaID, "_new", "resizable=yes,scrollbars=auto,toolbar=no,location=no,directories=no,status=no,width=250,height=450,top=155,left=202");
			}
			//

			function ParagraphMoveAll(AreaID) {
				ID = 1
				PageName=""
				SelectedIDList = ""
			    for(var i=0;i<ParagraphListForm.elements.length;i++) {
					if(ParagraphListForm.elements[i].name=="SelectedID" && ParagraphListForm.elements[i].checked) {
						if(SelectedIDList=="") {
							SelectedIDList = ParagraphListForm.elements[i].value;
						} else {
							SelectedIDList = SelectedIDList + "," + ParagraphListForm.elements[i].value;
						}
					}
				}
				if(SelectedIDList=="") {
					alert('<%=Translate.JsTranslate("Vælg afsnit")%>')
				} else {
					moveWindow = window.open("../Menu.aspx?MoveID=" + SelectedIDList + "&Action=MoveParagraph&MoveFromPageID=<%=PageID%>&AreaID=" + AreaID, "_new", "resizable=yes,scrollbars=auto,toolbar=no,location=no,directories=no,status=no,width=250,height=450,top=155,left=202");
				}
			}

			function ParagraphCopyAll(AreaID) {
				ID = 1
				PageName=""
				SelectedIDList = ""
			    for(var i=0;i<ParagraphListForm.elements.length;i++) {
					if(ParagraphListForm.elements[i].name=="SelectedID" && ParagraphListForm.elements[i].checked) {
						if(SelectedIDList=="") {
							SelectedIDList = ParagraphListForm.elements[i].value;
						} else {
							SelectedIDList = SelectedIDList + "," + ParagraphListForm.elements[i].value;
						}
					}
				}
				//alert(SelectedIDList);
				//return false;
				if(SelectedIDList=="") {
					alert('<%=Translate.JsTranslate("Vælg afsnit")%>')
				} else {
					moveWindow = window.open("../Menu.aspx?CopyID=" + SelectedIDList + "&Action=CopyParagraph&AreaID=" + AreaID, "_new", "resizable=yes,scrollbars=auto,toolbar=no,location=no,directories=no,status=no,width=250,height=450,top=155,left=202");
				}
				
			}

			function movepage(ID, AreaID){
				movepageWindow = window.open("../Menu.aspx?MoveID=" + ID + "&Action=Move&AreaID=" + AreaID, "_new", "resizable=yes,scrollbars=auto,toolbar=no,location=no,directories=no,status=no,width=200,height=350,top=155,left=202");
				hideNow();
			}

			hide = true;
			function doNotHide(){
				hide = false;
			}

			function hideMenu(){
				hide = true;
				setTimeout("doTheHide()", 2500);
			}

			function doTheHide(){
				if(hide){
					document.getElementById('Rmenu').style.display = 'none';
					hide = false;
				}
			}

			function hideNow(){
				document.getElementById('Rmenu').style.display = 'none';
			}

			function FieldSize(){
				var height = document.body.clientHeight;
				height = height-140
				if(height > 425){
					height = 425;
				}
			}

			function SelectParagraph(ParagraphID, PageID, ParagraphHeader) {
				top.opener.document.getElementById("Link_" + InternalAllID).value = ParagraphHeader;
				top.opener.document.getElementById(InternalAllID).value = "Default.aspx?ID=" + PageID + "#" + ParagraphID;
				top.close();
			}
			
			function SelectParagraphID(ParagraphID) {
            alert(ParagraphID);
            alert(top.opener);
				top.opener.document.getElementById("ParagraphGlobalID").value = ParagraphID;
				top.opener.AddGlobal();
				top.close();
			}
			
			function AddGlobal() {
				location='Paragraph_AddGlobal.aspx?ParagraphPageID=' + <%= PageID.ToString %> + '&ParagraphGlobalID=' + document.getElementById("ParagraphGlobalID").value
			}
			
			function ins_mover(pid){
				document.getElementById("i" + pid).src='../images/nothing.gif'
			}
			function ins_mout(pid){
				document.getElementById("i" + pid).src='../images/ins.gif'
			}
			function ins_clk(intSort){
				if(parseInt(intSort) != "NaN"){
					intSort = parseInt(intSort);
				}
				else{
					intSort = 1;
				}
				location = 'paragraph_edit.aspx?PageID=<%=PageID%>&NewSort=' + intSort;
			}

			function PopupGroupChooser(){
				var path = '/Admin/Module/ContentLink/ContentGroups.aspx?PageID=<%=PageID%>';
				window.open(path,'myWindow','height=400, width=620');
			}
			
			function DeleteContentGroupRelation(name,id){
				var message = '<%=Translate.Translate("Slet")%> ' + name + '?';
				if(confirm(message)){
					document.location = '/Admin/Paragraph/Paragraph_List.aspx?Tab=2&ID=<%=PageID%>&DetachGroup=' + id;
				}
			}
		</script>
		
	</HEAD>
	<%
	Dim tabs as string = Translate.Translate("Afsnit",1) 
	%>
	<BODY onmouseup="hideNow();" onload="FieldSize();" rightmargin="0">
		<span id="bodyheight">
		<%=Gui.MakeHeaders(Translate.Translate("Sideindhold - %%", "%%", Server.HtmlEncode(title.Replace("&quot;", """"))), tabs, "all")%>  
		<table border="0" cellpadding="0" cellspacing="0" class="tabTable">
		<form name="ParagraphListForm" ID="Form1">
		<input type="hidden" name="ParagraphGlobalID" value="0" ID="ParagraphGlobalID">
		<tr><td valign=top>
		<div id="Tab1" style="display:inherit;width:598;">
		<table border="0" cellpadding="0" width="598" height=100%>
		<%=GetParagraphList()%>
		<% If msg <> "" Then %>
			<tr>
				<td colspan="6"><%=msg%></td>
		    </tr>
		<% End If %>
		</TABLE>
		</div>
		</td></tr>
		<%If Request.QueryString("mode") <> "browse" Then%>
		<tr>
			<td align="right" valign="bottom" id="functionsbutton">
				<table>
					<tr>
						<% If ApprovalType > 0 And ApprovalStep > -1 Then%>
							<%
							Dim Disabled as Boolean = False
							If ApprovalStep > 0 Then
								Disabled = True
							End If
							%>
							
							<td><%=Gui.Button(Translate.Translate("Start godkendelse"), "location='../Module/Workflow/WorkflowApprove.aspx?VCP=True&PageID=" & PageID & "'", 0, Disabled)%> </td>
						<% End If%>
						<% If no > 1 Then%>
							<td><%=Gui.Button(Translate.Translate("Sorter"), "window.open('Paragraph_SortAll.aspx?PageID=" & PageID & "', '_ParagraphSort', 'resizable=yes,scrollbars=yes,toolbar=no,location=no,directories=no,status=no,width=350,height=500,top=155,left=202');", 0)%> </td>
						<% End If%>
						<td id="popup"><%=Gui.Button(Translate.Translate("Side"), "top.left.showMenu(" & PageID & ", document.getElementById('Rmenu'), document, event.clientY+15, event.clientX)", 0)%></td>
						<% If Base.HasVersion("18.10.1.0") And Not Base.HasAccess("Inherit", "") Then%>
							<td><%=Gui.Button(Translate.Translate("Indsæt %%", "%%", Translate.Translate("global element")), "window.open('/Admin/menu.aspx?Action=Internal&ShowTrashBin=no&showparagraphs=on&caller=GlobalElement&AreaID=" & AreaID.ToString & "', '_new', 'resizable=yes,scrollbars=auto,toolbar=no,location=no,directories=no,status=no,width=823,height=450,top=155,left=202');", 0)%></td>
						<% End If%>
						<td><%=Gui.Button(Translate.Translate("Nyt afsnit"), "window.location='paragraph_edit.aspx?PageID=" & PageID & "';", 0)%></td>
						<%=Gui.HelpButton("paragraph", "page.paragraph.list")%>
					</tr>
				</table>
			</td>
		</tr>
		<%End If%>
		</form>
		</table>
		</span>
			
		<div id="Rmenu" class="altMenu" style="display:none;"></div>
	</BODY>
</HTML>
<%=Gui.SelectTab()%>
<%Translate.GetEditOnlineScript()%>
