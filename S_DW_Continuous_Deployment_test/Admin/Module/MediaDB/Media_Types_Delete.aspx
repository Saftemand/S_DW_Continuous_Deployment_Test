<%@ Page Language="vb" AutoEventWireup="false"%>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>



<%

If Len(Request.QueryString("ID")) > 0 Then
        Database.ExecuteNonQuery("DELETE FROM MediaDBField WHERE MediaDBFieldTypeID = " & Request.QueryString("ID"), "DWMedia.mdb")
        Database.ExecuteNonQuery("DELETE FROM MediaDBFiletypes WHERE MediaDBFiletypesID = " & Request.QueryString("ID"), "DWMedia.mdb")
End If

Response.Redirect(("Media_Types_List.aspx"))
%>
