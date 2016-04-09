<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Department_Copy.aspx.vb" Inherits="Dynamicweb.Admin.Employee.Department_Copy" %>
<script language="JavaScript">
	window.opener.location = "menu.aspx?DeptToShow=<%=ParentDept%>";
	window.close();	
</script>
