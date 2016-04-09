<%@ Page CodeBehind="Page_Copy.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.Page_Copy" %>

<%@ Import Namespace="Dynamicweb" %>

<script language="JavaScript">
    <%If Not Base.ChkBoolean(Request("CopyHere")) Then%>
    top.opener.setAreaID(<%=AreaID%>);
    top.opener.setAreaDropDown(<%=AreaID%>)
    top.opener.MoveMenuEntry(<%=newPageID%>);
    top.opener.SetPageCount(<%=numOfPages%>);
    top.opener.pageOptionsControl(<%=newPageID%>, "copypage", "<%=oldPageState%>");
    top.opener.location = '/Admin/Menu.aspx?ID=<%=newPageID%>&AreaID=<%=AreaID%>';
    self.close();
    <%End If%>
</script>

