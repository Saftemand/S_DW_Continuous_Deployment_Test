<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<%@ Page ValidateRequest="false" CodeBehind="Paragraph_Copy.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.Paragraph_Copy" CodePage="65001" %>
<%@ Import Namespace="Dynamicweb" %>
<script language="JavaScript">
<!--
	parent.left.setAreaID(<%=AreaID%>);
	parent.left.setAreaDropDown(<%=AreaID%>)
	parent.left.MoveMenuEntry(<%=ToPage%>);
	parent.right.location = "Paragraph_List.aspx?ID=<%=ToPage%>&CopiedParagraphIDs=<%=CopiedParagraphIDs%>&omc=<%=omcExp%>&mode=<%=Base.Request("mode")%>";

//-->
</script>

