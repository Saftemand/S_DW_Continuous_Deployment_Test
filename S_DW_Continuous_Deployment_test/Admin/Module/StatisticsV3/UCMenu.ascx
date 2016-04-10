<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Control Language="vb" AutoEventWireup="false" Codebehind="UCMenu.ascx.vb" Inherits="Dynamicweb.Admin.StatisticsV3.UCMenu" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<script type="text/javascript" src="UCMenu.js"></script>
<table cellspacing="0" cellpadding="0" border="0" height="50" width="100%">
	<tbody>
		<tr width="100%" height="100%">
			<td>
				<table cellspacing="0" cellpadding="2" border="0" height="100%" width="100%">
					<tr>
						<td width="20" rowspan="3">&nbsp;</td>
						<td nowrap><%=Translate.Translate("Fra dato")%></td>
						<td width="5" rowspan="3">&nbsp;</td>
						<td nowrap><%=objDate.DateSelect(MinDate, False, False, False, "Statv2From")%></td>						
						<td width="100%" rowspan="3">&nbsp;</td>
						<td nowrap><span id="labelLanguage"><%=Translate.Translate("Sprog",9)%>&nbsp;</span></td>
						<td width="5" rowspan="3">&nbsp;</td>
						<td>
							<select id="Statv2Area" name="Statv2Area" class="std" style="WIDTH: 184px">
								<%=FillOptionsArea()%>
							</select>
						</td>
						<td width="20" rowspan="3">&nbsp;</td>
					</tr>
					<tr>
						<td nowrap><%=Translate.Translate("Til dato")%></td>
						<td align=left><%=objDate.DateSelect(Dates.DWNow, False, False, False, "Statv2To")%></td>
						<%If Base.HasVersion("18.10.1.0") Then%>
						<td nowrap><span id="labelIPAddress"><%=Translate.Translate("IP adresse")%></span></td>
						<td><input onkeypress="checkEnterKey();" name="Statv2IpSearch" id="Statv2IpSearch" style="WIDTH:181px"
								class="std"></td>
						<%Else%>
						<td colspan="2"></td>
						<%End If%>
					</tr>
					<%If Base.HasVersion("18.10.1.0") Then%>
					<tr id="trApplyStatSetting">
						<td colspan="9" align="right"><%=Gui.Button(Translate.Translate("Anvend"), "ApplyStatSetting()", 0)%></td>
					</tr>
					<tr id="trApplyTriggerFilter">
						<td colspan="9" align="right"><%=Gui.Button(Translate.Translate("Anvend"), "ApplyTriggerFilter()", 0)%></td>
					</tr>
					<%End If%>
				</table>
			</td>
		</tr>
	</tbody>
</table>
<script language="javascript">changeFilter();</script>
