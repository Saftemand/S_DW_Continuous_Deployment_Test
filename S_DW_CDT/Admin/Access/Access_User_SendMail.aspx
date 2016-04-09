<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Page CodeBehind="Access_User_SendMail.aspx.vb" Language="vb" validateRequest="false" AutoEventWireup="false" Inherits="Dynamicweb.Admin.Access_User_SendMail" codePage="65001"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<TITLE><%=Translate.JSTranslate("Send %%", "%%", Translate.JSTranslate("brugeroplysninger"))%></TITLE>
		<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
		<META NAME="Cache-control" CONTENT="no-cache">
		<META HTTP-EQUIV="Cache-control" CONTENT="no-cache">
		<META HTTP-EQUIV="Expires" CONTENT="Tue, 20 Aug 1996 14:25:27 GMT">
		<link rel="STYLESHEET" type="text/css" href="../Stylesheet.css">

		<script type="text/javascript" src="/Admin/Editor/fckeditor.js"></script>
		
		<script type="text/javascript">
		var browserWidth = 0, browserHeight = 0;
		function GetWinSize() {
			
			if( typeof( window.innerWidth ) == 'number' ) {
				//Non-IE
				browserWidth = window.innerWidth;
				browserHeight = window.innerHeight;
			} else if( document.documentElement && ( document.documentElement.clientWidth || document.documentElement.clientHeight ) ) {
				//IE 6+ in 'standards compliant mode'
				browserWidth = document.documentElement.clientWidth;
				browserHeight = document.documentElement.clientHeight;
			} else if( document.body && ( document.body.clientWidth || document.body.clientHeight ) ) {
				//IE 4 compatible
				browserWidth = document.body.clientWidth;
				browserHeight = document.body.clientHeight;
			}
		}

		function ResizeGrowWin(iWidth, iHeight) {
			GetWinSize();
			var zeroHeight = (parseInt(iHeight) - parseInt(browserHeight));
	
			<%If stepCnt = 2 Then%>
			zeroHeight = (parseInt(iHeight) - parseInt(browserHeight));
			if (zeroHeight == -980) {
				zeroHeight = 1;
			}	
			<%End If%>

	
			if (zeroHeight > 0) {
				window.resizeBy(iWidth, iHeight); 
			} 
			self.focus(); 	
		}		
		
		function validateEmail( email ){
			var regExp = /^[\w\-_]+(\.[\w\-_]+)*@[\w\-_]+(\.[\w\-_]+)*\.[a-z]{2,4}$/i;
			return regExp.test( email );
		}
		
				
		function doNothing() {
		}
		
		function SendMailStep(method, submitForm) {
		    
			var subjectControl = document.getElementById("Form1").elements["MailTemplateSubject"];
			if (subjectControl != null && subjectControl.value == "")
			{
				alert("<%=Translate.JsTranslate("Der skal angives en værdi i: %%", "%%", Translate.JsTranslate("Subject"))%>");
				subjectControl.focus();
				return false;
			}
			
		    //var MailTemplateElem = document.getElementById("MailTemplate");
		    var MailTemplateElem = document.getElementById("FM_MailTemplate");
		    if (MailTemplateElem.value == "") {
		        alert("<%=Translate.JsTranslate("Vælg_template")%>");
				return false;
		    }

			if(!validateEmail(document.forms[0].MailTemplateFromEmail.value)){
				document.forms[0].MailTemplateFromEmail.focus();
				alert("<%=Translate.JsTranslate("Angiv gyldig E-mail adresse")%>");
				return false;
			}
			var stepInt = document.forms[0].stepCnt.value;
			var stepCnt;
			
			if (method == "ADD") {
				stepCnt = parseInt(stepInt) + 1;
			} else {
				stepCnt = parseInt(stepInt) - 1;
			}	
			
			<%If stepCnt <> 2 Then%>
			disableSelectors(false);
			<%End If%>
			
			document.forms[0].stepCnt.value = stepCnt;
			
			if (submitForm == true) {
			
				document.forms[0].action = '';
				document.forms[0].submit();
			} else {
				document.location.href = "Access_User_SendMail.aspx?UserID=<%=UserIDReq%>";
			}	
		}
		
		function doCancel(goType) {
			if (goType == 1) {
				window.close();
			}	
		}
		
		function goBack(goType) {
			if (goType == 1) {
				SendMailStep('MINUS', false);
			}	
		}		
		
		function disableSelectors(setting) {
			document.getElementById('FM_MailTemplate').disabled = setting;
			document.getElementById('MailTemplateEncoding').disabled = setting;
		}
				
		function initPage() {
		    var ResizeH = 360;
			<%If Base.GetGs("/Globalsettings/Settings/TextEditor/EditorVersion") = "EditorNew" %>
		        ResizeH = 360;
		    <%Else%> 
		        ResizeH = 400;
		    <%End If%>

			<%If stepCnt = 1 Then%>
		        ResizeGrowWin(0, ResizeH);
    			disableSelectors(true);
			<%End If%>

			<%If stepCnt = 2 Then%>
			    ResizeGrowWin(0, -360);
			<%End If%>
		}
		</script>
	</HEAD>
	<body bottommargin="5" leftmargin="5" topmargin="5" rightmargin="5" onload="initPage();">
		<%=Gui.MakeHeaders("", Translate.Translate("Send %%", "%%", Translate.Translate("brugeroplysninger")), "")%>
		<table border="0" cellpadding="2" cellspacing="0" class="tabTable">
			<tr>
				<td valign="top">
					<form id="Form1" method="post" runat="server" action="Access_User_SendMail.aspx">
						<input type=hidden name=stepCnt value="<%=stepCnt%>">
						<asp:textbox id="EmailField" runat="server" style="DISPLAY:none"></asp:textbox>
						<div id="Tab1">
							<br>
							<div id="TemplateSelector">
								<%If stepCnt <> 2 Then%>
								<%=Gui.GroupBoxStart(Translate.Translate("E-mail"))%>
								<table cellpadding="2" cellspacing="0">
									<tr>
										<td width="170"><%=Translate.Translate("Emne")%></td>
										<td><input type="text" name="MailTemplateSubject" maxlength="255" class="std" value="<%=MailTemplateSubject%>"></td>
									</tr>
									<tr>
										<td width="170"><%=Translate.Translate("Afsender navn")%></td>
										<td><input type="text" name="MailTemplateFromName" maxlength="255" class="std" value="<%=MailTemplateFromName%>"></td>
									</tr>
									<tr>
										<td width="170"><%=Translate.Translate("Afsender e-mail")%></td>
										<td><input type="text" name="MailTemplateFromEmail" maxlength="255" class="std" value="<%=MailTemplateFromEmail%>"></td>
									</tr>
									<tr>
										<td width="170"><%=Translate.Translate("Template - %%", "%%", Translate.Translate("E-mail"))%></td>
										<td><%=Gui.FileManager(MailTemplate, "Templates/ExtranetExtended", "MailTemplate")%></td>
									</tr>
									<tr>
										<td width="170"><%=Translate.Translate("Encoding")%></td>
										<td><%=Gui.EncodingList(MailTemplateEncoding, "MailTemplateEncoding", True)%></td>
									</tr>
								</table>
								<%=Gui.GroupBoxEnd%>
								<%End If%>
							</div>
							<%
					Dim heightTmp as string
					%>
							<%If stepCnt = 1 OR stepCnt = 2 Then%>
							<%=Gui.GroupBoxStart(Translate.Translate("E-mail"))%>
							<%
							If Base.GetGs("/Globalsettings/Settings/TextEditor/EditorVersion") = "EditorNew" Then
								heightTmp = 350
							Else
							    heightTmp = 0
							End If
							%>
							<%If stepCnt = 1 Then%>
							<table cellpadding="2" cellspacing="0"  width="100%">
								<tr>
									<td><%=Gui.Editor("MailTemplateText", 0, heightTmp, MailTemplateText)%></td>
								</tr>
							</table>
							<%End If%>
							<%If stepCnt = 2 Then%>
							<table cellpadding="2" cellspacing="0">
								<tr>
									<td><asp:Literal id="mailerStatus" runat="server"></asp:Literal></td>
								</tr>
							</table>
							<%End If%>
							<%=Gui.GroupBoxEnd%>
							<%End If%>
							<p align="right">
								<table border="0" cellpadding="2">
									<TBODY>
										<tr>
											<%If stepCnt = 2 Then%>
											<td><%=Gui.Button(Translate.Translate("OK"), "doNothing()", 0, true)%></td>
											<%Else%>
											<td><%=Gui.Button(Translate.Translate("OK"), "SendMailStep('ADD', true)", 0)%></td>
											<%End If%>
											<%If stepCnt = 0 OR stepCnt = 2 Then%>
											<td><%=Gui.Button(Translate.Translate("Tilbage"), "goBack(0)", 0, true)%></td>
											<%Else%>
											<td><%=Gui.Button(Translate.Translate("Tilbage"), "goBack(1)", 0)%></td>
											<%End If%>
											<%If stepCnt = 2 Then%>
											<td><%=Gui.Button(Translate.Translate("Luk"), "doCancel(1)", 0)%></td>
											<td><%=Gui.Button(Translate.Translate("Annuller"), "doCancel(0)", 0, true)%></td>
											<%Else%>
											<td><%=Gui.Button(Translate.Translate("Luk"), "doCancel(0)", 0, true)%></td>
											<td><%=Gui.Button(Translate.Translate("Annuller"), "doCancel(1)", 0)%></td>
											<%End If%>
											<%=Gui.HelpButton("", "modules.usermanagement.general.user.password.mail")%>
											<P></P>
											<DIV></DIV>
					</form>
				</td>
			</tr>
		</table>
		</P></DIV></TR></TBODY></TABLE>
	</body>
</HTML>
