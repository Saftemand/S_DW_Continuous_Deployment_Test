    <%@ Page CodeBehind="NewsletterExtended_Recipient.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.NewsletterExtended_Recipient" %>
    <%@ Import namespace="Dynamicweb" %>
    <%@ Import namespace="Dynamicweb.Backend" %>
    <%@ Import namespace="System.Data" %>

    <%
    Response.Expires=-1
    Dim varLocation As String
    Dim StatusText As String
    Dim Name As String
    Dim SearchStr As String
        Dim Position As Integer
    Dim strSql As String
    Dim NLShowAllOnList As Integer
    Dim SQLSearchStr As String
    Dim NLRowNumbers As Integer
    Dim AllCategoryField As String
    Dim PositionNext As Integer
    Dim CategoryID As String
    Dim SortOrder As String
    Dim SortColumn As String
    Dim recordCount As Integer
        Dim SQL As String
        Dim InActive As String

        CategoryID = Request.Item("ID")
        SortColumn = Request.Item("SortColumn")
        SortOrder = Request.Item("SortOrder")
        Position = Base.ChkNumber(Request.Item("Position"))
        SearchStr = Request.Item("SearchStr")
        AllCategoryField = Request.Item("AllCategoryField")
        InActive = Request.Item("InActive")

    NLShowAllOnList= Base.ChkNumber(Base.GetGS("/Globalsettings/Modules/NewsletterExtended/Lists/ShowAllRowsInLists"))
    NLRowNumbers = Base.ChkNumber(Base.GetGS("/Globalsettings/Modules/NewsletterExtended/Lists/NumberOfRowsInLists"))

    recordCount = 0

    If NLRowNumbers = 0 Then
	    NLRowNumbers = 20
    End If
    If NLShowAllOnList = 1 Then
	    NLRowNumbers = 32000
    End If
        PositionNext = Position + NLRowNumbers

    If isNothing(Position) Then
	    Position = 0
    End If
    If isNothing(SortColumn) Then
	    SortColumn = "NewsletterRecipientName"
    End If
    If SortOrder = "" Then
	    SortOrder = "ASC"
    End If

    Sql = " SELECT distinct NewsletterExtendedRecipient.NewsletterRecipientID, NewsletterExtendedRecipient.NewsletterRecipientName, NewsletterExtendedRecipient.NewsletterRecipientPassword, NewsletterExtendedRecipient.NewsletterRecipientEmail, NewsletterExtendedRecipient.NewsletterRecipientFormat, NewsletterExtendedRecipient.NewsletterRecipientCreated, NewsletterExtendedRecipient.NewsletterAccessUserID, NewsletterExtendedCategoryRecipient.NewsLetterCategoryRecipientType, NewsletterExtendedEmailCheck.NewsletterEmailCheckConfidenceRating, NewsletterExtendedEmailCheck.NewsletterEmailCheckRecipientID, NewsletterExtendedEmailCheck.NewsletterEmailCheckID " & " FROM (NewsletterExtendedRecipient INNER JOIN NewsletterExtendedCategoryRecipient ON NewsletterExtendedRecipient.NewsletterRecipientID = NewsletterExtendedCategoryRecipient.NewsLetterCategoryRecipientRecipientID) LEFT JOIN NewsletterExtendedEmailCheck ON NewsletterExtendedRecipient.NewsletterRecipientID = NewsletterExtendedEmailCheck.NewsletterEmailCheckRecipientID "
        'If SearchStr <> "" Or AllCategoryField = "" Then
        SQL = SQL & " WHERE 1 = 1 "
        'End If
        If AllCategoryField = "" And CategoryID <> "" Then
            SQL = SQL & " And NewsletterExtendedCategoryRecipient.NewsLetterCategoryRecipientCategoryID = " & CategoryID
        End If
        If SearchStr <> "" Then
            SQLSearchStr = Replace(SearchStr, "'", "''")
            SQL = SQL & " AND ( NewsletterRecipientName LIKE '%" & SQLSearchStr & "%' OR NewsletterRecipientEmail LIKE '%" & SQLSearchStr & "%' )"
        End If

        If InActive = "true" Then
            SQL += " AND NewsletterRecipientConfirmed = 0"
        Else
            SQL += " AND (NewsletterRecipientConfirmed <> 0 OR NewsletterRecipientConfirmed IS NULL)"
        End If

        
        'Base.w(SQL)
        
        Dim cnAccess As IDbConnection = Database.CreateConnection("Access.mdb")
        Dim cmdAccess As IDbCommand = cnAccess.CreateCommand()
        Dim drAccess As IDataReader

        Dim newsletterConn As IDbConnection = Database.CreateConnection("NewsletterExtended.mdb")
        Dim cmdNewsletter As IDbCommand = newsletterConn.CreateCommand

        Dim adNewsletterAdapter As IDbDataAdapter = Database.CreateAdapter()
        Dim cb As Object = Database.CreateCommandBuilder(adNewsletterAdapter)
        Dim dsNewsletter As DataSet = New DataSet

        cmdNewsletter.CommandText = SQL
        adNewsletterAdapter.SelectCommand = cmdNewsletter
        adNewsletterAdapter.Fill(dsNewsletter)
        
        Dim recipientView As DataView = New DataView(dsNewsletter.Tables(0))

        'RSCategory.open(Sql, Database.CreateConnection("NewsletterExtended.mdb"), 3, 3)

        'do while not RSCategory.Eof
        '	If IsNumeric(RSCategory("NewsletterAccessUserID")) Then
        '		strSql = " SELECT AccessUserID, AccessUserUserName FROM AccessUser " & '				 " WHERE AccessUserID = " & RSCategory("NewsletterAccessUserID")
        '		Set rsAccess = cnAccess.Execute(strSql)
        '		If Not rsAccess.Eof Then
        '			RSCategory("NewsletterRecipientName") = rsAccess("AccessUserUserName")
        '		End If
        '		Set rsAccess = Nothing
        '	End If
        '	RSCategory.MoveNext
        '	recordCount = recordCount + 1
        'Loop

        If recipientView.Count > 0 Then
            recipientView.Sort = SortColumn & " " & SortOrder
        End If

        If SortOrder = "ASC" Then
            SortOrder = "DESC"
        Else
            SortOrder = "ASC"
        End If

        varLocation = "location='NewsletterExtended_recipient.aspx?ID=" & CategoryID & "&SortOrder=" & SortOrder & "&SearchStr=" & Server.UrlEncode(SearchStr) & "&SortColumn="

        StatusText = recipientView.Count & " " & Translate.Translate("modtager") & ", " & Position & " - "
        If PositionNext > recipientView.Count Then
            StatusText = StatusText & recipientView.Count
        Else
            StatusText = StatusText & PositionNext
        End If

    %>

    <SCRIPT LANGUAGE="JavaScript">
    <!--
    parent.updateinfo('<%=StatusText%>');

    function MyLink(RecipientID, RecipientType)
    {
        parent.document.getElementById("StatusFrame").setAttribute("src", "NewsletterExtended_Blank_with_color.html");
        parent.updateinfo('');
        location="NewsletterExtended_recipient_edit.aspx?RecipientID=" + RecipientID + "&RecipientType=" + RecipientType + "&CategoryID=<%=CategoryID%>&InActive=<%=InActive%>"
    }

    function RecipientStats(RecipientID)
    {
	    parent.document.getElementById("StatusFrame").setAttribute("src", "NewsletterExtended_Blank_with_color.html");
	    parent.updateinfo('');
	    location="/admin/module/newsletterextended/statisticsv2/Report_Letter_Recipient.aspx?RecipientID=" + RecipientID;
    }

    function CheckMailLink(RecipientID)
    {
    location="NewsletterExtended_recipient_checkemail_detail.aspx?RecipientID=" + RecipientID + "&ID=<%=CategoryID%>&SortOrder=<%=SortOrder%>&SearchStr=<%=Server.URLEncode(SearchStr)%>&SortColumn=<%=SortColumn%>&PageType=Back"
    }

    function DeleteRecipient(RecipientID)
    {	
	    if(confirm("<%=Translate.JsTranslate("Slet %%?", "%%", Translate.JSTranslate("modtager"))%>"))
		    location="NewsletterExtended_recipient_del.aspx?RecipientID=" + RecipientID + "&CategoryID=<%=CategoryID%>&SortOrder=<%=SortOrder%>&SortColumn=<%=SortColumn%>";
    }

    function cc(objRow){ //Change color of row when mouse is over... (ChangeColor)
	    objRow.style.backgroundColor='#E1DED8';
    }

    function ccb(objRow){ //Remove color of row when mouse is out... (ChangeColorBack)
	    objRow.style.backgroundColor='';
    }

    //-->
    </SCRIPT>
    <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
    <HTML>
    <HEAD>
    <link rel="STYLESHEET" type="text/css" href="../../Stylesheet.css">

    </HEAD>
    <BODY>
    <table cellpadding=0 cellspacing=0 border=0 class=cleantable  style="margin:0px;" width="100%" ID="Table1">
	    <tr bgColor="#E1DED8" height=20 width="100%">
		    <td background="../../images/HeaderBG.gif"></td>
		    <td background="../../images/HeaderBG.gif"></td>
		    <td class='H' onclick="<%=varLocation%>NewsletterRecipientName';" background="../../images/HeaderBG.gif"><strong><%=Translate.Translate("Navn")%></strong></td>
		    <td class='H' onclick="<%=varLocation%>NewsletterRecipientEmail';" background="../../images/HeaderBG.gif"><strong><%=Translate.Translate("Email")%></strong></td>
		    <td class='H' onclick="<%=varLocation%>NewsletterRecipientCreated';" background="../../images/HeaderBG.gif"><strong><%=Translate.Translate("Oprettet")%></strong></td>
    <!--		<td background="../../images/HeaderBG.gif"><strong><%=Translate.Translate("Rating")%></strong></td>-->
		    <td align='middle' background="../../images/HeaderBG.gif"><strong>&nbsp;<%=Translate.Translate("Slet")%></strong></td>
	    </tr>
	    <%
	        For j As Integer = 0 To recipientView.Count - 1
	            If j >= Position And j < PositionNext Then
	                If IsNumeric(recipientView(j)("NewsletterAccessUserID").ToString()) And Not recipientView(j)("NewsletterAccessUserID").ToString() = "0" Then
	                    cmdAccess.CommandText = " SELECT AccessUserID, AccessUserUserName FROM AccessUser " & " WHERE AccessUserID = " & recipientView(j)("NewsletterAccessUserID").ToString
	                    drAccess = cmdAccess.ExecuteReader()
	                    If drAccess.Read() Then
	                        Name = drAccess("AccessUserUserName").ToString
	                    End If
	                    drAccess.Dispose()
    			
	                Else
	                    Name = Base.ChkString(recipientView(j)("NewsletterRecipientName"))
	                End If
    		
	                Response.Write("<tr onmouseout='ccb(this);' onmouseover='cc(this);' height='20px'>" & vbNewLine & _
	                "<td class='H' width='25' onclick='Javascript:MyLink(" & recipientView(j)("NewsletterRecipientID").ToString & ", " & recipientView(j)("NewsLetterCategoryRecipientType").ToString & ");'>&nbsp;" & vbNewLine & _
	                "<img alt src='../../Images/Icons/Module_Newsletter_User_Small.gif' border='0'>" & vbNewLine & _
	                "</td>" & vbNewLine & _
	                "<td onClick='Javascript:RecipientStats(" & recipientView(j)("NewsletterRecipientID").ToString & ");' class='H' width='30'>&nbsp;" & vbNewLine & _
	                "<img alt src='../../Images/Icons/Module_Newsletter_Stat_Small.gif' border='0'>" & vbNewLine & _
	                "</td>" & vbNewLine & _
	                "<td class='H' onclick='Javascript:MyLink(" & recipientView(j)("NewsletterRecipientID").ToString & ", " & recipientView(j)("NewsLetterCategoryRecipientType").ToString & ");'>" & vbNewLine & _
	                Name & vbNewLine & _
	                "</td>" & vbNewLine & _
	                "<td class='H' onclick='Javascript:MyLink(" & recipientView(j)("NewsletterRecipientID").ToString & ", " & recipientView(j)("NewsLetterCategoryRecipientType").ToString & ");'>" & vbNewLine & _
	                recipientView(j)("NewsletterRecipientEmail").ToString & vbNewLine & _
	                "</td>" & vbNewLine & _
	                "<td class='H' onclick='Javascript:MyLink(" & recipientView(j)("NewsletterRecipientID").ToString & ", " & recipientView(j)("NewsLetterCategoryRecipientType").ToString & ");'>" & vbNewLine & _
	                Dates.ShowDate(Base.ChkDate(recipientView(j)("NewsletterRecipientCreated")), Dates.DateFormat.Short, False) & vbNewLine & _
	                "</td>")
    		
	                Response.Write("<td align='middle'><a href=""JavaScript:DeleteRecipient('" & recipientView(j)("NewsletterRecipientID").ToString & "')"">" & vbNewLine & _
	                "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src=""../../images/Delete.gif"" border=""0"" width=""15"" height=""17"" alt=""" & Translate.Translate("Slet %%", "%%", Translate.Translate("modtager")) & """></a>" & vbNewLine & _
	                "</td>" & vbNewLine & _
	                "</tr>")
	            End If
	        Next
    %>
    </table>

    </BODY>
    </HTML>
    <%
    If SortOrder = "ASC" Then
	    SortOrder = "DESC"
    Else
	    SortOrder = "ASC"
    End If

        Response.Write("<SCRIPT LANGUAGE=""JavaScript"">" & vbNewLine & "<!--" & vbNewLine & "parent.document.getElementById(""StatusFrame"").setAttribute(""src"", ""NewsletterExtended_Paging_search.aspx?TypeID=" & CategoryID & "&Position=" & Position & "&SearchStr=" & Server.UrlEncode(SearchStr) & "&Amount=" & recipientView.Count & "&SortOrder=" & SortOrder & "&AllCategoryField=" & AllCategoryField & "&Type=NewsletterExtended_Recipient" & "&SortColumn=" & Base.ChkString(Base.Request("SortColumn")) & "&inActive=" & InActive & """);" & vbNewLine & "//-->" & vbNewLine & "</SCRIPT>")

    cnAccess.Dispose()
    cmdAccess.Dispose()
    dsNewsletter.Dispose()
    cmdNewsletter.Dispose()
    newsletterConn.Dispose()
    %>

    <% ' BBR 01/2005
	    Translate.GetEditOnlineScript()
    %>
