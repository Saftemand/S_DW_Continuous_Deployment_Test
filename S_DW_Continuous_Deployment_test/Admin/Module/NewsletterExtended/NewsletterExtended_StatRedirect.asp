<%
If Request.QueryString.Count > 0 Then
	Response.Redirect("/admin/public/NewsletterExtended_StatRedirect.aspx?" & Request.QueryString)
Else
	Response.Redirect("/Default.aspx")
End If
%>