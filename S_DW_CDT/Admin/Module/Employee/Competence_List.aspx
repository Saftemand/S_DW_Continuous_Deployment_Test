<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Competence_List.aspx.vb" Inherits="Dynamicweb.Admin.Employee.Competence_List" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
    <HEAD>
        <link rel="STYLESHEET" type="text/css" href="/Admin/Stylesheet.css">
            <script language="javascript">
  
	function DeleteConfirm(CategoryID, CompetenceID, Name)
	{
		if(confirm('<%=Translate.JSTranslate("Slet")%> \"' + Name + '\" ?'))
		{
			if(CompetenceID > 0)
				location = "Competence_ChangeState.aspx?CategoryID=" + CategoryID +
					"&CompetenceID=" + CompetenceID + "&action=delete";
			else
				location = "Competence_ChangeState.aspx?CategoryID=" + CategoryID+ "&action=delete"; 
		}
	}
            </script>
    </HEAD>
    <body>
        <%=Gui.MakeHeaders(_context, Translate.Translate("Kategorier"), "all")%>
		<div id="Tab1" style="DISPLAY:"/>
        <table border="0" cellpadding="0" cellspacing="0" class="tabTable" width="598">
            <tr>
                <td valign="top">
                    <table border="0" cellpadding="0" width="598">
                        <tr valign="top">
                            <td colspan="4">
                                <br>
                            </td>
                        </tr>
                        <tr>
                            <td width="478" align="left"><strong><%=Translate.Translate("Name")%></strong></td>
                            <td width="40" align="center"><strong><%=Translate.Translate("Aktiv")%></strong></td>
                            <td width="40" align="center"><strong><%=Translate.Translate("Rediger")%></strong></td>
                            <td width="40" align="center"><strong><%=Translate.Translate("Slet")%></strong></td>
                        </tr>
                        <%=_html%>
                    </table>
                </td>
            </tr>
            <tr valign="bottom">
                <td colspan="4" align="right">
                    <table cellpadding="0" cellspacing="0" border="0">
                        <tr>
							<% If _IsCategoryLevel %>
								<td align="right"><%=Gui.Button(Translate.Translate("Ny") & " " & Translate.Translate("kategori"), "location = '" & _add_url & "'", 0)%></td>
							<% Else %>
								<td align="right"><%=Gui.Button(Translate.Translate("Ny") & " " & Translate.Translate("kompetence"), "location = '" & _add_url & "'", 0)%></td>
							<% End if %>
                            
                            <% If Not _IsCategoryLevel %>
                            <td width="5"></td>
                            <td align="right"><%=Gui.Button(Translate.Translate("Tilbage"), "location = 'Competence_List.aspx'", 0)%></td>
                            <% End if %>
                            <td width="10"></td>
                        </tr>
                        <tr>
                            <td colspan="2" height="5"></td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </body>
</HTML>
<%Translate.GetEditOnlineScript()%>
