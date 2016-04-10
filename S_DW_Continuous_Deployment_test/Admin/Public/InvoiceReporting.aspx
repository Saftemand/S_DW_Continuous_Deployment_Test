<%@ Page Language="vb" %>

<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="System.Data" %>
<%--  CodeBehind="InvoiceReporting.aspx.vb" Inherits="Dynamicweb.Admin.InvoiceReporting" --%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
     <script language="VB" runat="server">
         Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs)
             Dim sb As StringBuilder = New StringBuilder()
             HttpContext.Current.Response.Write(GetAll())
             HttpContext.Current.Response.End()
         End Sub

         Private Shared Function GetAll() As String
             Dim sb As StringBuilder = New StringBuilder()
             Try
                 sb.AppendFormat("""{0}"",""{1}"",""{2}"",""{3}"",""{4}"",""{5}""", "VisitYear", "VisitMonth", "SessionCount", "SessionFromSearchEngineCount", "FormSubmits", "Result")
                 sb.AppendLine()

                 Dim sql As String = "select t0.StatYear, t0.StatMonth, t1.SessionsCount, t2.SessionsCountWords, t3.FormCount from " &
                 "((( " &
                 "SELECT [Statv2SessionYear] as StatYear,[Statv2SessionMonth] as StatMonth " &
                 "FROM [Statv2Session] GROUP BY [Statv2SessionYear], [Statv2SessionMonth] " &
                 ") t0 " &
                 "left join " &
                 "(SELECT COUNT([Statv2SessionAreaID]) AS SessionsCount,[Statv2SessionYear] as StatYear ,[Statv2SessionMonth] as StatMonth " &
                 "FROM [Statv2Session] GROUP BY [Statv2SessionYear], [Statv2SessionMonth]) t1 " &
                 "on t0.StatYear = t1.StatYear and t0.StatMonth = t1.StatMonth) " &
                 "left join " &
                 "(SELECT COUNT([Statv2SessionAreaID]) AS SessionsCountWords ,[Statv2SessionYear] as StatYear ,[Statv2SessionMonth] as StatMonth " &
                 "FROM [Statv2Session] WHERE [Statv2SessionRefererSearchWord] <> '' GROUP BY [Statv2SessionYear], [Statv2SessionMonth]) t2 " &
                 "on t0.StatYear = t2.StatYear and t0.StatMonth = t2.StatMonth) " &
                 "left join " &
                 "(SELECT COUNT(Statv2ObjectType) As FormCount, DatePart('yyyy',[Statv2ObjectTimestamp]) As StatDateYear, DatePart('m',[Statv2ObjectTimestamp]) As StatDateMonth " &
                 "FROM Statv2Object WHERE Statv2ObjectType = 'Form' " &
                 "GROUP BY  DatePart('yyyy',[Statv2ObjectTimestamp]), DatePart('m',[Statv2ObjectTimestamp])) t3 " &
                 "on t0.StatYear = t3.StatDateYear and t0.StatMonth = t3.StatDateMonth "

                 Using dr As IDataReader = Database.CreateDataReader(sql, "Statisticsv2.mdb")
                     While (dr.Read())
                         Dim year As String = Base.ChkString(dr("StatYear"))
                         Dim month As String = Base.ChkString(dr("StatMonth"))
                         Dim SessionCount As String = Base.ChkString(dr("SessionsCount"))
                         Dim SessionCountWords As String = Base.ChkString(dr("SessionsCountWords"))
                         Dim SessionCountForm As String = Base.ChkString(dr("FormCount"))
                         sb.AppendFormat("""{0}"",""{1}"",""{2}"",""{3}"",""{4}"",""{5}""", year, month, SessionCount, SessionCountWords, SessionCountForm, "True")
                         sb.AppendLine()
                     End While
                 End Using

             Catch ex As Exception
                 Return ex.Message
             End Try
             Return sb.ToString()
         End Function
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
Inside div    
    </div>
    </form>
</body>
</html>
