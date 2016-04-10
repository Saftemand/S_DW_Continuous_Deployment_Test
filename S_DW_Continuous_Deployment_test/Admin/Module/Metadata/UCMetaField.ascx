<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="Dynamicweb.Admin.Metadata" %>
<%@ Control Language="vb" AutoEventWireup="false" Codebehind="UCMetaField.ascx.vb" Inherits="Dynamicweb.Admin.Metadata.UCMetaField" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<table cellSpacing="0" cellPadding="0" border="0">
	<tr>
		<%Dim _widTab As string = "170"%>
		<%if _fieldType = ConstsLocal.FieldType.FillIn then _widTab = "560"%>
		<td width="<%=_widTab%>" valign="top">
		    <%If _isDefaultField then %>
			    <%=Translate.Translate(HttpContext.Current.Server.HtmlEncode(_fieldName))%>
			<%Else %>
			    <%=HttpContext.Current.Server.HtmlEncode(_fieldName)%>
			<%End If %>
		</td>
		<td align="left">
			<%if _fieldType <> ConstsLocal.FieldType.MultiDropdown then%>
				<span id="validator_<%=_fieldID%>" style="display:none; color:red;"><%=Translate.Translate("Obligatorisk")%></span>
			<%end if%>
			<table cellpadding="0" cellspacing="0" border="0">
				<%if _fieldType = ConstsLocal.FieldType.Text%>
				<tr>
					<td>
						<textarea id="txb_<%=_fieldID%>" name="txb_<%=_fieldID%>" cols="30" rows="3" wrap="on" style="WIDTH: 350px; HEIGHT: 80px"
											class="std"><%=_textValue%></textarea>
					</td>
				</tr>
				<%elseif _fieldType = ConstsLocal.FieldType.FillIn then%>
				<tr>
					<td></td>
				</tr>
				<%elseif _fieldType = ConstsLocal.FieldType.Dropdown then%>
				<tr>
					<td>
						<SELECT id="sel_<%=_fieldID%>" name="sel_<%=_fieldID%>" class="std" style="WIDTH: 350px">
							<%=_options%>
						</SELECT>
					</td>
				</tr>
				<%end if%>
			</table>
		</td>
	</tr>
	<tr>
		<td colspan="2" width="580" align="center">
			<%if _fieldType = ConstsLocal.FieldType.MultiDropdown then%>
			<span id="validator_<%=_fieldID%>" style="display:none; color:red;"><%=Translate.Translate("Obligatorisk")%></span>
			<table cellSpacing="0" cellPadding="2">
				<TBODY>
					<tr>
						<td><%=Translate.Translate("Hovedkategorier")%></td>
						<td>&nbsp;</td>
						<td><%=Translate.Translate("Indtast nyt")%></td>
					</tr>
					<tr>
						<td>
							<SELECT id="c<%=_fieldID%>" name="c<%=_fieldID%>" class="std" onchange="ChangeCategory(this)">
								<%=_options%>
							</SELECT>
						</td>
						<td>&nbsp;</td>
						<td>
							<INPUT type="text" id="txt_<%=_fieldID%>" name="txt_<%=_fieldID%>" class="std">
						</td>
					</tr>
					<tr>
						<td><%=Translate.translate("Valgmuligheder")%></td>
						<td>&nbsp;</td>
						<td>
							<table cellSpacing="0" cellPadding="0" border="0" width="100%">
								<tr>
									<td align="left"><%=Translate.translate("Valgte")%></td>
									<td align="right">
										<img id="imgDown" style="CURSOR: pointer" onclick="MultiAdd(<%=_fieldID%>,MultiSelectGetControl('txt_<%=_fieldID%>'),MultiSelectGetSelectedControl(<%=_fieldID%>))"src="/Admin/images/Page_Next_rot90.gif" >
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td rowSpan="2">
							<div id="div_all_<%=_fieldID%>">
								<SELECT size="8" id="all_<%=_fieldID%>" name="all_<%=_fieldID%>" Class="std"
									 ondblclick="MultiSelectMove(<%=_fieldID%>,MultiSelectGetAllControl(<%=_fieldID%>),MultiSelectGetSelectedControl(<%=_fieldID%>))">
									<%=_optionsAll%>
								</SELECT>
							</div>
						</td>
						<td vAlign="bottom" width="30" align="center">
							<img id="imgRight" style="CURSOR: pointer" onclick="MultiSelectMove(<%=_fieldID%>,MultiSelectGetAllControl(<%=_fieldID%>),MultiSelectGetSelectedControl(<%=_fieldID%>))"
							 src="/Admin/images/Page_Next.gif" >
						</td>
						<td rowSpan="2">
							<div id="div_sel_<%=_fieldID%>">
								<SELECT size="8" id="selected_<%=_fieldID%>" name="selected_<%=_fieldID%>" Class="std"
									ondblclick="MultiSelectMove(<%=_fieldID%>,MultiSelectGetSelectedControl(<%=_fieldID%>), MultiSelectGetAllControl(<%=_fieldID%>))">
									<%=_optionsSelected%>
								</SELECT>
							</div>
						</td>
					</tr>
					<tr>
						<td vAlign="top" width="30" align="center">
							<img id="imgLeft" style="CURSOR: pointer" onclick="MultiSelectMove(<%=_fieldID%>,MultiSelectGetSelectedControl(<%=_fieldID%>), MultiSelectGetAllControl(<%=_fieldID%>))"
								src="/Admin/images/Page_Previous.gif" >
						</td>
					</tr>
				</TBODY>
			</table>
			<input type="hidden" id="MultiSelectIDs_<%=_fieldID%>" name="MultiSelectIDs_<%=_fieldID%>" value="<%=_multiSelectIDs%>">
			<input type="hidden" id="MultiCustom_<%=_fieldID%>" name="MultiCustom_<%=_fieldID%>" value="<%=_multiCustom%>">
			<%end if%>
		</td>
	</tr>
</table>
<script language="javascript">
	<%=_addValidatorJS%>
</script>

