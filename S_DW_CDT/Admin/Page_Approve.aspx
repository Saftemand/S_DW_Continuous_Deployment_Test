<%@ Import namespace="ADODB" %>
<%'UPGRADE_NOTE: All function, subroutine and variable declarations were moved into a script tag global. Copy this link in your browser for more: ms-its:C:\Program Files\ASP to ASP.NET Migration Assistant\AspToAspNet.chm::/1007.htm%>
<script language="VB" runat="Server">
'UPGRADE_ISSUE: Workflow object was not upgraded. Copy this link in your browser for more: 'ms-help://MS.VSCC.2003/commoner/redir/redirect.htm?keyword="vbup2068"'
Dim cWorkflow As New Workflow
Dim ChkNumber() As Object
Dim GetConn() As Object
Dim cnDynamic As Object
Dim OriginalPage As Object
Dim ParagraphSql As String
Dim DWWorkflow_ApproveParagraph As Boolean
Dim PageVersionNumber As Object
Dim PageVersionSQL As String
Dim ParentID As Object
Dim rsParagraph As ADODB.Recordset
Dim rsPageVersion As ADODB.Recordset

Dim PageID As Object
Dim WorkflowID As Object
Dim WorkflowCurrentID As Object
Dim WorkflowNewID As Byte
Dim AreaID As Byte

' Approve all previous versions of page 
Dim PageVersionParentID As Object


</script>
<%
'**************************************************************************************************
'	Current version:	1.0.0
'	Created:			29-01-2003
'	Last modfied:		29-01-2003
'
'	Purpose: Approve page or step
'
'	Revision history:
'		1.0   - 29-01-2003 - Rasmus Foged
'		First version
'**************************************************************************************************
%>
<%'UPGRADE_NOTE: Language element '#INCLUDE' was migrated to the same language element but still may have a different behavior. Copy this link in your browser for more: ms-its:C:\Program Files\ASP to ASP.NET Migration Assistant\AspToAspNet.chm::/1011.htm  %>
<%'UPGRADE_NOTE: The file 'common.asp' was not found in the migration directory. Copy this link in your browser for more: ms-its:C:\Program Files\ASP to ASP.NET Migration Assistant\AspToAspNet.chm::/1003.htm  %>
<!-- #INCLUDE FILE="common.asp" -->

<%'UPGRADE_NOTE: Language element '#INCLUDE' was migrated to the same language element but still may have a different behavior. Copy this link in your browser for more: ms-its:C:\Program Files\ASP to ASP.NET Migration Assistant\AspToAspNet.chm::/1011.htm  %>
<%'UPGRADE_NOTE: The file 'Common_Workflow.asp' was not found in the migration directory. Copy this link in your browser for more: ms-its:C:\Program Files\ASP to ASP.NET Migration Assistant\AspToAspNet.chm::/1003.htm  %>
<!-- #INCLUDE FILE="Common_Workflow.asp" -->

<%PageID = ChkNumber(CInt(Request.QueryString.Item("PageID")))
WorkflowID = ChkNumber(CInt(Request.QueryString.Item("workflowid")))
WorkflowCurrentID = ChkNumber(CInt(Request.QueryString.Item("workflowcurrentid")))
WorkflowNewID = 0
AreaID = 0

' Load workflow and page table
cWorkflow = New Workflow

' Set properties
cWorkflow.CurrentState = WorkflowCurrentID
cWorkflow.Workflow = WorkflowID
cWorkflow.EmailTemplate = "PageApprove.html"
cWorkflow.NotifyMailLink = "Page_Edit.aspx?ID=[SystemChildID]"

cWorkflow.Database = "dynamic.mdb"
cWorkflow.DatabaseTable = "Page"
cWorkflow.DatabaseStateField = "PageWorkflowState"
cWorkflow.DatabaseWhere = "PageID=" & PageID
cWorkflow.DatabaseTitle = "PageMenuText"

cWorkflow.Comment = Request.QueryString.Item("PageWorkflowComment")
cWorkflow.SystemName = "Page"
cWorkflow.SystemChildID = PageID

If LCase(Request.QueryString.Item("Immediate")) = "true" Then
	AreaID = cWorkflow.Approve("PageAreaID")
	%>
			<%	'UPGRADE_NOTE: Language element '#INCLUDE' was migrated to the same language element but still may have a different behavior. Copy this link in your browser for more: ms-its:C:\Program Files\ASP to ASP.NET Migration Assistant\AspToAspNet.chm::/1011.htm  %>
<%	'UPGRADE_NOTE: The file 'Menu_Restart.asp' was not found in the migration directory. Copy this link in your browser for more: ms-its:C:\Program Files\ASP to ASP.NET Migration Assistant\AspToAspNet.chm::/1003.htm  %>
<!-- #INCLUDE FILE="Menu_Restart.asp" -->

<%	
Else
	AreaID = cWorkflow.ApproveStep("PageAreaID")
End If

' If paragraphs is approved with the page
If DWWorkflow_ApproveParagraph = False Then
	
	cnDynamic = GetConn(CInt("dynamic.mdb"))
	
	' Approve all previous versions of paragraph
	ParagraphSql = "SELECT ParagraphWorkflowState, ParagraphWorkflowID FROM Paragraph WHERE ParagraphWorkflowState <> 0 AND ParagraphWorkflowID <> 0 AND ParagraphPageID=" & PageID
	rsParagraph = New ADODB.Recordset
	rsParagraph.Open(ParagraphSql, cnDynamic, 3, 3)
	
	Do While Not rsParagraph.EOF
		rsParagraph.Fields("ParagraphWorkflowState").Value = cWorkflow.GetWorkflowState()
		rsParagraph.Fields("ParagraphWorkflowID").Value = WorkflowID
		rsParagraph.Update()
		
		rsParagraph.MoveNext()
	Loop 
	
	rsParagraph.Close()
	'UPGRADE_NOTE: Object rsParagraph may not be destroyed until it is garbage collected. Copy this link in your browser for more: 'ms-help://MS.VSCC.2003/commoner/redir/redirect.htm?keyword="vbup1029"'
	rsParagraph = Nothing
	PageVersionParentID = 0
	OriginalPage = cnDynamic.Execute("SELECT PageID, PageVersionParentID, PageVersionNumber FROM Page WHERE PageID=" & PageID)
	If Not OriginalPage.EOF Then
		PageVersionParentID = ChkNumber(OriginalPage("PageVersionParentID"))
		PageVersionNumber = ChkNumber(OriginalPage("PageVersionNumber"))
	End If
	'UPGRADE_NOTE: Object OriginalPage may not be destroyed until it is garbage collected. Copy this link in your browser for more: 'ms-help://MS.VSCC.2003/commoner/redir/redirect.htm?keyword="vbup1029"'
	OriginalPage = Nothing
	
	PageVersionSQL = "SELECT PageWorkflowID, PageWorkflowState FROM Page WHERE PageVersionNumber <= " & PageVersionNumber & " AND PageWorkflowID <> 0 AND PageWorkflowState <> 0 AND PageVersionParentID = " & PageVersionParentID
	rsPageVersion = New ADODB.Recordset
	rsPageVersion.Open(PageVersionSQL, cnDynamic, 3, 3)
	
	Do While Not rsPageVersion.EOF
		rsPageVersion.Fields("PageWorkflowState").Value = cWorkflow.GetWorkflowState()
		rsPageVersion.Fields("PageWorkflowID").Value = WorkflowID
		rsPageVersion.Update()
		
		rsPageVersion.MoveNext()
	Loop 
	
	rsPageVersion.Close()
	'UPGRADE_NOTE: Object rsPageVersion may not be destroyed until it is garbage collected. Copy this link in your browser for more: 'ms-help://MS.VSCC.2003/commoner/redir/redirect.htm?keyword="vbup1029"'
	rsPageVersion = Nothing
	'UPGRADE_NOTE: Object cnDynamic may not be destroyed until it is garbage collected. Copy this link in your browser for more: 'ms-help://MS.VSCC.2003/commoner/redir/redirect.htm?keyword="vbup1029"'
	cnDynamic = Nothing
End If

'UPGRADE_NOTE: Object cWorkflow may not be destroyed until it is garbage collected. Copy this link in your browser for more: 'ms-help://MS.VSCC.2003/commoner/redir/redirect.htm?keyword="vbup1029"'
cWorkflow = Nothing
%>
<SCRIPT language="JavaScript">
	//parent.right.location = "Page_Edit.asp?ID=<%=PageID%>";
	parent.right.location = "MyPage/default.asp?vtab=vtab3";
	top.left.location = "menu.asp?ID=<%=ParentID%>&AreaID=<%=AreaID%>";
</SCRIPT>
