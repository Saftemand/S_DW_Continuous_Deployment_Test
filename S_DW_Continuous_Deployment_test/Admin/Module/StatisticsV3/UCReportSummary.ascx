<%@ Control Language="vb" AutoEventWireup="false" Codebehind="UCReportSummary.ascx.vb" Inherits="Dynamicweb.Admin.StatisticsV3.UCReportSummary" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Admin.StatisticsV3" Assembly="Dynamicweb.Admin" %>
<%=JavaArray%>
<table width="512">
	<TBODY>
		<tr>
			<td vAlign="top" rowSpan="4"><IMG height=36 alt="" 
      src="<%=_hostname%>/Admin/Images/Icons/Statv2_Report_heading.gif" 
      width=32 border=0></td>
		</tr>
		<tr>
			<td width="402"><strong style="COLOR: #003366"><b><span id="lblPreDdlText" runat="server"></span></b>
					<SELECT class="std" id="ddl" style="WIDTH: 155px" onchange="globalReload();" runat="server">
					</SELECT>
					<b><span id="lblPostDdlText" runat="server"></span></b></strong>
			</td>
			<TD style="WIDTH: 75px" align="right"></TD>
		</tr>
		<TR>
			<TD style="WIDTH: 100%; HEIGHT: 1px; BACKGROUND-COLOR: #cccccc" colSpan="2"></TD>
		</TR>
		<TR>
			<TD>&nbsp;</TD>
		</TR>
		<TR>
			<TD></TD>
			<TD colSpan="2">
				<TABLE width="100%" border="0">
					<TBODY>
						<tr >
				            <dw:PagingGridView id="rpt" 
		                        OnPageIndexChanging="rpt_PageIndexChanging" 
                                Runat="server"
 	                            AutoGenerateColumns="false"
	                            AllowPaging="True"
                                Width ="100%" 
                                GridLines=None 
                                CellSpacing="1"
                                CellPadding="1"
                                ShowHeader=true
                                height="12"
                                >
                                 <pagersettings 
                                  Mode=Numeric                                      
                                  position=TopAndBottom              
                                  pagebuttoncount="10" 
                                  />
                                  
                                  <Columns >
                                    <asp:templatefield>
                                     <headertemplate>
						<TR>
							<TD><B><span id="lblColumn1Name" runat="server"></span></B></TD>
							<TD><B><span id="lblColumn2Name" runat="server"></span></B></TD>
							<TD></TD>
							<TD><B><span id="lblColumn3Name" runat="server"></span></B></TD>
							<TD nowrap><B><span id="lblColumn4Name" runat="server"></span></B></TD>
							<TD nowrap><B><span id="lblColumn5Name" runat="server"></span></B></TD>
						</TR>
						<TR>
							<TD style="WIDTH: 100%; HEIGHT: 1px; BACKGROUND-COLOR: #e1e1e1" colSpan="6" height="1"></TD>
						</TR>
                                     </headertemplate>
                                       <itemtemplate  >
									<tr style="height:12px;">
										<td valign="top">
											<nobr><a id="lnkColumn1" runat="server"></a><span id="lblColumn1" runat="server" /></nobr>
										</td>
                                        <td valign="top">
                                            <nobr>
                                                <span id="lblColumn2" runat="server" /> 
                                                <asp:Literal id="ltrDNSstuff" runat="server"></asp:Literal>                                               
                                        </td>
										<td valign="top"><nobr> <img src="<%#_hostname%>/Admin/Statisticsv2/Flags/--.gif" border="0" title="-- (N/A)" id="imgFlagEmpty"
													runat="server"> <span id="lblFlagTitle" runat="server"><img id="imgFlag" runat="server" /></span></nobr></td>
										<td valign="top">
											<span id="lblColumn3" runat="server" />
										</td>
										<td><span id="lblColumn4" runat="server" /></td>
										<td align="center"><a target="_blank" runat="server" id="lnkColumn5"> <img src="<%=_hostname%>/Admin/Images/Icons/Page_ext.gif" border="0"></a></td>
									</tr>
									<tr>
										<td colspan="6" height="1" style="WIDTH:100%;HEIGHT:1px;BACKGROUND-COLOR:#e1e1e1"></td>
									</tr>
                                    </itemtemplate>
                                  </asp:templatefield>
                                </Columns>   
		                </dw:PagingGridView>
                        </tr>
					</TBODY>
				</TABLE>
			</TD>
		</TR>
	</TBODY>
</table>
