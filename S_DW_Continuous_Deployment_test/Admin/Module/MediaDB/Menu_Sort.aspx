<%@ Page Language="vb" AutoEventWireup="false" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>



<%
Dim sql As String
Dim i As Integer
Dim AreaID As String
Dim SQLStmt As String
Dim MediaDBGroupParentID As Integer


Dim MediaConn As IDbConnection = Database.CreateConnection("DWMedia.mdb")
Dim cmdMedia As IDbCommand = MediaConn.CreateCommand

If CDbl(Request.Form("mode")) = 1 Then

	For i = 1 To Request.Form.GetValues("MediaDBGroupSort").Length
		SQLStmt = "UPDATE MediaDBGroup "
		SQLStmt = SQLStmt & "SET MediaDBGroupSort=" & i & " "
		SQLStmt = SQLStmt & " WHERE MediaDBGroupID=" & request.Form.GetValues("MediaDBGroupSort").GetValue(i - 1)
		cmdMedia.CommandText = SQLStmt
		cmdMedia.ExecuteNonQuery()
	Next 

	MediaDBGroupParentID = request.Form("MediaDBGroupParentID")
	AreaID = request.Form.Item("AreaID")
	%>

	<script language="JavaScript">
		parent.location = "menu.aspx?ID=<%=MediaDBGroupParentID%>";
	</script>
<%Else
	If Not IsNothing(request.QueryString("ParentID")) Then
		MediaDBGroupParentID = request.QueryString("ParentID")
	Else
		MediaDBGroupParentID = 0
	End If
	%>
	<HTML>
	<HEAD>
	<META HTTP-EQUIV="Content-Type" CONTENT="text/html;charset=UTF-8">
	<link rel="STYLESHEET" type="text/css" href="../../Stylesheet.css">
	<script language="JavaScript">
	function checkInput(theForm) {
		document.getElementById('rang').MediaDBGroupSort.multiple = true;
		setTimeout("submitit()", 200);
	}

	function submitit(){
		for(i = 0; i < document.getElementById('rang').MediaDBGroupSort.length; i++){
			document.getElementById('rang').MediaDBGroupSort.options[i].selected = true;
		}
		document.getElementById('rang').action = "Menu_sort.aspx";
		document.getElementById('rang').submit();
	}
	
	function MoveUp(){
		ID = document.getElementById('rang').MediaDBGroupSort.selectedIndex
		if(ID != 0)
		{
			val1 = document.getElementById('rang').MediaDBGroupSort[ID - 1].value;
			val2 = document.getElementById('rang').MediaDBGroupSort[ID - 1].text;
			document.getElementById('rang').MediaDBGroupSort.options[ID - 1] = new Option(document.getElementById('rang').MediaDBGroupSort[ID].text, document.getElementById('rang').MediaDBGroupSort[ID].value);
			document.getElementById('rang').MediaDBGroupSort.options[ID] = new Option(val2, val1);
			document.getElementById('rang').MediaDBGroupSort.options[ID - 1].selected = true;
			ToggleImage(ID - 1);
		}
	}
	
	function MoveDown(){
		ID = document.getElementById('rang').MediaDBGroupSort.selectedIndex
		if(ID != document.getElementById('rang').MediaDBGroupSort.length - 1)
		{
			val1 = document.getElementById('rang').MediaDBGroupSort[ID + 1].value;
			val2 = document.getElementById('rang').MediaDBGroupSort[ID + 1].text;
			document.getElementById('rang').MediaDBGroupSort.options[ID + 1] = new Option(document.getElementById('rang').MediaDBGroupSort[ID].text, document.getElementById('rang').MediaDBGroupSort[ID].value);
			document.getElementById('rang').MediaDBGroupSort.options[ID] = new Option(val2, val1);
			document.getElementById('rang').MediaDBGroupSort.options[ID + 1].selected = true;
			ToggleImage(ID + 1);
		}	
	}
	
	function ToggleImage(ID){
		if(ID > -1){
			if(ID == 0){
				document.images["up"].src = "../../images/Collapse_inactive.gif";
				document.images["up"].alt = "";
			}else{
				document.images["up"].src = "../../images/Collapse.gif";
				document.images["up"].alt = "<%=Translate.JSTranslate("Flyt op")%>";
			}
		
			if(ID == document.getElementById('rang').MediaDBGroupSort.length - 1){
				document.images["down"].src = "../../images/Expand_inactive.gif";
				document.images["down"].alt = "";
			}else{
				document.images["down"].src = "../../images/Expand_active.gif";
				document.images["down"].alt = "<%=Translate.JSTranslate("Flyt ned")%>";
			}
		}else{
			document.images["up"].src = "../../images/Collapse_inactive.gif";
			document.images["up"].alt = "";
			document.images["down"].src = "../../images/Expand_inactive.gif";
			document.images["down"].alt = "";
		}
	}
	</script>
	<%=Gui.MakeHeaders(Translate.Translate("Sorter %%", "%%", Translate.Translate("grupper")), Translate.Translate("Sortering"), "Javascript")%>
	</HEAD>
	<BODY onLoad="document.getElementById('rang').MediaDBGroupSort.multiple = false;">
	<%	
	sql = "SELECT * FROM MediaDBGroup WHERE MediaDBGroupParentID=" & MediaDBGroupParentID & " ORDER BY MediaDBGroupSort  "
	
	Dim adMediaAdapter As IDbDataAdapter = Database.CreateAdapter()
	Dim cb As Object = Database.CreateCommandBuilder(adMediaAdapter)
	Dim dsMedia As DataSet = New DataSet

	cmdMedia.CommandText = SQL
	adMediaAdapter.SelectCommand = cmdMedia
	adMediaAdapter.Fill(dsMedia)

	Dim groupView As DataView = New DataView(dsMedia.Tables(0))
	%>
	<%=Gui.MakeHeaders(Translate.Translate("Sorter %%", "%%", Translate.Translate("grupper")), Translate.Translate("Sortering"), "html")%>
	<table border="0" cellpadding="0" cellspacing=0 class=tabTable style="height:200px;">
	<form method="post" name="rang" id="rang">
	<input type=hidden name="MediaDBGroupParentID" value="<%=MediaDBGroupParentID%>">
	<input type=hidden name="Mode" value="1">
		<tr>
			<td valign=top>
				<DIV ID=Tab1><br>
				<%=GUI.Groupboxstart(Translate.Translate("Grupper"))%>
				<table>
		  			<tr>
						<td>&nbsp;
							<select size=<%=groupView.count + 1%> name=MediaDBGroupSort style="width: 400px;" onChange="ToggleImage(this.selectedIndex);" class=std>
								<%	
								For i = 0 To groupView.count - 1
									%>
									<option value="<%=groupView(i)("MediaDBGroupID")%>"><%=Left(groupView(i)("MediaDBGroupName"),100)%></option>
								<%		
								Next%>
							</select>
						</td>
						<td>
						<a href="JavaScript:void(0);" onmousedown="MoveUp();"><img src="../../images/Collapse.GIF" width="16" height="16" alt="" border="0" name="up"></a>
						<br>
						<a href="JavaScript:void(0);" onmousedown="MoveDown();"><img src="../../images/Expand_active.GIF" width="16" height="16" alt="" border="0" name="down"></a>
		  				</td>
					</tr>
				</table>
				<%=GUI.GroupboxEnd%>
				</DIV>
			</td>
		</tr>
		<tr>
			<td align=right>
				<table cellpadding=0 cellspacing=0 border=0>
					<tr>
						<td><%= Gui.Button(Translate.Translate("OK"), "checkInput(document.getElementById('rang'));", 0)%></td>
						<td width=5></td>
						<td><%=Gui.Button(Translate.Translate("Annuller"), "history.back();", 0)%></td>
						<td width=10></td>
					</tr>
				</table>
			</td>
		</tr>
		</form>
	</table>
	</BODY>
	</HTML>
	<script language="JavaScript">
		document.getElementById('rang').MediaDBGroupSort.selectedIndex = 0;
		ToggleImage(0);
	</script>
<%
End If

mediaConn.Dispose
Translate.GetEditOnlineScript()
%>
