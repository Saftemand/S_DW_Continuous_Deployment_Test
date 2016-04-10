<%@ Import Namespace="Dynamicweb.backend" %>
<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Employee" %>

<%@ Page ValidateRequest="false" Language="vb" AutoEventWireup="false" CodeBehind="Employee_Add.aspx.vb"
    Inherits="Dynamicweb.Admin.Employee.Employee_Add" %>

<%@ Register TagPrefix="emp" TagName="CompetenceLister" Src="CompetenceLister.ascx" %>
<%@ Register TagPrefix="emp" TagName="MultiSelect" Src="MultiSelect.ascx" %>
<%@ Register TagPrefix="cust" Namespace="Dynamicweb.Employee" Assembly="Dynamicweb.Compatibility" %>
<!DOCTYPE html PUBLIC  "-//W3C//DTD HTML 4.01 Transitional//EN">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Employee_edit</title>
    
    <link rel="STYLESHEET" type="text/css" href="/Admin/Stylesheet.css">
    <link rel="stylesheet" type="text/css" href="/Admin/Module/Common/Stylesheet.css">
    <meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
    <script type="text/javascript" src="/Admin/Editor/fckeditor.js"></script>

    <script language="javascript" type="text/javascript">
        function Validate()
        {
            if (typeof(Page_ClientValidate) == 'function') Page_ClientValidate();
        }

        function ShowTab(tab)
        {
	        if (tab[0])
		        tab[0].click();
        }

        function PasswordsEqual(source, arguments)
        {
	        arguments.IsValid = (document.getElementById('theForm')._password.value == 
		        document.getElementById('theForm')._password_rep.value);
        }
    </script>

</head>
<body>
    <form id="theForm" name="theForm" runat="server">
    <input type="hidden" value="<%=_id%>" name="ID">
    <input type="hidden" value="<%=_dept%>" name="Dept">
    <%=Gui.MakeHeaders("", Translate.Translate("Medarbejder") & ", " & Translate.Translate("Kommentarer"), "", False, "595")%>
    <div id="Tab1">
        <table class="TabTable" id="Table1" style="width: 595px" cellspacing="0" cellpadding="0">
            <tr>
                <td width="5">
                    &nbsp;
                </td>
                <td>
                    <%=Gui.GroupBoxStart(Translate.Translate("Oplysninger"))%>
                    <table id="Table2">
                        <tr>
                            <td width="5">
                                &nbsp;
                            </td>
                            <td width="170">
                                <%=Translate.Translate("Brugernavn")%>
                            </td>
                            <td>
                                <asp:TextBox ID="_username" runat="server" CssClass="std" Text='<%# Field("AccessUserUserName")%>'
                                    MaxLength="50"></asp:TextBox>
                            </td>
                            <td>
                                <asp:CustomValidator ID="_usernameValidator" runat="server" Display="Dynamic" OnServerValidate="UserNameValidation"
                                    EnableClientScript="False" ErrorMessage="Non-unique username" ControlToValidate="_username"></asp:CustomValidator><asp:RequiredFieldValidator
                                        ID="_usernameValidator2" runat="server" Display="Dynamic" ErrorMessage="Username should not be empty"
                                        ControlToValidate="_username"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                &nbsp;
                            </td>
                            <td>
                                <%=Translate.Translate("Password")%>
                            </td>
                            <td>
                                <asp:TextBox ID="_password" runat="server" CssClass="std" value='<%# Field("AccessUserPassword")%>'
                                    TextMode="password" MaxLength="50"></asp:TextBox>
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="_passValidator" runat="server" ErrorMessage="Password should not be empty"
                                    ControlToValidate="_password"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                &nbsp;
                            </td>
                            <td>
                                <%=Translate.Translate("Bekræft")%>
                                <%=Translate.Translate("Password")%>
                            </td>
                            <td>
                                <asp:TextBox ID="_password_rep" runat="server" CssClass="std" value='<%# Field("AccessUserPassword")%>'
                                    TextMode="password"></asp:TextBox>
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="_pass_repValidator" runat="server" ErrorMessage="You should repeat password"
                                    ControlToValidate="_password_rep" Display="Dynamic"></asp:RequiredFieldValidator><asp:CustomValidator
                                        ID="_passeqValidator" runat="server" Display="Dynamic" ErrorMessage="Passwords are not equal"
                                        ControlToValidate="_password_rep" ClientValidationFunction="PasswordsEqual"></asp:CustomValidator>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                &nbsp;
                            </td>
                            <td>
                                <%=Translate.Translate("Fornavn")%>
                            </td>
                            <td>
                                <asp:TextBox ID="_fname" runat="server" CssClass="std" Text='<%# Field("AccessUserName") %>'
                                    MaxLength="255"></asp:TextBox>
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="_fNameValidator" runat="server" ErrorMessage="First Name should not be empty"
                                    ControlToValidate="_fname"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                &nbsp;
                            </td>
                            <td>
                                <%=Translate.Translate("Mellemnavn")%>
                            </td>
                            <td>
                                <asp:TextBox ID="_mname" runat="server" CssClass="std" Text='<%# Field("AccessUserMiddleName") %>'
                                    MaxLength="255"></asp:TextBox>
                            </td>
                            <td>
                            </td>
                            <tr>
                                <td>
                                    &nbsp;
                                </td>
                                <td>
                                    <%=Translate.Translate("Efternavn")%>
                                </td>
                                <td>
                                    <asp:TextBox ID="_lname" runat="server" CssClass="std" Text='<%# Field("AccessUserLastName") %>'
                                        MaxLength="255"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:RequiredFieldValidator ID="_lameValidator" runat="server" ErrorMessage="Last Name should not be empty"
                                        ControlToValidate="_lname"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    &nbsp;
                                </td>
                                <td>
                                    <%=Translate.Translate("Initialer")%>
                                </td>
                                <td>
                                    <asp:TextBox ID="_initials" runat="server" CssClass="std" Text='<%# Field("AccessUserInitials") %>'
                                        MaxLength="255"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:CustomValidator ID="_initialsValidator" runat="server" Display="Dynamic" OnServerValidate="InitialsValidation"
                                        EnableClientScript="False" ErrorMessage="Non-unique initials" ControlToValidate="_initials"></asp:CustomValidator><asp:RequiredFieldValidator
                                            ID="_initialsReqValidator" runat="server" Display="Dynamic" ErrorMessage="Initials should not be empty"
                                            ControlToValidate="_initials"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    &nbsp;
                                </td>
                                <td>
                                    <%=Translate.Translate("Stillingsbetegnelse")%>
                                </td>
                                <td>
                                    <asp:TextBox ID="_jtitle" runat="server" CssClass="std" Text='<%# Field("AccessUserJobTitle") %>'
                                        MaxLength="50"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:RequiredFieldValidator ID="_jtitleValidator" runat="server" ErrorMessage="Job Title should not be empty"
                                        ControlToValidate="_jtitle"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    &nbsp;
                                </td>
                                <td>
                                    <%=Translate.Translate("Email")%>
                                </td>
                                <td>
                                    <asp:TextBox ID="_email" runat="server" CssClass="std" Text='<%# Field("AccessUserEmail") %>'></asp:TextBox>
                                </td>
                                <td>
                                    <asp:CustomValidator ID="_customEmailValidator" runat="server" Display="Dynamic"
                                        OnServerValidate="EmailValidation" EnableClientScript="False" ErrorMessage="Non-unique email"
                                        ControlToValidate="_email"></asp:CustomValidator>
                                    <asp:RegularExpressionValidator ID="_emailValidator" runat="server" ErrorMessage="Incorrect eMail"
                                        ControlToValidate="_email" ValidationExpression="([a-zA-Z0-9_\-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([a-zA-Z0-9\-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})"
                                        Display="dynamic"></asp:RegularExpressionValidator>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    &nbsp;
                                </td>
                                <td>
                                    <%=Translate.Translate("Telefon")%>
                                </td>
                                <td>
                                    <asp:TextBox ID="_business" runat="server" CssClass="std" Text='<%# Field("AccessUserBusiness") %>'
                                        MaxLength="255"></asp:TextBox>
                                </td>
                                <td>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    &nbsp;
                                </td>
                                <td>
                                    <%=Translate.Translate("Mobil")%>
                                </td>
                                <td>
                                    <asp:TextBox ID="_mobile" runat="server" CssClass="std" Text='<%# Field("AccessUserMobile") %>'
                                        MaxLength="20"></asp:TextBox>
                                </td>
                                <td>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    &nbsp;
                                </td>
                                <td>
                                    <%=Translate.Translate("Telefax")%>
                                </td>
                                <td>
                                    <asp:TextBox ID="_fax" runat="server" CssClass="std" Text='<%# Field("AccessUserFax") %>'
                                        MaxLength="50"></asp:TextBox>
                                </td>
                                <td>
                                </td>
                            </tr>
                            <tr>
                                <td width="5">
                                    &nbsp;
                                </td>
                                <td width="80">
                                    <%=Translate.Translate("Billede")%>
                                </td>
                                <td colspan="2">
                                    <%=Gui.FileManager(UserImage, Consts.ImageFolder, "_image")%>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    &nbsp;
                                </td>
                                <td>
                                    <%=Translate.Translate("Aktiv")%>
                                </td>
                                <td colspan="2">
                                    <asp:CheckBox ID="_active" runat="server" Checked="<%# Active %>"></asp:CheckBox>
                                </td>
                            </tr>
                    </table>
                    <%=Gui.GroupBoxEnd()%>
                    <cust:CustomFields ID="_custFields" runat="server" NameWidth="80" RowID="<%#_id%>"
                        Table="AccessUser"></cust:CustomFields>
                    <%=Gui.GroupBoxStart(Translate.Translate("Afdelinger"))%>
                    <table id="Table5" width="100%">
                        <tr>
                            <td align="center">
                                <emp:MultiSelect ID="_deps" runat="server" EnableValidate="True" AccessUser="<%#_id%>"
                                    AccessDepartment="<%#_dept%>"></emp:MultiSelect>
                            </td>
                        </tr>
                    </table>
                    <%=Gui.GroupBoxEnd()%>
                    <%=Gui.GroupBoxStart(Translate.Translate("Kompetencer"))%>
                    <table id="Table4" width="100%">
                        <tr>
                            <td>
                                <emp:CompetenceLister ID="_compLister" EnableValidate="True" EmployeeID="<%#_id%>"
                                    runat="server"></emp:CompetenceLister>
                            </td>
                        </tr>
                    </table>
                    <%=Gui.GroupBoxEnd()%>
                    <table width="100%">
                        <tr>
                            <td width="85">
                                &nbsp;
                            </td>
                            <td valign="bottom" align="right">
                                <table id="Table3">
                                    <tr>
                                        <td align="right">
                                            <%=Gui.Button(Translate.Translate("OK"), "Validate(); if (ValidatorOnSubmit()) return true;", 0)%>
                                            &nbsp;
                                            <%=Gui.Button(Translate.Translate("Annuller"), "document.location.href='Department_List.aspx?ID=" & _dept & "';", 0)%>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
                <td width="5">
                    &nbsp;
                </td>
            </tr>
        </table>
    </div>
    <div id="Tab2" style="display: none">
        <table class="TabTable" id="Table2"  width="100%" cellspacing="0" cellpadding="0"
            border="0">
            <tr>
                <td width="5">
                    &nbsp;
                </td>
                <td>
                    <table width="100%">
                        <tr>
                            <td>
                                &nbsp;
                                <%=Gui.Editor("_comment", 550, 300, Field("AccessUserComment"), "", Nothing, "", "", Gui.EditorEdition.ForceNew)%>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                <%=Gui.Button(Translate.Translate("OK"), "Validate(); if (ValidatorOnSubmit()) return true; else ShowTab(document.all.Tab1);", 0)%>
                                &nbsp;
                                <%=Gui.Button(Translate.Translate("Annuller"), "document.location.href='Department_List.aspx?ID=" & _dept & "';", 0)%>
                            </td>
                        </tr>
                    </table>
                </td>
                <td width="5">
                    &nbsp;
                </td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>
