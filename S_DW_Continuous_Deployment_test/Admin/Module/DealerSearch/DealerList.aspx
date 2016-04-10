<%@ Page language="vb" autoeventwireup="false" codebehind="DealerList.aspx.vb" inherits="Dynamicweb.Admin.DealerSearch.Backend.DealerList" %>
<%@ IMPORT namespace="Dynamicweb" %>
<%@ IMPORT namespace="Dynamicweb.Backend" %>
<HTML>
<HEAD>
<META http-equiv="Content-Type" content="text/html;charset=UTF-8"><LINK rel="STYLESHEET" type="text/css" href="/Admin/Stylesheet.css">
<SCRIPT language="javascript">function del(ID, strName){
			if(confirm('<%=Translate.JSTranslate("Slet %%?", "%%", Translate.JSTranslate("forhandler"))%>\n(' + strName + ')')){
				location = "DealerDelete.aspx?ID=" + ID + "&CategoryID=<%=Request.QueryString("ID")%>";
			}
		}
</SCRIPT><%=Gui.MakeHeaders(Translate.JSTranslate("%m% kategori", "%m%", Translate.JSTranslate("Forhandlersøgning",9)), Translate.JSTranslate("Forhandlere"), "Javascript", false, "")%>
</HEAD>
<BODY>
<%=Gui.MakeHeaders(Translate.Translate("%m% kategori", "%m%", Translate.Translate("Forhandlersøgning",9)), Translate.Translate("Forhandlere"), "Html", false, "")%>
	<TABLE border="0" cellpadding="0" cellspacing="0" class="tabTable">
		<TR>
			<TD valign="top"><BR>
				<TABLE border="0" cellpadding="0" width="598">
					<TR>
						<TD width="230"><STRONG><%=Translate.Translate("Navn")%></STRONG>
						</TD>
						<TD width="180"><STRONG><%=Translate.Translate("Adresse")%></STRONG>
						</TD>
						<TD width="128"><STRONG><%=Translate.Translate("By")%></STRONG>
						</TD>
						<TD width="30" align="center"><STRONG><%=Translate.Translate("Aktiv")%></STRONG>
						</TD>
						<TD width="30" align="center"><STRONG><%=Translate.Translate("Kopier")%></STRONG>
						</TD>
						<TD width="30" align="center"><STRONG><%=Translate.Translate("Slet")%></STRONG>
						</TD>
					</TR>
					<!--GUI.ListSeparatorRow(6)-->
					<TR>
						<TD colspan="6" bgcolor="#C4C4C4"><IMG src="/Admin/images/nothing.gif" width="1" height="1" alt="" border="0"></TD>
					</TR>
					<ASP:LITERAL id="Literal1" runat="server" />
				</TABLE>
				<TR valign="bottom">
					<TD align="right" colspan="6">
						<TABLE>
							<TR>
								<TD><%=Gui.Button(Translate.JSTranslate("Ny %%", "%%", Translate.JSTranslate("forhandler")), "location = 'DealerEdit.aspx?CategoryID=" & Request.QueryString("ID") & "';", 0)%>
								</TD>
								<TD><%=Gui.Button(Translate.JSTranslate("Rediger %%", "%%", Translate.JSTranslate("kategori")), "location = 'CategoryEdit.aspx?ID=" & Request.QueryString("ID") & "';", 0)%>
								</TD>
								<TD><%=Gui.Button(Translate.JSTranslate("Luk"), "location = 'CategoryList.aspx';", 0)%>
								</TD>
							</TR>
					</TD>
				</TR>
	</TABLE>
</TD>
</TR>
</TABLE><%TRANSLATE.GETEDITONLINESCRIPT()%>
	</body>
</html>