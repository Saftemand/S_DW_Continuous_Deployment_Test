<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="SurveyInstruction.ascx.vb" Inherits="Dynamicweb.Admin.Survey.SurveyInstruction" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
<script language="javascript">
  function ValidateLinkManager(source, arguments)
  {
    var linkManager = document.getElementById("LinkManager");
    if (linkManager != null)
    {
        if (linkManager.value == "")
        {
            arguments.IsValid=false;
        }
        else
        {    
            arguments.IsValid=true;
        }
     }   
   }
      
</script>
<dw:GroupBoxStart runat="server" ID="GroupBoxInstructionStart" doTranslation="true" Title="Instruction" ToolTip="Instruction" />
<table cellspacing="0" cellpadding="1" border="0" width="100%" >
<tr>
    <td width="150" valign="top">&nbsp;<dw:translatelabel id="TypeInstruction" runat="server" Text="Type"></dw:translatelabel></td>
    <td width="430"> 
        <asp:RadioButtonList RepeatLayout="Table" ID="ChooseInstruction" runat="server" RepeatDirection="Vertical" AutoPostBack="True" OnSelectedIndexChanged="CheckInstruction" />
    </td>
    <td>&nbsp;</td>
</tr>
<tr id="LinkManagerRow" runat="server" visible="false">
	<td width="150">&nbsp;<dw:translatelabel id="instr" runat="server" Text="Side med instruktion"></dw:translatelabel></td>
	<td><dw:LinkManager ID="LinkManager" runat="server" visible="false" />
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<asp:CustomValidator id="LinkManagerRequire" ClientValidationFunction="ValidateLinkManager" 
       runat="server" ErrorMessage="- required field"></asp:CustomValidator></td>
	<td>&nbsp;</td>
</tr>
<tr>
<td colspan="2"><asp:CustomValidator id="FileManagerRequire" OnServerValidate="ValidateFileManager" 
       runat="server" ErrorMessage="- required field"></asp:CustomValidator>&nbsp;</td>
<td>&nbsp;</td>
</tr>
<tr id="HtmlEditorRow" runat="server" visible="false"> 
    <td valign="top" colspan="2">
        <dw:GroupBoxStart runat="server" ID="HTMLStart" doTranslation="true" Title="HTML" ToolTip="HTML" />      
        <dw:Editor ID="Editor" runat="server" visible="false" Width="560" Height="250"/>  
        <dw:GroupBoxEnd runat="server" ID="HTMLEnd" />
    </td>
    <td>&nbsp;</td>
</tr>
</table>
<dw:GroupBoxEnd runat="server" ID="GroupBoxInstructionEnd" />