<%@ Page CodeBehind="Report_Letter_Compare.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.Report_Letter_Compare" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="System.Data" %>
<script language="VB" runat="Server">

</script>

<%

'''' Stats '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

Dim cnStatistics As IDbConnection = Database.CreateConnection("NewsletterExtended.mdb")
Dim cmdStatistics As IDbCommand = cnStatistics.CreateCommand
Dim strCategoryID As String = Cstr(Request.Item("ID"))
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

%>
<SCRIPT LANGUAGE="JavaScript">
<!--
function checkinput(){
	if(document.getElementById('ExtranetGroupName').value == ''){
		alert('<%=Translate.JsTranslate("Angiv brugergruppenavn")%>.');
		document.getElementById('ExtranetGroupName').focus();
		return false;
	}
	
	for(i = 0; i < document.getElementById('UsersInGroup').options.length; i++) {
		document.getElementById('UsersInGroup').options[i].selected = true;
	}
	return true
}

function move(fbox, tbox) {
	var arrFbox = new Array();
	var arrTbox = new Array();
	var arrLookup = new Array();
	var i;
	for (i = 0; i < tbox.options.length; i++) {
		arrLookup[tbox.options[i].text] = tbox.options[i].value;
		arrTbox[i] = tbox.options[i].text;
	}
	var fLength = 0;
	var tLength = arrTbox.length;
	for(i = 0; i < fbox.options.length; i++) {
		arrLookup[fbox.options[i].text] = fbox.options[i].value;
		if (fbox.options[i].selected && fbox.options[i].value != "") {
			arrTbox[tLength] = fbox.options[i].text;
			tLength++;
		}else{
			arrFbox[fLength] = fbox.options[i].text;
			fLength++;
	   }
	}
	arrFbox.sort();
	arrTbox.sort();
	fbox.length = 0;
	tbox.length = 0;
	var c;
	for(c = 0; c < arrFbox.length; c++) {
		var no = new Option();
		no.value = arrLookup[arrFbox[c]];
		no.text = arrFbox[c];
		fbox[c] = no;
	}
	for(c = 0; c < arrTbox.length; c++) {
		var no = new Option();
		no.value = arrLookup[arrTbox[c]];
		no.text = arrTbox[c];
		tbox[c] = no;
   }
   Update();
}

function Update() {
	var strGraphLetters = "";
	for(x = 0; x < document.getElementById('GroupForm').UsersInGroup.options.length; x++) {
		strGraphLetters += document.getElementById('GroupForm').UsersInGroup.options[x].value;
		
		if(x+1 < document.getElementById('GroupForm').UsersInGroup.options.length){
			strGraphLetters += ",";
		}
   }
   
   document.getElementById("GraphFrame").src="Report_Category_Graph.aspx?Newsletters=" + strGraphLetters;
      
}

//-->
</SCRIPT>

<link rel="STYLESHEET" type="text/css" href="/admin/Stylesheet.css">


<!-- TAB2 ------------------------------------------------------------------------------------------------------------------------------- -->

<td valign="top">
<form action="Report_Letter_Compare.aspx" id="GroupForm" name="GroupForm" method="post">
									<table border="0" cellpadding="0" cellspacing="0" width="512px">
									<tr>
		<td valign=top rowspan=4><img src="/Admin/Images/Icons/Statv2_Report_heading.gif" width="32" height="36" alt="" border="0"></td>
										
										<td colspan="3">
										
											<table border="0" cellpadding="0" cellspacing="0">
												<tr>
													<td width="170"><%=Translate.Translate("Valgte nyhedsbreve")%></td>
													<td>&nbsp;</td>
													<td><%=Translate.Translate("Mulige")%></td>
												</tr>
												<tr>
													<td rowspan="2">
														<select name="UsersInGroup" id="UsersInGroup" multiple class="std" style="width:225px;height:140px;" ondblclick="move(document.getElementById('GroupForm').UsersInGroup,document.getElementById('GroupForm').UsersNotInGroup)"></select>
													</td>
													<td valign="bottom" width="30">&nbsp;<img src="/admin/images/MultiSelectMoveLeft_off.gif" onClick="move(document.getElementById('GroupForm').UsersNotInGroup,document.getElementById('GroupForm').UsersInGroup)" onmousedown="this.src='/admin/images/MultiSelectMoveLeft_press.gif';" onmouseup="this.src='/admin/images/MultiSelectMoveLeft_off.gif';"></td>
													<td rowspan="2">
														<select name="UsersNotInGroup" id="UsersNotInGroup" multiple class="std" style="width:225px;height:140px;" ondblclick="move(document.getElementById('GroupForm').UsersNotInGroup,document.getElementById('GroupForm').UsersInGroup)">
															<%=GetLetters(strCategoryID)%>
														</select>
													</td>
												</tr>
												<tr>
													<td valign="top">&nbsp;<img src="/admin/images/MultiSelectMoveRight_off.gif" onClick="move(document.getElementById('GroupForm').UsersInGroup,document.getElementById('GroupForm').UsersNotInGroup)" onmousedown="this.src='/admin/images/MultiSelectMoveRight_press.gif';" onmouseup="this.src='/admin/images/MultiSelectMoveRight_off.gif';"></td>
												</tr>
											</table>
										</td>
									</tr>
								</table>
</form>
									

<table width=512>
	<tr>
		<td valign=top rowspan=4><img src="/Admin/Images/Icons/Statv2_Report_heading.gif" width="32" height="36" alt="" border="0"></td>
	</tr>
	<tr>
		<td width=402><strong style="color:#003366;"><%=Translate.Translate("Antal Breve Åbnet i perioden")%></strong></td>
		<td align=right style="width:75px;"></td>
	</tr>
	<tr>
		<td style="background-color:#CCCCCC;height:1px;width:100%" colspan=2></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td></td>
		<td colspan=2>
		
	            <iframe border="0" name="GraphFrame" id="GraphFrame" align="left" marginWidth="0" marginHeight="0" src="Report_Category_Graph.aspx" frameBorder="0" width="100%" scrolling="no" height="350">
    	        </iframe>
		
										
									</TD>
								</TR>
							</TABLE>
						</TD>
					</TR>
					
					<!-- Make space --->
					<tr><td><br></td></tr>								
					
					<%
						cmdStatistics.Dispose()
						cnStatistics.Dispose()
					%>
						</TD>
					</TR>
				</TABLE>
		</TD>
	</TR>
</TABLE>

<%
Translate.GetEditOnlineScript()
%>
