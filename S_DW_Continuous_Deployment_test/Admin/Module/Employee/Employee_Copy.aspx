<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Employee_Copy.aspx.vb" Inherits="Dynamicweb.Admin.Employee.Employee_Copy" %>
<script language="JavaScript">
	window.opener.parent.location = "menu.aspx?DeptToShow=<%=Dept%>";
	window.close();
</script>
