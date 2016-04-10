<%@ Page Codebehind="NewsletterExtended_Recipient_Edit.aspx.vb" Language="vb" AutoEventWireup="false"
    Inherits="Dynamicweb.Admin.NewsletterExtended_Recipient_Edit" %>

<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Import Namespace="System.Data" %>
<%
    Dim varEmailValCategory As String
    Dim NewsletterRecipientEmail As String
    Dim RecipientType As Integer
    Dim NewsletterRecipientFormat As String
    Dim RecipientID As String
    Dim NewsletterRecipientName As String
    Dim NewsletterRecipientCategoryID As String
    'Dim UserGroupList As String
    Dim CategoryID As String
    Dim NewsletterRecipientPassword As String
    Dim NewsletterRecipientConfirmed As Boolean
    Dim myCode As String
    Dim varEmailVal As String
    Dim NewsletterRecipientID As String
    Dim Sql As String
    Dim NewsletterAccessUserID As String
    Dim varFieldCount As Integer

    RecipientType = CInt(Request.Item("RecipientType"))
    varEmailVal = Request.Item("varEmailVal")
    RecipientID = Request.Item("RecipientID")
    CategoryID = Request.Item("CategoryID")

    'RecipientType	= request("RecipientType")
    
    If RecipientID = "" Then
        RecipientID = "0"
    End If
    If varEmailVal = "" Then
        varEmailVal = True
    Else
        varEmailVal = False
    End If
    
    Dim InActive As String = Request.Item("InActive")
    Dim CancelUrl As String = "location='NewsletterExtended_recipient.aspx?ID=" & CategoryID & "&InActive=" & InActive & "'"

    Dim cnRecipient As IDbConnection = Database.CreateConnection("NewsletterExtended.mdb")
    Dim cmdRecipient As IDbCommand = cnRecipient.CreateCommand
    cmdRecipient.CommandText = " SELECT NewsletterExtendedCategory.*, (select top 1 ' checked ' FROM NewsletterExtendedCategoryRecipient where NewsLetterCategoryRecipientCategoryID = NewsletterExtendedCategory.NewsletterCategoryID AND NewsLetterCategoryRecipientRecipientID = " & RecipientID & ") AS Selected " & " FROM NewsletterExtendedCategory"
    Dim drRecipient As IDataReader = cmdRecipient.ExecuteReader

    If RecipientID <> "" And Not RecipientID = "0" Then
        Dim cn As IDbConnection = Database.CreateConnection("NewsletterExtended.mdb")
        Dim cmd As IDbCommand = cn.CreateCommand
        cmd.CommandText = "SELECT * FROM NewsletterExtendedRecipient WHERE NewsletterRecipientID = " & RecipientID
        Dim dr As IDataReader = cmd.ExecuteReader
	
        If dr.Read() Then

            Dim strValue As String = dr("NewsletterRecipientConfirmed").ToString()
            If strValue.ToLower = "false" Or strValue = "0" Then
                NewsletterRecipientConfirmed = False
            Else
                NewsletterRecipientConfirmed = True
            End If

            NewsletterRecipientEmail = dr("NewsletterRecipientEmail").ToString()
            NewsletterRecipientName = dr("NewsletterRecipientName").ToString()
            NewsletterRecipientFormat = dr("NewsletterRecipientFormat").ToString()
            NewsletterRecipientID = dr("NewsletterRecipientID").ToString()
            NewsletterRecipientPassword = dr("NewsletterRecipientPassword").ToString()
            NewsletterAccessUserID = dr("NewsletterAccessUserID").ToString()
        End If
        dr.Close()
        dr.Dispose()
        cmd.Dispose()
        cn.Dispose()
    End If

    If varEmailVal = False Then
        NewsletterRecipientEmail = Request.Item("NewsletterRecipientEmail")
        NewsletterRecipientName = Request.Item("NewsletterRecipientName")
        NewsletterRecipientFormat = Request.Item("NewsletterRecipientFormat")
        NewsletterRecipientID = Request.Item("NewsletterRecipientID")
        NewsletterRecipientPassword = Request.Item("NewsletterRecipientPassword")
        NewsletterRecipientCategoryID = Request.Item("NewsletterRecipientCategoryID")
    End If

    If NewsletterRecipientFormat = "" Then
        NewsletterRecipientFormat = 2
    End If

    varEmailValCategory = ", " & NewsletterRecipientCategoryID & ","
    If IsNothing(RecipientType) Then
        RecipientType = 1
    End If
    If RecipientType = 1 Then
        myCode = ShowUserFields(RecipientID, varFieldCount)
    End If

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<script src="/admin/public/NewsletterExtended.js" type="text/javascript"></script>
<script src="/Admin/Module/Common/Validation.js" type="text/javascript"></script>

<html>
<head>
    <title>
        <%=Translate.JsTranslate("Rediger %%","%%",Translate.Translate("modtager"))%>
    </title>
    <link rel="STYLESHEET" type="text/css" href="../../Stylesheet.css">

    <script language="JavaScript" type="text/javascript">
	
function chkNewsletterCategory(){
	if(document.getElementById('NewsletterRecipientEdit').NewsletterRecipientCategoryID.length)
	{
		for(i=0;i<document.getElementById('NewsletterRecipientEdit').NewsletterRecipientCategoryID.length;i++)
		{
			if(document.getElementById('NewsletterRecipientEdit').NewsletterRecipientCategoryID[i].checked)
			{
				return true;
			}
		}
	}
	else
	{
		if(document.getElementById('NewsletterRecipientEdit').NewsletterRecipientCategoryID.checked)
		{
			return true;
		}
	}
}

function Send(){
<%If RecipientType = 1 Then%>
	if (document.getElementById('NewsletterRecipientEdit').NewsletterRecipientName.value.length < 1)
	{
		alert('<%=Translate.JsTranslate("Der skal angives en værdi i: %%", "%%", Translate.JsTranslate("Navn"))%>');
		return false;
	}
	else if (document.getElementById('NewsletterRecipientEdit').NewsletterRecipientName.value.length > 255)
	{
		alert('<%=Translate.JSTranslate("Max %% tegn i ´%f%´","%%","255", "%f%", Translate.JSTranslate("Navn"))%>');
		return false;
	}
	else if (document.getElementById('NewsletterRecipientEdit').NewsletterRecipientEmail.value.length < 1)
	{
		alert('<%=Translate.JsTranslate("Der skal angives en værdi i: %%", "%%", Translate.JsTranslate("Email"))%>');
		return false;
	}
	else if (document.getElementById('NewsletterRecipientEdit').NewsletterRecipientEmail.value.length > 255)
	{
		alert('<%=Translate.JSTranslate("Max %% tegn i ´%f%´","%%","255", "%f%", Translate.JSTranslate("Email"))%>');
		return false;
	}
	else if (!IsEmailValid(document.getElementById("NewsletterRecipientEmail"),
						"<%=Translate.JSTranslate("Ugyldig_værdi_i:_%%", "%%", Translate.Translate("Email"))%>"))
	{
		return false;
	}
	else if (document.getElementById('NewsletterRecipientEdit').NewsletterRecipientPassword.value.length > 75)
	{
		alert('<%=Translate.JSTranslate("Max %% tegn i ´%f%´","%%","255", "%f%", Translate.JSTranslate("Adgangskode"))%>');
		return false;
	}
	else if (document.getElementById('NewsletterRecipientEdit').NewsletterRecipientFormat[0].checked == false && document.getElementById('NewsletterRecipientEdit').NewsletterRecipientFormat[1].checked == false)
	{
		alert('<%=Translate.JsTranslate("Der skal angives en værdi i: %%", "%%", Translate.JsTranslate("mailformat"))%>');
		return false;
	}
	else if (!chkNewsletterCategory())
	{
		alert('<%=Translate.JsTranslate("Vælg %%", "%%", Translate.JsTranslate("lister"))%>');
		return false;
	}
	<%	If varFieldCount > 0 Then%>
	else if (!FormCheck())
	{
		return false;
	}
	<%	End If%>
	else
	{
		document.getElementById('NewsletterRecipientEdit').action = 'NewsletterExtended_recipient_save.aspx';
		document.getElementById('NewsletterRecipientEdit').submit();
	}
<%Else%>
	if (!chkNewsletterCategory())
	{
		alert('<%=Translate.JsTranslate("Vælg %%", "%%", Translate.JsTranslate("lister"))%>');
		return false;
	}
	else if (document.getElementById('NewsletterRecipientEdit').AccessUser.selectedIndex == -1)
	{
		alert('<%=Translate.JsTranslate("Vælg ´%%´", "%%", Translate.JsTranslate("Brugergruppe"))%>');
		return false;
	}
	else
	{
		document.getElementById('NewsletterRecipientEdit').action = 'NewsletterExtended_recipient_save.aspx';
		document.getElementById('NewsletterRecipientEdit').submit();
	}
<%End If%>
}

function ChangeType(ID)
{
    location="NewsletterExtended_recipient_edit.aspx?RecipientID=<%=RecipientID%>&RecipientType=" + ID
}

    </script>

    <%=Gui.MakeHeaders(Translate.Translate("Rediger %%", "%%", Translate.Translate("modtager")), Translate.Translate("Oplysninger") & ", " & Translate.Translate("Lister"), "javascript")%>
    <body leftmargin="20" topmargin="16">
        <%=Gui.MakeHeaders(Translate.Translate("Rediger %%", "%%", Translate.Translate("modtager")), Translate.Translate("Oplysninger") & ", " & Translate.Translate("Lister"), "html")%>
        <table border="0" cellpadding="0" cellspacing="0" width="598" class="tabTable">
            <form name="NewsletterRecipientEdit" id="NewsletterRecipientEdit" method="post" action="">
                <input type="Hidden" value="<%=NewsletterRecipientID%>" name="NewsletterRecipientID">
                <input type="Hidden" value="<%=RecipientType%>" name="RecipientType">
                <input type="Hidden" value="<%=CategoryID%>" name="TransferCategoryID" id="TransferCategoryID">
                <input type="Hidden" value="<%=InActive%>" name="NewsletterInActive" id="NewsletterInActive">
                <tr>
                    <td valign="top">
                        <!-- TAB1 -- TAB1 -- TAB1 -- TAB1 -- TAB1 -- TAB1 -- TAB1 -- TAB1 -- TAB1 -- TAB1 -- TAB1 -- TAB1 -- TAB1 -- TAB1 -- TAB1 -- TAB1 -- TAB1 -->
                        <div id="Tab1">
                            <br>
                            <table cellspacing="0" border="0" cellpadding="0" width="498">
                                <tr>
                                    <td>
                                        <%=Gui.GroupBoxStart(Translate.Translate("Modtager"))%>
                                        <%If RecipientType = 1 Then%>
                                        <table cellpadding="2" cellspacing="0" width='570'>
                                            <tr>
                                                <td width="170">
                                                    <%=Translate.Translate("Type")%>
                                                </td>
                                                <td nowrap>
                                                    <input onclick="ChangeType(1);" <%If RecipientType = 1 Then 
										response.write("checked") 
								  End IF 
								%> type="radio" name="cbType" value="1">&nbsp;<%=Translate.Translate("Bruger")%>
                                                    &nbsp;&nbsp;&nbsp;<input onclick="ChangeType(2);" <% If RecipientType = 2 Then 
										response.write("checked")
								   End IF 
								%> type="radio" name="cbType" value="2">&nbsp;<%=Translate.Translate("Extranet brugergruppe")%>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <%=Translate.Translate("Navn")%>
                                                </td>
                                                <td>
                                                    <input class="std" type="Text" value="<%=Server.HtmlEncode(NewsletterRecipientName)%>" name="NewsletterRecipientName"></td>
                                            </tr>
                                            <tr valign="top">
                                                <td>
                                                    <%=Translate.Translate("Email")%>
                                                </td>
                                                <td>
                                                    <input class="std" type="Text" value="<%=NewsletterRecipientEmail%>" id="NewsletterRecipientEmail" name="NewsletterRecipientEmail" />
                                                    <%If varEmailVal = False Then%>
                                                    &nbsp;<font color="red"><%=Translate.JsTranslate("Ugyldig værdi i: %%", "%%", Translate.JsTranslate("Email adresse"))%></font>
                                                    <% End If%>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <%=Translate.Translate("Adgangskode")%>
                                                </td>
                                                <td>
                                                    <input class="std" type="Text" value="<%=Server.HtmlEncode(NewsletterRecipientPassword)%>" name="NewsletterRecipientPassword"></td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <%=Translate.Translate("Bekræftet")%>
                                                </td>
                                                <td>
                                                    <input class="" type="checkbox" value="confirmed" name="NewsletterRecipientConfirmed" 
                                                    <% if NewsletterRecipientConfirmed then
                                                     response.write("checked") 
                                                     end if %>
                                                     ></td>
                                            </tr>
                                        </table>
                                        <%Else%>
                                        <table cellpadding="2" cellspacing="0">
                                            <tr>
                                                <td width="170">
                                                    <%=Translate.Translate("Type")%>
                                                </td>
                                                <td>
                                                    <input onclick="ChangeType(1);" <%If RecipientType = 1 Then 
										response.write("checked") 
								  End IF 
								%> type="radio" name="cbType" value="1">&nbsp;<%=Translate.Translate("Bruger")%>
                                                    &nbsp;&nbsp;&nbsp;<input onclick="ChangeType(2);" <% If RecipientType = 2 Then 
										response.write("checked")
								   End IF 
								%> type="radio" name="cbType" value="2">
                                                    &nbsp;<%=Translate.Translate("Extranet brugergruppe")%>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <%=Translate.Translate("Brugergruppe")%>
                                                </td>
                                                <td>
                                                    <%=Gui.UserGroupList("AccessUser", NewsletterAccessUserID)%>
                                                </td>
                                            </tr>
                                        </table>
                                        <%End If%>
                                        <%=Gui.GroupBoxEnd%>
                                    </td>
                                </tr>
                                <%
                                    If RecipientType = 1 Then
                                        If varFieldCount > 0 Then
                                            Response.Write("<tr><td>")
                                            Response.Write(Gui.GroupBoxStart(Translate.Translate("Bruger felter")))
                                            Response.Write("<table>" & myCode & "</table>")
                                            Response.Write(Gui.GroupBoxEnd)
                                            Response.Write("</td></tr>")
                                        End If
                                    End If
                                %>
                                <tr>
                                    <td height="5">
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <%=Gui.GroupBoxStart(Translate.Translate("Email"))%>
                                        <table cellpadding="2" cellspacing="0">
                                            <tr>
                                                <td width='170px'>
                                                    <%=Translate.Translate("Format")%>
                                                </td>
                                                <td>
                                                    <%=Gui.RadioButton(NewsletterRecipientFormat, "NewsletterRecipientFormat", "1")%>
                                                    &nbsp;<%=Translate.Translate("Text")%></td>
                                            </tr>
                                            <tr>
                                                <td>
                                                </td>
                                                <td>
                                                    <%=Gui.RadioButton(NewsletterRecipientFormat, "NewsletterRecipientFormat", "2")%>
                                                    &nbsp;<%=Translate.Translate("Html")%></td>
                                            </tr>
                                        </table>
                                        <%=Gui.GroupBoxEnd%>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <!-- TAB2 -- TAB2 -- TAB2 -- TAB2 -- TAB2 -- TAB2 -- TAB2 -- TAB2 -- TAB2 -- TAB2 -- TAB2 -- TAB2 -- TAB2 -- TAB2 -- TAB2 -- TAB2 -- TAB2 -->
                        <div id="Tab2" style="display: none;">
                            <br>
                            <table cellspacing="0" border="0" cellpadding="0" width="598">
                                <tr>
                                    <td colspan="2">
                                        <%=Gui.GroupBoxStart(Translate.Translate("Abonnementer"))%>
                                        <table cellpadding="2" cellspacing="0" width="570">
                                            <%
                                                Dim blnDrRecipientHasRows As Boolean = False
                                                Do While drRecipient.Read()
                                                    If Not blnDrRecipientHasRows Then
                                                        blnDrRecipientHasRows = True
                                                    End If
                                                    Response.Write("<tr valign='top'>")
                                                    Response.Write("<td width=20><input name='NewsletterRecipientCategoryID' ")
                                                    Response.Write(drRecipient("Selected").ToString())
                                                    If InStr(varEmailValCategory, ", " & drRecipient("NewsletterCategoryID").ToString() & ",") Then
                                                        Response.Write(" Checked ")
                                                    ElseIf CStr(CategoryID) = CStr(drRecipient("NewsletterCategoryID").ToString()) Then
                                                        Response.Write(" Checked ")
                                                    End If
                                                    Response.Write("type='Checkbox' class='clean' value='" & drRecipient("NewsletterCategoryID").ToString() & "'></td>")
                                                    Response.Write("<td>&nbsp;" & drRecipient("NewsletterCategoryName").ToString() & "</td>")
                                                    Response.Write("</tr>")
                                                Loop
                                                If Not blnDrRecipientHasRows Then
                                                    Response.Write("<tr>")
                                                    Response.Write("<td colspan=""2"">" & Translate.Translate("Der er ikke oprettet nogen %c%", "%c%", Translate.Translate("lister")) & "</td>")
                                                    Response.Write("</tr>")
                                                End If
                                            %>
                                        </table>
                                        <%=Gui.GroupBoxEnd%>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td align="right" valign="bottom">
                        <%=Gui.MakeOkCancelHelp("javascript:Send();", CancelUrl, True, "modules.newsletterextended.general.recipient.edit", "newsletterV2")%>
                    </td>
                </tr>
        </table>
    </body>
</html>
<%
    drRecipient.Dispose()
    cmdRecipient.Dispose()
    cnRecipient.Dispose()

%>
<%=Gui.SelectTab()%>
<%
    If Request.QueryString("Tab") <> "" Then
%>

<script>
	alert('<%=Translate.JsTranslate("Modtageren eksisterer i forvejen!")%>')
</script>

<%
End If
%>
<%  ' BBR 01/2005
    Translate.GetEditOnlineScript()
%>
