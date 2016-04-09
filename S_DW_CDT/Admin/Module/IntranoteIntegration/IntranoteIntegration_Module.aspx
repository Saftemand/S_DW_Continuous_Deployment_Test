<%@ Page Language="vb" AutoEventWireup="false" Codebehind="IntranoteIntegration_Module.aspx.vb" Inherits="Dynamicweb.Admin.Intranote.IntranoteIntegration_Module" %>
<%@ Import namespace="Dynamicweb" %>
<script language="JavaScript">
function OnSubmit(sub)
{
    if (document.getElementById('theForm').Key.value.length == 0)
    {
        alert("Encryption key should not be empty.");
        document.getElementById('theForm').Key.focus();
        return false;
    }
    else
    {
        if (sub)
            document.getElementById('theForm').submit();
        return true;
    }
}
</script>
<LINK REL="STYLESHEET" TYPE="text/css" HREF="/Admin/stylesheet.css">
<FORM NAME="theForm" id="theForm" ACTION="IntranoteIntegration_Save.aspx" METHOD="POST" onsubmit="return OnSubmit()">
<%=Gui.MakeHeaders("Intranote Integration", "Options", "all")%>
<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0" CLASS="TabTable">
<tr>
    <td>
        <%=Gui.GroupBoxStart("Encryption")%>
        <table>
                <TR>
                        <TD width=170>Key</TD>
                        <TD><INPUT TYPE="TEXT" NAME="Key" VALUE="<%=Server.HtmlEncode(_key)%>" CLASS="Std" maxLength = "23"></TD>
                </TR>
        </table>
        <%=Gui.GroupBoxEnd()%>
    </td>
</tr>
   
<TR>
        <TD ALIGN="RIGHT" valign=bottom>
                <TABLE>
                        <TR>
                                <TD><%=Gui.Button("OK", "OnSubmit(true)", 0)%></TD>
                                <TD><%=Gui.Button("Annuller", "location='/Admin/Module/Modules.aspx'", 0)%></TD>
                        </TR>
                </TABLE>
        </TD>
</TR>
</TABLE>   
</FORM>
