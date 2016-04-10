<%@ Page language="vb" autoeventwireup="false" codebehind="TypeDealerEdit.aspx.vb" inherits="Dynamicweb.Admin.DealerSearch.Backend.TypeDealerEdit" %>
<%@ IMPORT namespace="Dynamicweb" %><%@ IMPORT namespace="Dynamicweb.Backend" %>
<HTML>
<HEAD>
<META http-equiv="Content-Type" content="text/html;charset=UTF-8"><LINK rel="STYLESHEET" type="text/css" href="/Admin/Stylesheet.css">
<script src="/Admin/Module/Common/Validation.js" type="text/javascript"></script>
<%=Gui.MakeHeaders(Translate.JSTranslate("%m% - Rediger %c%","%m%",Translate.JSTranslate("Forhandlersøgning",9),"%c%",Translate.JSTranslate("forhandlertype")), Translate.JSTranslate("Forhandlertype"), "Javascript", false, "")%>
<SCRIPT language="javascript"><!--
			function Show(item) {
				document.all[item].style.display = '';
			}
			function Hide(item) {
				document.all[item].style.display = 'none';
			}
			function ValidateThisForm()
			{
				var form = document.forms[0];
				var controlToValidate = form.elements["Name"];
				ValidateForm(form, controlToValidate, 
					"<%=Translate.JsTranslate("Der skal angives en værdi i: %%", "%%", Translate.JsTranslate("Navn"))%>");
			}
		//-->
</SCRIPT>
</HEAD>
<BODY>
<%=Gui.MakeHeaders(Translate.Translate("%m% - Rediger %c%","%m%",Translate.Translate("Forhandlersøgning",9),"%c%",Translate.Translate("forhandlertype")), Translate.Translate("Forhandlertype"), "Html", false, "")%>
	<TABLE border="0" cellpadding="0" cellspacing="0" class="tabTable" height=100%>
		<FORM action="TypeDealerSave.aspx" method="post">			
			<INPUT type="hidden" name="_ID" id="_ID" value="" runat="server">
			<TR>
				<TD valign="top"><BR>
					<%=Gui.GroupBoxStart(Translate.Translate("Indstillinger"))%>
						<TABLE>
							<TR>
								<TD width="170"><%=Translate.Translate("Navn")%></TD>
								<TD>								
									<INPUT type="text" name="Name" id="Name" value="" class="std" runat="server">
								</TD>
							</TR>
							<TR>
								<TD><%=Translate.Translate("Billede")%></TD>
								<TD><%= Gui.FileManager(Dot, Dynamicweb.Content.Management.Installation.ImagesFolderName, "Dot", "swf,jpg")%>
								</TD>
							</TR>
							<TR>
								<TD><%=Translate.Translate("MouseOver grafik")%>
								</TD>
								<TD><%= Gui.FileManager(DotRollover, Dynamicweb.Content.Management.Installation.ImagesFolderName, "DotRollover", "swf,jpg")%>
								</TD>
							</TR>
						</TABLE>
					<%=Gui.GroupBoxEnd()%>
					<DIV id="hide" style="display: none;">
					<%=Gui.GroupBoxStart(Translate.Translate("Handlinger"))%>
						<TABLE>
							<TR valign="top">
								<TD width="170"><STRONG>onmouseover</STRONG>
								</TD>
								<TD>									
									<INPUT type="radio" class="clean" <%=Base.IIf(ActionRolloverID=1,"checked","") %>OnClick="javascript:Hide('RolloverText');" name="ActionRolloverID" id="radio" value="1"><%=Translate.Translate("Intet")%><BR/>									
									<INPUT type="radio" class="clean" <%=Base.IIf(ActionRolloverID=2,"checked","") %>OnClick="javascript:Hide('RolloverText');" name="ActionRolloverID" id="radio" value="2"><%=Translate.Translate("Vis navn")%><BR/>									
									<INPUT type="radio" class="clean" <%=Base.IIf(ActionRolloverID=3,"checked","") %>OnClick="javascript:Show('RolloverText');" name="ActionRolloverID" id="radio" value="3"><%=Translate.Translate("Vis tekst")%><BR/><SPAN id='RolloverText' style='display:<%=Base.IIf(ActionRolloverID=3,"", "none")%>; padding-left:25px;'>									
									<INPUT type="text" name="ActionRolloverText" value="<%=ActionRolloverText%>" class="std"></SPAN>
								</TD>
							</TR>
							<TR valign="top">
								<TD width="170"><STRONG>onclick</STRONG>
								</TD>
								<TD>									
									<INPUT type="radio" class="clean" <%=Base.IIf(ActionClickID=1,"checked","") %>OnClick="javascript:Hide('RolloverFile');" name="ActionClickID" id="radio" value="1"><%=Translate.Translate("Vis detaljer", 1)%><BR/>									
									<INPUT type="radio" class="clean" <%=Base.IIf(ActionClickID=2,"checked","") %>OnClick="javascript:Hide('RolloverFile'); Show('RolloverURL');" name="ActionClickID" id="radio" value="2"><%=Translate.Translate("URL")%><BR/><SPAN id="RolloverURL" style="display:<%=Base.IIf(ActionClickID=2,"", "none")%>; padding-left:25px;"><%=Dynamicweb.Gui.LinkManager(ActionClickFile, "url", "ActionClickURL")%><BR/></SPAN>									
									<INPUT type="radio" class="clean" <%=Base.IIf(ActionClickID=3,"checked","") %>OnClick="javascript:Show('RolloverFile'); Hide('RolloverURL');" name="ActionClickID" id="radio" value="3"><%=Translate.Translate("Fil")%><BR/><SPAN id="RolloverFile" style="display:<%=Base.IIf(ActionClickID=3,"", "none")%>; padding-left:25px;"><%= Gui.FileManager(ActionClickFile, Dynamicweb.Content.Management.Installation.ImagesFolderName, "ActionClickFile")%></SPAN>
								</TD>
							</TR>
						</TABLE>
					<%=Gui.GroupBoxEnd()%>
					</DIV>
				</TD>
			</TR>
			<TR valign="bottom">
				<TD align="right" colspan="2">
					<TABLE>
						<TR>
							<TD>
								<%=Gui.Button("OK", "ValidateThisForm();", 0)%>
							</TD>
							<TD>
								<%=Gui.Button(Translate.Translate("Annuller"), "location = 'CategoryList.aspx?Tab=2';", 0)%>
							</TD>
						</TR>
					</TABLE>
				</TD>
			</TR>
		</FORM>
		<script type="text/javascript" language="javascript">
		function checkFileFormat()
		{
			var strDotRollover = document.getElementById("DotRollover");
			var strDot = document.getElementById("Dot");
			
			var reg = new RegExp(".jpg|.swf");
			if ((!reg.test(strDotRollover.value)) || (!reg.test(strMouseOverImage.value)))
			{
				alert("Invalid file format, please choose .jpg or .swf!");
			}
			else
			{
				documet.forms[0].submit();
			}
		}
	</script>
	</TABLE>
</BODY>
</HTML>
<%TRANSLATE.GETEDITONLINESCRIPT()%>