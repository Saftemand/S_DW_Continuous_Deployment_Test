<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Employee_Move.aspx.vb" Inherits="Dynamicweb.Admin.Employee.Employee_Move" %>
<script language="JavaScript">
	window.opener.parent.location.href = "menu.aspx?DeptToShow=<%=DeptTo%>";
	window.close();
</script>
