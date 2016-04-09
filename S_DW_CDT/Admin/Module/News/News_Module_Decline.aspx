<%@ Page CodeBehind="News_Module_Decline.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.News_Module_Decline" %>
<%@ Import namespace="Dynamicweb.Backend" %>


<%
Dim cWorkflow As Object
Dim CheckIn As Object
Dim NewsCategoryID As Object
Dim Base.ChkNumber() As Object

Dim NewsID As Object
Dim WorkflowID As Object
Dim WorkflowCurrentID As Object
Dim WorkflowNewID As Byte
Dim ParagraphPageID As Byte
%>

<!-- #INCLUDE FILE="../../common.aspx" -->


<!-- #INCLUDE FILE="../../Common_Workflow.aspx" -->

<%
NewsID = Base.ChkNumber(CInt(Request.QueryString.Item("NewsID")))
WorkflowID = Base.ChkNumber(CInt(Request.QueryString.Item("workflowid")))
WorkflowCurrentID = Base.ChkNumber(CInt(Request.QueryString.Item("workflowcurrentid")))
WorkflowNewID = 0
ParagraphPageID = 0

' Load workflow and page table
cWorkflow = New Workflow

' Set properties
cWorkflow.CurrentState = WorkflowCurrentID
cWorkflow.Workflow = WorkflowID
cWorkflow.EmailTemplate = "NewsApprove.html"
cWorkflow.NotifyMailLink = "module/News/News_Module_Edit.aspx?tab=2&NewsID=[SystemChildID]"

cWorkflow.Database = "dynamic.mdb"
cWorkflow.DatabaseTable = "News"
cWorkflow.DatabaseStateField = "NewsWorkflowState"
cWorkflow.DatabaseWhere = "NewsID=" & NewsID
cWorkflow.DatabaseTitle = "NewsHeading"

cWorkflow.Comment = Request.QueryString.Item("NewsWorkflowComment")
cWorkflow.SystemName = "news"
cWorkflow.SystemChildID = NewsID

NewsCategoryID = cWorkflow.DeclineStep("NewsCategoryID")

'UPGRADE_NOTE: Object cWorkflow may not be destroyed until it is garbage collected. Copy this link in your browser for more: 'ms-help://MS.VSCC.2003/commoner/redir/redirect.htm?keyword="vbup1029"'
cWorkflow = Nothing

If NewsID > 0 Then
	Call CheckIn(NewsID, "News")
End If
%>
<script language="JavaScript">
	//parent.right.location = "News_Module_Edit.aspx?tab=2&CategoryID=<%=NewsCategoryID%>&tab=2&NewsID=<%=NewsID%>";
	parent.right.location = "News_Module_List.aspx?CategoryID=<%=NewsCategoryID%>";
</script>
