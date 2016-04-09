<%@ Page language="vb" autoeventwireup="false" codebehind="CategoryEdit.aspx.vb" inherits="Dynamicweb.Admin.DealerSearch.Backend.CategoryEdit" %>
<%@ IMPORT namespace="Dynamicweb" %>
<%@ IMPORT namespace="Dynamicweb.Backend" %><!DOCTYPE html public "-//w3c//dtd html 4.0 transitional//en">
<HTML>
<HEAD>
<META http-equiv="Content-Type" content="text/html;charset=UTF-8"><LINK rel="STYLESHEET" type="text/css" href="/Admin/Stylesheet.css"><%=Gui.MakeHeaders(Translate.JSTranslate("%m% - Rediger %c%","%m%",Translate.JSTranslate("Forhandlersøgning",9),"%c%",Translate.JSTranslate("kategori")), Translate.JSTranslate("Kategori"), "Javascript", false, "")%>
</HEAD>
<BODY>
	<FORM action="CategorySave.aspx" method="post">
	<%=Gui.MakeHeaders(Translate.JSTranslate("%m% - Rediger %c%", "%m%", Translate.JSTranslate("Forhandlersøgning",9), "%c%", Translate.JSTranslate("kategori")), Translate.JSTranslate("Kategori"), "Html", false, "")%>
		<TABLE border="0" cellpadding="0" cellspacing="0" class="tabTable">			
			<INPUT type="hidden" name="_ID" id="_ID" value="" runat="server">
			<TR>
				<TD valign="top"><BR><%=Gui.GroupBoxStart(Translate.Translate("Indstillinger"))%>
					<TABLE>
						<TR>
							<TD width="170"><%=Translate.Translate("Navn")%>
							</TD>
							<TD>								
								<INPUT type="text" name="Name" id="Name" maxlength="255" value="" class="std" runat="server">
							</TD>
						</TR>
						<TR>
							<TD width="170"><%=Translate.Translate("Baggrundsmedie")%>
							</TD>
							<TD><%=Gui.Filemanager(strImage, "DealerSearch", "Image", "swf,jpg")%>
							</TD>
						</TR>
						<TR>
							<TD width="170"><%=Translate.Translate("MouseOvermedie")%>
							</TD>
							<TD><%=Gui.Filemanager(strMouseOverImage, "DealerSearch", "MouseOverImage", "swf,jpg")%>
							</TD>
						</TR>
						<TR>
							<TD width="170"><%=Translate.Translate("OnClickmedie")%>
							</TD>
							<TD><%=Gui.Filemanager(strOnClickImage, "DealerSearch", "OnClickImage", "swf,jpg")%>
							</TD>
						</TR>
						<TR>
							<TD width="170"><%=Translate.Translate("Højde (px)")%>
							</TD>
							<TD>								
								<INPUT type="text" name="Height" id="Height" maxlength="255" value="" class="std" runat="server">
							</TD>
						</TR>
						<TR>
							<TD width="170"><%=Translate.Translate("Bredde (px)")%>
							</TD>
							<TD>								
								<INPUT type="text" name="Width" id="Width" maxlength="255" value="" class="std" runat="server">
							</TD>
						</TR>
					</TABLE><%=Gui.GroupBoxEnd()%>
				</TD>
			</TR>
			<TR>
				<TD align="right" colspan="2">
					<TABLE>
						<TR>
							<TD><%=Gui.Button("OK", "checkFileFormat();", 0)%>
							</TD>
							<TD><%=Gui.Button(Translate.Translate("Annuller"), "location = 'CategoryList.aspx';", 0)%>
							</TD>
						</TR>
					</TABLE>
				</TD>
			</TR>
		</TABLE>
	</FORM>
	<script type="text/javascript" language="javascript">
		
		function ValidateThisForm()
		{
			var height = document.getElementById("Height");
			var width = document.getElementById("Width");
			if (height.value != "" && isNaN(height.value))
			{
				alert("<%=Translate.JSTranslate("Ugyldige tegn i: %%", "%%", Translate.JsTranslate("Højde"))%>");
				height.focus();
				return false;
			}
			else if(width.value != "" &&  isNaN(width.value))
			{
				alert("<%=Translate.JSTranslate("Ugyldige tegn i: %%", "%%", Translate.JsTranslate("Bredde"))%>");
				width.focus();
				return false;
			}
			return true;
		}
		
		function checkFileFormat()
		{
			var strImage = document.getElementById("FM_Image");
			var strMouseOverImage = document.getElementById("FM_MouseOverImage");
			var strOnClickImage = document.getElementById("FM_OnClickImage");
			var reg = new RegExp(".jpg|.swf");
			var noerror = true;
			
			noerror = ValidateThisForm();
			
			var nameControl = document.forms[0].elements["Name"];
			if (nameControl != null && nameControl.value == "")
			{
				alert("<%=Translate.JsTranslate("Der skal angives en værdi i: %%", "%%", Translate.JsTranslate("Navn"))%>");
				nameControl.focus();
				noerror = false;
			}
			
			if ((!reg.test(strImage.value)))
			{
				if(strImage.value != '')
				{
					alert("Invalid file format, please choose .jpg or .swf!");
					noerror = false;
				}
			}
			if ((!reg.test(strMouseOverImage.value)))
			{
				if(strMouseOverImage.value != '')
				{
					alert("Invalid file format, please choose .jpg or .swf!");
					noerror = false;
				}
			}
			if ((!reg.test(strOnClickImage.value)))
			{
				if(strOnClickImage.value != '')
				{
					alert("Invalid file format, please choose .jpg or .swf!");
					noerror = false;
				}
			}
			
			if(noerror)
			{
				document.forms[0].submit();
			}
		}
	</script>
</BODY>
</HTML>
<%TRANSLATE.GETEDITONLINESCRIPT()%>