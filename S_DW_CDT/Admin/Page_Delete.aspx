<%@ Page CodeBehind="Page_Delete.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.Page_Delete" %>

<SCRIPT language="JavaScript">
	<%If ParentID <> 0 Then%>
		parent.right.location = "Paragraph/Paragraph_List.aspx?ID=<%=ParentID%>";
	<%Else%>
		parent.right.location = "MyPage/Default.aspx";
	<%End If%>
	parent.left.UpdatePageCount_Delete(<%=PageAffected%>);	
	parent.left.UpdateMenuEntry(<%=PageParentPageID.ToString%>)
</SCRIPT>
