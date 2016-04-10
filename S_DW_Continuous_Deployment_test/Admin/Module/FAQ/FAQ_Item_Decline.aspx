<%@ Page CodeBehind="FAQ_Item_Decline.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.FAQ_Item_Decline" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>

<%

Dim cWorkflow As Object
Dim Base.ChkNumber() As String

Dim FAQItemID As String
Dim WorkflowID As String
Dim WorkflowCurrentID As String
Dim WorkflowNewID As Byte
Dim FAQItemCategoryID As Byte

FAQItemID = Base.ChkNumber(CInt(Request.QueryString.Item("FAQItemID")))
WorkflowID = Base.ChkNumber(CInt(Request.QueryString.Item("workflowid")))
WorkflowCurrentID = Base.ChkNumber(CInt(Request.QueryString.Item("workflowcurrentid")))
WorkflowNewID = 0
FAQItemCategoryID = 0

' Load workflow and page table
cWorkflow = New Workflow

' Set properties
cWorkflow.CurrentState = WorkflowCurrentID
cWorkflow.Workflow = WorkflowID
cWorkflow.EmailTemplate = "FaqApprove.html"
cWorkflow.NotifyMailLink = "module/FAQ/FAQ_Item_Edit.aspx?FAQID=[SystemChildID]"

cWorkflow.Database = "dynamic.mdb"
cWorkflow.DatabaseTable = "FAQItem"
cWorkflow.DatabaseStateField = "FAQItemWorkflowState"
cWorkflow.DatabaseWhere = "FAQItemID=" & FAQItemID
cWorkflow.DatabaseTitle = "FAQItemQHeader"

cWorkflow.Comment = Request.QueryString.Item("FAQItemWorkflowComment")
cWorkflow.SystemName = "faq"
cWorkflow.SystemChildID = FAQItemID

FAQItemCategoryID = cWorkflow.DeclineStep("FAQItemCategoryID")

'UPGRADE_NOTE: Object cWorkflow may not be destroyed until it is garbage collected. Copy this link in your browser for more: 'ms-help://MS.VSCC.2003/commoner/redir/redirect.htm?keyword="vbup1029"'
cWorkflow = Nothing

%>
<script language="JavaScript">
	//parent.right.location = "FAQ_Item_Edit.aspx?tab=2&CategoryID=<%=FAQItemCategoryID%>&tab=2&FAQID=<%=FAQItemID%>";
	parent.right.location = "FAQ_Item_List.aspx?CategoryID=<%=FAQItemCategoryID%>";
</script>
