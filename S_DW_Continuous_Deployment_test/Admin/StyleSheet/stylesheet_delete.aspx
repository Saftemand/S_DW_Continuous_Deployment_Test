<%@ Page CodeBehind="stylesheet_delete.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.stylesheet_delete" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>

<Script Language="JavaScript">
	var url = 'stylesheet_list.aspx';
	<%If Base.HasAccess("StylesheetDelete", "") = false Then%>
	url = 'stylesheet_list.aspx?NoAccess=1&NoAccessID=0';
	<%End If%>
	top.right.location = url;
</Script>
