<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Group_Delete.aspx.vb" Inherits="Dynamicweb.Admin.Group_Delete1"%>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>

<%
GroupID = request.QueryString("ID")
ParentID = ""
If GroupID <> "" Then
	DeletePages(GroupID, True)
End If
%>
<script language="JavaScript">
	//location = "Product_List.aspx?ID=<%=ParentID%>";
	parent.location = "menu.aspx?GroupID=<%=ParentID%>";
</script>
