<%@ Page Language="vb" %>

<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Frontend" %>
<%@ Import Namespace="System.Xml" %>

<script runat="server" language="vb">
	Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs)
        Try
            HttpContext.Current.Response.Buffer = True
            HttpContext.Current.Response.ClearContent()
            HttpContext.Current.Response.ClearHeaders()
            HttpContext.Current.Response.ContentType = "application/xml"


			Dim Pageview As Dynamicweb.Frontend.PageView = Dynamicweb.Frontend.PageView.GetPageview
            Dim Nav As New XmlNavigation(Pageview)
            Nav.Sitemap = True
            Dim NavXmlDoc As XmlDocument

            Dim ExpandMode As XMLNavigation.Expand
            If String.IsNullOrEmpty(Base.Request("Expand")) Then
                ExpandMode = XMLNavigation.Expand.All
            Else
                Dim Expand As Integer = Base.ChkInteger(Base.Request("Expand"))
                If Expand = 0 Then
                    ExpandMode = XMLNavigation.Expand.None
                ElseIf Expand = 1 Then
                    ExpandMode = XMLNavigation.Expand.Path
                ElseIf Expand = 2 Then
                    ExpandMode = XMLNavigation.Expand.All
                ElseIf Expand = 3 Then
                    ExpandMode = XMLNavigation.Expand.PathOnly
                End If
            End If

            Dim StartLevel As Integer = Base.ChkInteger(Base.Request("StartLevel"))
            If StartLevel = 0 Then
                StartLevel = 1
            End If
            Dim StopLevel As Integer = Base.ChkInteger(Base.Request("StopLevel"))
            If StopLevel = 0 Then
                StopLevel = 99
            End If
            Dim ParentID As Integer = Base.ChkInteger(Base.Request("ParentID"))
            Dim AreaID As Integer = Base.ChkInteger(Base.Request("AreaID"))

            'Nav.NavigationName = Base.ChkString(OldNavigationSettings.Value("TemplateMenuName"))
            NavXmlDoc = Nav.XML(ParentID, StartLevel, StopLevel, ExpandMode, AreaID)
            NavXmlDoc.PreserveWhitespace = False
	
            HttpContext.Current.Response.Write(NavXmlDoc.OuterXml)
        Catch ex As Exception
            ' pageview in backend causes trouble with static frontpage., see PageView.vb:1671
            Response.Clear()
            Response.Write("<xml></xml>")
        End Try
    End Sub
</script>
