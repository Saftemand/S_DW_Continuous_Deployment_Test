<%@ Page ValidateRequest="false" CodeBehind="Paragraph_Move.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.Paragraph_Move" %>

<script language="JavaScript">
<!--
    parent.left.setAreaID(<%=AreaID%>);
    parent.left.setAreaDropDown(<%=AreaID%>);
    parent.left.MoveMenuEntry(<%=ToPage%>);
    parent.right.location = "Paragraph_List.aspx?ID=<%=ToPage%>&MovedParagraphIDs=<%=MovedParagraphIDs%>";
//-->
</script>

