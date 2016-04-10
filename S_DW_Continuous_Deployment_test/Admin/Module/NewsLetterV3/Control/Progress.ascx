<%@ Control Language="vb" AutoEventWireup="false" Codebehind="Progress.ascx.vb" Inherits="Dynamicweb.Admin.NewsLetterV3.UCProgress" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Import Namespace="Dynamicweb.NewsLetterV3" %>

<script language="javascript" type="text/javascript">

	function CallProgress()
	{ 
	    document.getElementById("iframeRefreshProgress").src='<%=RefreshPage%>?DelayTime=<%=DelayTime%>&IsRedirect=<%=IsRedirectAfterJobFinished%>&JobName=<%=JobName%>';
	}
	
	function SetStatus(value)
	{
		document.getElementById("<%=Me.ID%>_lblStatus").innerHTML = value;
	}
	
	function SetTotal(value)
	{
		document.getElementById("<%=Me.ID%>_lblTotal").innerHTML = value;
	}
	
	function SetExecuted(value)
	{
		document.getElementById("<%=Me.ID%>_lblExecuted").innerHTML = value;
	}
	
    function SetErrors(value)
	{
		document.getElementById("<%=Me.ID%>_lblErrors").innerHTML = value;
	}
	
	function SetElapsed(value)
	{
		document.getElementById("<%=Me.ID%>_lblElapsed").innerHTML = value;
	}
	
	function SetComplete(status,IsRedirect)
	{
	    if(IsRedirect==1)
	    {
	        window.location.href="<%=RedirectPage%>";
	    }
	    else
	    {
	        document.getElementById("<%=Me.ID%>_lblStatus").innerHTML=status
		    document.getElementById("trProgressArea").style.display = "none";
		    document.getElementById("trViewLogButtons").style.display = "block";
		}
	}
		
	function SetProgressBar(num)
	{
		var perc = 300/100 * num;
		document.getElementById("lblPercentComplete").style.width = num +'%';
		document.getElementById("lblPercentText").innerHTML = num + "%";
	}	
	
	function ViewLog(mode)
	{
		document.getElementById("trProgressArea").style.display = "none";										
		document.getElementById("trViewLogButtons").style.display = "block";
		if(mode == true)
		{
			document.getElementById("trViewLog").style.display = "";	
		}
		if(mode == false)
		{
			document.getElementById("trViewLog").style.display = "none";	
		}
	}
    
</script>

<dw:TabHeader ID="dwTabHeader" runat="server" />
<table class="tabTable" id="Table1" cellpadding="0" width="100%">
    <tr>
        <td valign="top">
            <dw:GroupBoxStart ID="dwGroupBoxStartSummary" Title="Summary" runat="server" doTranslation="true" />
            <table id="Table2" cellspacing="3" cellpadding="3" border="0">
                <tr>
                    <td>
                        <asp:Label ID="lblStatusText" runat="server" />&nbsp;</td>
                    <td>
                        <asp:Label ID="lblStatus" runat="server" /></td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblTotalText" runat="server" />&nbsp;</td>
                    <td>
                        <asp:Label ID="lblTotal" runat="server" Text="0"></asp:Label></td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblExecutedText" runat="server" />&nbsp;</td>
                    <td>
                        <asp:Label ID="lblExecuted" runat="server" Text="0"></asp:Label></td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblErrorsText" runat="server" />&nbsp;</td>
                    <td>
                        <asp:Label ID="lblErrors" runat="server" Text="0"></asp:Label></td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblElapsedText" runat="server" />&nbsp;</td>
                    <td>
                        <asp:Label ID="lblElapsed" runat="server" Text="00:00" /></td>
                </tr>
            </table>
            <dw:GroupBoxEnd ID="Groupboxend1" runat="server" />
        </td>
    </tr>
    <tr id="trProgressArea">
        <td valign="top">
            <dw:GroupBoxStart ID="dwGroupBoxStartProgress" Title="Progress" runat="server" doTranslation="true" />
            <table id="Table3" cellspacing="2" cellpadding="2" width="100%" border="0">
                <tr>
                    <td style="width: 75px;">
                    </td>
                    <td style="width: 300px">
                        <span id="filename"></span>
                    </td>
                </tr>
                <tr valign="middle">
                    <td>
                    </td>
                    <td valign="top">
                        <fieldset style="padding: 0; margin: 0;">
                            <table id="progress" width="100%" border="0">
                                <tr>
                                    <td>
                                        <div id="lblPercentComplete" style="height: 10px; width: 0px; background-color: #dcdcdc;">
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </fieldset>
                    </td>
                    <td valign="middle">
                        <span id="lblPercentText" style="height: 15px"></span>
                    </td>
                    <td align="right">
                        <asp:Button ID="btnAbort" runat="server" CssClass="buttonSubmit"></asp:Button></td>
                </tr>
            </table>
            <dw:GroupBoxEnd ID="Groupboxend2" runat="server" />
        </td>
    </tr>
    <tr id="trViewLog" style="display: none">
        <td valign="top">
            <dw:GroupBoxStart ID="dwGroupboxStartViewLog" Title="Log" runat="server" doTranslation="true" />
            <table id="Table4" width="100%" border="0">
                <tr>
                    <td>
                        <pre><asp:Label ID="lblViewLog" runat="Server" /></pre>
                    </td>
                </tr>
            </table>
            <dw:GroupBoxEnd ID="GroupBoxEnd3" runat="server" />
        </td>
    </tr>
    <tr id="trViewLogButtons" style="display: none;">
        <td class="buttonsRow" align="right">
            <table border="0" cellpadding="2" cellspacing="0">
                <tr>
                    <td>
                        <asp:Button ID="btnViewLog" runat="server" CssClass="buttonSubmit" />
                        <asp:Button ID="canc" runat="server" CssClass="buttonSubmit" />
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<iframe id="iframeRefreshProgress" frameborder="0" scrolling="no" height="0" width="0">
</iframe>
