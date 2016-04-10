<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Paragraph_RestoreTo.aspx.vb" Inherits="Dynamicweb.Admin.Paragraph_RestoreTo"%>
<SCRIPT LANGUAGE="JavaScript">
<!--
    // alert("intAreaID:" + <%=intAreaID%>)
    top.opener.top.left.setAreaID(<%=intAreaID%>);
	top.opener.top.left.setAreaDropDown(<%=intAreaID%>)
	top.opener.top.left.MoveMenuEntry(<%=intToPage%>);
//top.opener.top.right.location = "Paragraph_List.aspx?ID=<%=intToPage%>";

    //top.opener.top.left.location.reload();
    top.opener.top.right.location.reload();
	self.close();


//-->
</SCRIPT>
