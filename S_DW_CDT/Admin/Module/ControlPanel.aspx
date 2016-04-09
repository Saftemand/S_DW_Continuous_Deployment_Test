<%@ Page Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.ControlPanel"%>

<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<%
    If Gui.NewUI Then
        Response.Redirect("/Admin/Content/Management/Start.aspx")
    End If
    
    Dim sql As String
    Dim IconPath As String
    Dim IconPath2 As String
    Dim IconPath3 As String
    Dim IconPath4 As String
    Dim IconPath5 As String
    Dim ModuleIcon As String
    Dim ColCount As Integer
    Dim intModuleCount As Integer
    
%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html;charset=UTF-8" />
    <link rel="STYLESHEET" type="text/css" href="../Stylesheet.css" />
    <title>
        <%=Translate.JSTranslate("Kontrol Panel")%>
    </title>
</head>
<body>
    <%
        Dim DynamicConn As System.Data.IDbConnection = Database.CreateConnection("Dynamic.mdb")
        Dim cmdDynamic As IDbCommand = DynamicConn.CreateCommand

        Dim NumberOfColumns As Integer = 4
        Dim ColumnWidth As String = Int(100 / NumberOfColumns) & "%"
    %>
    <%=Gui.MakeHeaders(Translate.Translate("Kontrol Panel"),Translate.Translate("Konfiguration"), "all")%>
    <table border="0" cellpadding="2" cellspacing="0" class="tabTable">
        <tr>
            <td valign="top">
                <br />
                <%=Gui.GroupBoxStart(Translate.Translate("Indstillinger"))%>
                <table border="0" cellpadding="2" width="100%">
                    <tr valign="top">
                        <td align="center" width="<%=ColumnWidth%>">
                            <a href="Settings_cpl.aspx">
                                <img src="/Admin/Images/Icons/cplGeneral.gif" border="0" alt="" /><br />
                                <%=Translate.Translate("Generelt")%>
                            </a>
                        </td>
                        <td align="center" width="<%=ColumnWidth%>">
                            <a href="System_cpl.aspx">
                                <img src="/Admin/Images/Icons/cplSystem.gif" border="0" alt="" /><br />
                                <%=Translate.Translate("System")%>
                            </a>
                        </td>
                        <td align="center" width="<%=ColumnWidth%>">
                            <a href="Editing_cpl.aspx">
                                <img src="/Admin/Images/Icons/cplEditing.gif" border="0" alt="" /><br />
                                <%=Translate.Translate("Redigering")%>
                            </a>
                        </td>
                        <td align="center" width="<%=ColumnWidth%>">
                            <a href="Stylesheet_cpl.aspx">
                                <img src="/Admin/Images/Icons/Module_Stylesheet.gif" border="0" alt="" /><br />
                                <%=Translate.Translate("Stylesheet")%>
                            </a>
                        </td>
                    </tr>
                    <%If Base.HasVersion("18.11.1.0") Then%>
                    <tr>
                        <td align="center" width="<%=ColumnWidth%>">
                            <a href="Security_cpl.aspx">
                                <img src="/Admin/Images/Icons/cplSecurity.gif" border="0" alt="" /><br />
                                <%=Translate.Translate("Sikkerhed")%>
                            </a>
                        </td>
                        <%If GetShowScheduledTasks() Then%>
                        <td align="center" width="<%=ColumnWidth%>">
                            <a href="ScheduledTasks_cpl/TaskList.aspx">
                                <img src="/Admin/Images/Icons/cplScheduledTasks.gif" border="0" alt="" /><br />
                                <%=Translate.Translate("Scheduled Tasks")%>
                            </a>
                        </td>
                        <%End If%>
                    </tr>
                    <%End If%>
                    <%If Session("DW_Admin_UserType") = 0 Then%>
                    <tr>
                        <td align="center" width="<%=ColumnWidth%>">
                            <a href="/Admin/Module/Modules.aspx?Mode=config">
                                <img src="/Admin/Images/Icons/cplModules.gif" border="0" alt="" /><br />
                                <%=Translate.Translate("Moduler")%>
                            </a>
                        </td>
                        <td align="center" width="<%=ColumnWidth%>">
                            <a href="Language/Language_Edit.aspx">
                                <img src="/Admin/Images/Icons/cplOnlineTranslation.gif" border="0" alt="" /><br />
                                <%=Translate.Translate("Brugergrænseflade")%>
                            </a>
                        </td>
                    </tr>
                    <%End If%>
                </table>
                <%=Gui.GroupBoxEnd%>
                <%
                    sql = "SELECT Count(*) FROM [Module] WHERE [ModuleControlPanel] <> '' AND ModuleAccess = " & Database.SqlBool(1)
                    sql = sql & " AND ModuleSystemName <> 'Stylesheet' AND ModuleSystemName <> 'Dynamicdoc' AND ModuleSystemName <> 'Statistics'"
                    cmdDynamic.CommandText = sql
                    intModuleCount = cmdDynamic.ExecuteScalar()

                    If intModuleCount > 0 Then
                %>
                <%=Gui.GroupBoxStart(Translate.Translate("Moduler"))%>
                <table border="0" cellpadding="2" width="100%">
                    <tr valign="top">
                        <%
                            sql = "SELECT [ModuleName], [ModuleControlPanel], [ModuleSystemName], [ModuleSort] FROM [Module] WHERE [ModuleControlPanel] <> '' AND ModuleAccess = " & Database.SqlBool(1)
                            sql += " AND ModuleSystemName <> 'Stylesheet' AND ModuleSystemName <> 'Dynamicdoc' AND ModuleSystemName <> 'Statistics'"
                            If Base.HasVersion("18.10.1.0") = False Then
                                sql += " AND ModuleSystemName <> 'News' "
                            End If
                            sql += " ORDER BY [ModuleName]"
                            cmdDynamic.CommandText = sql

                            Dim ModuleReader As IDataReader = cmdDynamic.ExecuteReader()
                            Dim opModuleName As Integer = ModuleReader.GetOrdinal("ModuleName")
                            Dim opModuleControlPanel As Integer = ModuleReader.GetOrdinal("ModuleControlPanel")
                            Dim opModuleSystemName As Integer = ModuleReader.GetOrdinal("ModuleSystemName")
                            Dim opModuleSort As Integer = ModuleReader.GetOrdinal("ModuleSort")
                            Dim strURLModuleControlPanel As String
							
                            Dim i As Integer = 0

                            ColCount = 1
                            Do While ModuleReader.Read
                                
                                If ColCount = 1 Then
                                    'New column
                                    Response.Write("<tr valign='top'>")
                                End If
                                
                                IconPath = Server.MapPath("../Images/Icons/Module_" & ModuleReader(opModuleSystemName) & ".gif")
                                IconPath2 = Server.MapPath(ModuleReader(opModuleSystemName) & "/Module_" & ModuleReader(opModuleSystemName) & ".gif")
                                IconPath3 = Server.MapPath("/CustomModules/" & ModuleReader(opModuleSystemName) & "/Module_" & ModuleReader(opModuleSystemName) & ".gif")
                                IconPath4 = Server.MapPath("../Images/Icons/Module_" & Left(ModuleReader(opModuleSystemName), 4) & ".gif")   ' used for CartV2
                                IconPath5 = Server.MapPath("../Images/Icons/Module_" & ModuleReader(opModuleSystemName) & ".png")
                                If System.IO.File.Exists(IconPath) Then 'Does an icon exist for this module?
                                    ModuleIcon = "../Images/Icons/Module_" & ModuleReader(opModuleSystemName) & ".gif"
                                ElseIf System.IO.File.Exists(IconPath2) Then
                                    ModuleIcon = ModuleReader(opModuleSystemName) & "/Module_" & ModuleReader(opModuleSystemName) & ".gif"
                                ElseIf System.IO.File.Exists(IconPath3) Then
                                    ModuleIcon = "/CustomModules/" & ModuleReader(opModuleSystemName) & "/Module_" & ModuleReader(opModuleSystemName) & ".gif"
                                ElseIf System.IO.File.Exists(IconPath4) Then
                                    ModuleIcon = "../Images/Icons/Module_" & Left(ModuleReader(opModuleSystemName), 4) & ".gif"   ' used for CartV2
                                ElseIf System.IO.File.Exists(IconPath5) Then
                                    ModuleIcon = "../Images/Icons/Module_" & ModuleReader(opModuleSystemName) & ".png"
                                Else
                                    ModuleIcon = "../Images/Icons/Module_Default.gif"
                                End If

                                If InStr(ModuleReader(opModuleControlPanel).ToString, "aspx") = 0 Then
                                    strURLModuleControlPanel = ModuleReader(opModuleControlPanel).ToString & "x"
                                Else
                                    strURLModuleControlPanel = ModuleReader(opModuleControlPanel).ToString
                                End If

                                If InStr(strURLModuleControlPanel, "/") And Not Base.ChkNumber(ModuleReader(opModuleSort)) = 99 Then
                                    strURLModuleControlPanel = Mid(strURLModuleControlPanel, strURLModuleControlPanel.LastIndexOf("/") + 2, strURLModuleControlPanel.Length)
                                End If
                        %>
                        <td align="center" width="<%=ColumnWidth%>">
                            <a href="<%=strURLModuleControlPanel%>">
                                <img src="<%=ModuleIcon%>" alt="" border="0" /><br />
                                <%=Translate.JSTranslate(ModuleReader(opModuleName),9)%>
                            </a>
                        </td>
                        <%							
                            If ColCount = NumberOfColumns Then
                                Response.Write("</tr>")
                                ColCount = 1
                            Else
                                ColCount = ColCount + 1
                            End If
                        Loop
                        ModuleReader.Dispose()

                        For j As Integer = ColCount To NumberOfColumns
                        %>
                        <td align="center" width="<%=ColumnWidth%>">
                            &nbsp;</td>
                        <%Next%>
                    </tr>
                </table>
                <%=Gui.GroupBoxEnd%>
                <%
                End If
                %>
                
                <%
                	Dim sb As New System.Text.StringBuilder()
                    If Dynamicweb.eCommerce.Common.Functions.IsEcom Then
                        
				
                        sb.Append(Gui.GroupBoxStart(Translate.Translate("Ecom")))
						
                        sb.Append("<table border=0 cellpadding=2 width='100%'>")
						
                        sb.Append("<tr valign=top>")
                        sb.Append("<td align=center width='" & ColumnWidth & "'>")
                        sb.Append("<a href=Ecom_cpl.aspx?cmd=1>")
                        sb.Append("<img src=/Admin/Module/eCom_Catalog/images/buttons/big/btn_general.png border=0><br>")
                        sb.Append(Translate.Translate("Generelt", 1))
                        sb.Append("</a>")
                        sb.Append("</td>")
						
                        sb.Append("<td align=center width='" & ColumnWidth & "'>")
                        sb.Append("<a href=Ecom_cpl.aspx?cmd=2>")
                        sb.Append("<img src=/Admin/Module/eCom_Catalog/images/buttons/big/btn_language.gif border=0><br>")
                        sb.Append(Translate.Translate("Produkt sprogstyring"))
                        sb.Append("</a>")
                        sb.Append("</td>")

                        sb.Append("<td align=center width='" & ColumnWidth & "'>")
                        sb.Append("<a href=Ecom_cpl.aspx?cmd=3>")
                        sb.Append("<img src=/Admin/Module/eCom_Catalog/images/buttons/big/btn_money.gif border=0><br>")
                        sb.Append(Translate.Translate("Priser"))
                        sb.Append("</a>")
                        sb.Append("</td>")

                        sb.Append("<td align=center width='" & ColumnWidth & "'>")
                        sb.Append("<a href=Ecom_cpl.aspx?cmd=4>")
                        sb.Append("<img src=/Admin/Module/eCom_Catalog/images/buttons/big/btn_stock.gif border=0><br>")
                        sb.Append(Translate.Translate("Lager", 1))
                        sb.Append("</a>")
                        sb.Append("</td>")
                        sb.Append("</tr>")
						
                        '########################################
                        sb.Append("<tr valign=top>")
                        sb.Append("<td align=center width='" & ColumnWidth & "'>")
                        sb.Append("<a href=Ecom_cpl.aspx?cmd=6>")
                        sb.Append("<img src=/Admin/Images/eCom/eCom_Media.gif border=0><br>")
                        sb.Append(Translate.Translate("Images", 1))
                        sb.Append("</a>")
                        sb.Append("</td>")

                        If Base.HasAccess("eCom_Cart", "") Then
                            sb.Append("<td align=center width='" & ColumnWidth & "'>")
                            sb.Append("<a href=Ecom_cpl.aspx?cmd=7>")
                            sb.Append("<img src=/Admin/Module/eCom_Catalog/images/buttons/big/shoppingcart.png border=0><br>")
                            sb.Append(Translate.Translate("Cart", 1))
                            sb.Append("</a>")
                            sb.Append("</td>")
                        Else
                            sb.Append("<td align=center width='" & ColumnWidth & "'>")
                            sb.Append("</td>")
                        End If

                        If Base.HasAccess("eCom_SalesDiscountExtended", "") Then
                            'Sales discount settings. Only when SalesDiscountExtended is enabled.
                            sb.Append("<td align=center width='" & ColumnWidth & "'>")
                            sb.Append("<a href=Ecom_cpl.aspx?cmd=5>")
                            sb.Append("<img src=/Admin/Module/eCom_Catalog/images/buttons/big/btn_discount.gif border=0><br>")
                            sb.Append(Translate.Translate("Rabat", 1))
                            sb.Append("</a>")
                            sb.Append("</td>")
                        Else
                            sb.Append("<td align=center width='" & ColumnWidth & "'>")
                            sb.Append("</td>")
                        End If

                        
                        'One empty cell
                        sb.Append("<td align=center width='" & ColumnWidth & "'>")
                        sb.Append("</td>")
                        sb.Append("</tr>")

                        sb.Append("</table>")
						
                        sb.Append(Gui.GroupBoxEnd)
                	End If
                	If Base.IsDeveloper(True) Then
                		'########################################
                		sb.Append(Gui.GroupBoxStart("Extensibility - DW Developers"))
						
                		sb.Append("<table border=0 cellpadding=2 width='100%'>")
                		sb.Append("<tr valign=top>")
                		sb.Append("<td align=center width='" & ColumnWidth & "'>")
                		sb.Append("<a href=Extensibility_cpl.aspx>")
                		sb.Append("<img src=/Admin/Images/Icons/Extensibility.png border=0><br>")
                		sb.Append("View")
                		sb.Append("</a>")
                		sb.Append("</td>")
						
                		sb.Append("<td align=center width='" & ColumnWidth & "'>")
                		sb.Append("</td>")

                		sb.Append("<td align=center width='" & ColumnWidth & "'>")
                		sb.Append("</td>")

                		sb.Append("<td align=center width='" & ColumnWidth & "'>")
                		sb.Append("</td>")
                		sb.Append("</tr>")
                		sb.Append("</table>")
						
                		sb.Append(Gui.GroupBoxEnd)
                		'########################################
                	End If
                        
                	If Base.IsDeveloper() Then
                		'########################################
                		sb.Append(Gui.GroupBoxStart("Udvikler moduler"))
						
                		sb.Append("<table border=0 cellpadding=2 width='100%'>")
                		sb.Append("<tr valign=top>")
						
                		sb.Append("<td align=center width='" & ColumnWidth & "'>")
                		sb.Append("<a href=/admin/module/Datamanagement/>")
                		sb.Append("<img src=/Admin/Images/Icons/Module_DbPub.gif border=0><br>")
                		sb.Append("Datamanagement")
                		sb.Append("</td>")
                            
                		sb.Append("<td align=center width='" & ColumnWidth & "'>")
                		sb.Append("</td>")

                		sb.Append("<td align=center width='" & ColumnWidth & "'>")
                		sb.Append("</td>")

                		sb.Append("<td align=center width='" & ColumnWidth & "'>")
                		sb.Append("</td>")
                		sb.Append("</tr>")
                		sb.Append("</table>")
						
                		sb.Append(Gui.GroupBoxEnd)
                		'########################################
                	End If
                        
                	Response.Write(sb.ToString)
                   
                %>
                <table border="0" cellpadding="2" width="100%">
                    <tr valign="bottom">
                        <td width="100%" align="right">
                            <%=Gui.HelpButton("", "administration.controlpanel")%>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</body>
</html>
<%
    DynamicConn.Dispose()
    Translate.GetEditOnlineScript()
%>
