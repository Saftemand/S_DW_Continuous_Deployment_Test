<%  If Not CalledFromManagementCenter Then %>
<TR>
	<TD>
		<TABLE ALIGN="RIGHT" BORDER="0">
			<TR>
				<%If Dynamicweb.Base.HasAccess("StylesheetEdit", Dynamicweb.Base.ChkString("")) Then%>
				<td>
					<%= Dynamicweb.Gui.Button(Dynamicweb.Backend.Translate.JsTranslate("OK"), "document.getElementById('StylesheetClassForm').submit();", 0)%>
				</td>
				<%Else%>
				<td valign="top" align="right">
					<img src='/Admin/Images/infoicon.gif' alt='<%=Dynamicweb.Backend.Translate.JSTranslate("Du har ikke de nødvendige rettigheder til denne funktion.")& vbcrlf%>(<%=Dynamicweb.Backend.Translate.JSTranslate("Rediger %%", "%%", Dynamicweb.Backend.Translate.JSTranslate("stylesheet"))%>)' />
				</td>
				<td>
					<input type='button' onClick='return false;' value='<%=Dynamicweb.Backend.Translate.JsTranslate("OK")%>' class='buttonSubmit' disabled="disabled" />
				</td>
				<%End If%>
				<TD>
					<%=Dynamicweb.Gui.Button(Dynamicweb.Backend.Translate.JsTranslate("Annuller"), "location='about:blank'", 0)%>
				</TD>
		</TABLE>	
	</TD>
</TR>
<% End If %>
</TABLE> </DIV>