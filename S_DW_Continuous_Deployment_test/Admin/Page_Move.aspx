<%@ Page CodeBehind="Page_Move.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.Page_Move" %>

<script language="JavaScript">
	top.opener.setAreaID(<%=AreaID%>);
	top.opener.setAreaDropDown(<%=AreaID%>)
    top.opener.MoveMenuEntry(<%=MoveID%>);
    <%If allowPageToMove Then%>
    top.opener.pageOptionsControl(<%=MoveID%>, "movepage", "<%=oldPageState%>");
    <%End If%>
	self.close();
</script>
