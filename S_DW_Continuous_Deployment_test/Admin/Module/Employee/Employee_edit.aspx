<%@ Page Language="vb" AutoEventWireup="false" ValidateRequest="false" Codebehind="Employee_edit.aspx.vb" Inherits="Dynamicweb.Admin.Employee.Employee_edit" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Employee" %>

<%=Gui.MakeModuleHeader("Employee", "Employee Database")%>

<script language="JavaScript">

function OnChange(me)
{
	var show = document.all.TreeShowMode[2].checked;
	var me_checked = me.checked;
	
	if(!show)
	{
		SelectDepts(document.all.deps, false);
		me.checked = me_checked;
		CheckChildren(me);
	}
}

function CheckChildren(me)
{
    if (typeof(me.children) != "undefined" && me.children.length > 0)
    {
        var ids = me.children.split(",");
        var i;
        for (i = 0; i < ids.length; i++)
        {
            var child = document.getElementById("dept" + ids[i]);
            if (child)
            {
                child.checked = true;
                CheckChildren(child);
            }        
        }
    }
}

function ChangeOnlySelected()
{
	var show = document.all.TreeShowMode[2].checked;
	
	if(show)
		document.all.ShowMode[0].checked = show;
	document.all.deps.disabled = false;
	
	return show;
}

function OnPageLoad()
{
	var show = document.all.TreeShowMode[0].checked;
	if(show)
		ChangeShowAll();
}

function ChangeShowAll()
{
	SelectDepts(document.all.deps, false);
	
	if(!ChangeOnlySelected())
	{
		var show = document.all.TreeShowMode[0].checked;
		document.all.deps.disabled = show;
		if (show)
			SelectDepts(document.all.deps, true);
	}
	return true;
}

function SelectDepts(parent, chkd)
{
    var i;
    for (i = 0; i < parent.childNodes.length; i++)
    {
		var node = parent.childNodes[i];
        if (node.tagName == "INPUT")
			node.checked = chkd;
        else
            SelectDepts(node, chkd);
    }
}

function EnableTexts(me)
{
	var txtb = document.getElementById("lb" + me.cn);
	if(me.checked) txtb.disabled = false
	else txtb.disabled = true
}

</script>

<input type="hidden" value="PageSize, PageSort, CompetenceListTemplate, DepartmentListTemplate, ListTemplate, NotFoundTemplate, Employeestemplate, Departmentstemplate, Normalemployees, Normaldepartment, Extendedemployees, Extendeddepartment, Searchfields_template, Searchfields, Searchresultlist, Resultemployees, ShowMode, Generated, NodeTemplate, AlphabetTemplate, CompetenceFilter, TreeShowMode, SelectedDepartments, FrontendAddAction, FrontendEditAction, FrontendDeleteAction, FrontendEditMaster, FrontendEditRow, FrontendEditValidationIncorrect, FrontendEditCompetences, FrontendEditDepartments, FrontendEditValidationUniq, FrontendEditValidationReq, FrontendEditValidationEmail, FrontendEditFeildsString, VCardFeildsString, FrontendFileManagerHomeDir, FrontendEditStatus, EmployeeStatus, EmployeeSortOrder"
	name="Employee_settings">
<table id="Table1" cellSpacing="0" cellPadding="0" width="598" border="0">
	<tr>
		<td>
			<table id="Table2" cellSpacing="0" cellPadding="0" width="590" border="0">
				<tr>
					<td colSpan="2">
						<%=Gui.GroupBoxStart(Translate.Translate("Visning"))%>
						<table id="Table5" cellSpacing="0" cellPadding="2">
							<tr>
								<TD></TD>
								<TD>
									<%=RadioButton(Translate.translate("Vis") & " " & Translate.translate("medarbejdere"), "ShowMode", "1", ShowMode)%>
									<%=RadioButton(Translate.translate("Vis") & " " & Translate.translate("afdelinger"), "ShowMode", "2", ShowMode)%>
									<%=RadioButton(Translate.translate("Vis") & " " & Translate.translate("begge"), "ShowMode", "3", ShowMode)%>
								</TD>
							</tr>
							<tr>
								<TD></TD>
								<TD><%=Translate.translate("Afdelinger")%>:&nbsp;
									<%=GetShowButton(1, Translate.translate("Vis") & " " & Translate.translate("alle"))%>
									<%=GetShowButton(2, Translate.translate("Vis") & " " & Translate.translate("valgte og undergrupper"))%>
									<%=GetShowButton(3, Translate.translate("Vis kun valgte"))%>
								</TD>
							</tr>
							<tr>
								<TD></TD>
								<TD>
								<fieldset id="deps" style="width: 564px">
								<table cellpadding="2" cellspacing="0" align="left" ID="Table4">
									<tr>
										<td>	
											 <%=SelectedDepartments%>										
										</td>
									</tr>	
									</table>
									</fieldset>																								
								</TD>
							</tr>
							<tr>
								<TD></TD>
								<TD>
									<table cellpadding="2" cellspacing="0" align="left" ID="Table4">
										<tr>
											<td valign="top" width="170"><%=Translate.translate("Filter")%></td>
											<td>	
												<%=StatusSelector%>										
											</td>
										</tr>	
									</table>
								</TD>
							</tr>
							<tr>
							    <td />
								<TD>
									<table cellpadding="2" cellspacing="0" align="left" ID="Table7">
										<tr>
								            <td valign="top" width="170">
								                <dw:TranslateLabel runat="server" Text="Employee sort order" />
								            </td>
								            <td>	
            									<%=RadioButton("Module defined", "EmployeeSortOrder", cint(Consts.FrontendSortOrder.ModuleDefined), EmployeeSortOrder, True)%>
            									<%=RadioButton("By name", "EmployeeSortOrder", cint(Consts.FrontendSortOrder.ByName), EmployeeSortOrder, True)%>
            									<%=RadioButton("Make users first", "EmployeeSortOrder", cint(Consts.FrontendSortOrder.UserFirst), EmployeeSortOrder, True)%>
								            </td>
										</tr>	
									</table>
								</TD>
							</tr>
						</table>
						<%=Gui.GroupBoxEnd()%>
						<%=Gui.GroupBoxStart(translate.translate("Templates"))%>
						<table id="Table3" cellSpacing="0" cellPadding="2">
							<TR>
								<TD></TD>
								<TD vAlign="top" width="170"><%=Translate.translate("Liste") & " " & translate.translate("template")%></TD>
								<TD><%=Gui.FileManager(ListTemplate, "Templates/Employee/Tree", "ListTemplate") %></TD>
							</TR>
							<TR>
								<TD></TD>
								<TD vAlign="top" width="170"><%=Translate.translate("Node") & " " & Translate.translate("template")%></TD>
								<TD><%=Gui.FileManager(NodeTemplate, "Templates/Employee/Tree", "NodeTemplate") %></TD>
							</TR>
							<TR>
								<TD></TD>
								<TD vAlign="top" width="170"><%=Translate.translate("Medarbejder") & " " & Translate.translate("element") & " " & Translate.translate("template")%></TD>
								<TD><%=Gui.FileManager(Employeestemplate, "Templates/Employee/Tree", "Employeestemplate") %></TD>
							</TR>
							<TR>
								<TD></TD>
								<TD vAlign="top" width="170"><%=Translate.translate("Afdeling") & " " & Translate.translate("element") & " " & Translate.translate("template")%></TD>
								<TD><%=Gui.FileManager(Departmentstemplate, "Templates/Employee/Tree", "Departmentstemplate") %></TD>
							</TR>
						</table>
						<%=Gui.GroupBoxEnd()%>
						<%=Gui.GroupBoxStart(Translate.translate("Detalje") & " " & Translate.translate("templates"))%>
						<table id="Table6" cellSpacing="0" cellPadding="2">
							<TR>
								<TD></TD>
								<TD vAlign="top" width="170"><%=Translate.translate("Medarbejder") & " " & Translate.translate("element")%></TD>
								<TD><%=Gui.FileManager(Normalemployees, "Templates/Employee/Presentation", "Normalemployees") %></TD>
							</TR>
							<TR>
								<TD></TD>
								<TD vAlign="top" width="170"><%=Translate.translate("Afdeling") & " " & Translate.translate("element")%></TD>
								<TD><%=Gui.FileManager(Normaldepartment, "Templates/Employee/Presentation", "Normaldepartment") %></TD>
							</TR>
							<TR>
								<TD></TD>
								<TD vAlign="top" width="170"><%=Translate.translate("Udvidet") & " " & Translate.translate("medarbejder") & " " & Translate.translate("element")%></TD>
								<TD><%=Gui.FileManager(Extendedemployees, "Templates/Employee/Presentation", "Extendedemployees") %></TD>
							</TR>
							<TR>
								<TD></TD>
								<TD vAlign="top" width="170"><%=Translate.translate("Udvidet") & " " & Translate.translate("afdeling") & " " & Translate.translate("element")%></TD>
								<TD><%=Gui.FileManager(Extendeddepartment, "Templates/Employee/Presentation", "Extendeddepartment") %></TD>
							</TR>
							<TR>
								<TD></TD>
								<TD vAlign="top" width="170"><%=Translate.translate("Competences") & " " & translate.translate("template")%></TD>
								<TD><%=Gui.FileManager(CompetenceListTemplate, "Templates/Employee/Presentation", "CompetenceListTemplate") %></TD>
							</TR>
							<TR>
								<TD></TD>
								<TD vAlign="top" width="170"><%=Translate.Translate("Afdeling") & " " & Translate.Translate("template")%></TD>
								<TD><%=Gui.FileManager(DepartmentListTemplate, "Templates/Employee/Presentation", "DepartmentListTemplate") %></TD>
							</TR>
						</table>
						<%=Gui.GroupBoxEnd()%>
						<%=Gui.GroupBoxStart(Translate.translate("Søgning"))%>
						<table id="Table6" cellSpacing="0" cellPadding="2">
							<tr>
								<TD></TD>
								<td vAlign="top" width="170"><%=Translate.translate("Enheder pr. side")%></td>
								<TD><INPUT class=std 
                  value="<%=PageSize%>" name="PageSize"></TD>
							</tr>
							<tr>
								<TD></TD>
								<td vAlign="top" width="170"><%=Translate.translate("Sortering")%></td>
								<TD>
								<select class=std name="PageSort">
								<%=sort_fields%>
								</select>
								</TD>
							</tr>
							<TR>
								<TD></TD>
								<TD vAlign="top" width="170"><%=translate.translate("Søg i")%></TD>
								<TD><%=Gui.FileManager(Searchfields_template, "Templates/Employee/Search", "Searchfields_template") %></TD>
							</TR>
							<TR>
								<TD></TD>
								<TD vAlign="top" width="170"><%=translate.translate("Kompetence") & " " & translate.translate("filter")%></TD>
								<TD><%=Gui.FileManager(CompetenceFilter, "Templates/Employee/Search", "CompetenceFilter") %></TD>
							</TR>
							<TR>
								<TD></TD>
								<TD vAlign="top" width="170"><%=translate.translate("Ikke fundet")%></TD>
								<TD><%=Gui.FileManager(NotFoundTemplate, "Templates/Employee/Search", "NotFoundTemplate") %></TD>
							</TR>
							<TR>
								<TD></TD>
								<TD vAlign="top" width="170"><%=translate.translate("Alfabet")%></TD>
								<TD><%=Gui.FileManager(AlphabetTemplate, "Templates/Employee/Search", "AlphabetTemplate") %></TD>
							</TR>
							<TR>
								<TD></TD>
								<TD vAlign="top" width="170"><%=translate.translate("Søgeresultat")%></TD>
								<TD><%=Gui.FileManager(Searchresultlist, "Templates/Employee/Search", "Searchresultlist") %></TD>
							</TR>
							<TR>
								<TD></TD>
								<TD vAlign="top" width="170"><%=Translate.translate("Søgeresultat") & " " & Translate.translate("element")%></TD>
								<TD><%=Gui.FileManager(Resultemployees, "Templates/Employee/Search", "Resultemployees") %></TD>
							</TR>
							<TR>
								<TD></TD>
								<TD width="170"><%=translate.translate("Kompetence") & " " & translate.translate("søgning")%></TD>
								<TD vAlign="top" >
								<%=RadioButton(translate.translate("dropdown"), "Generated", "2", Generated)%>
								<%=RadioButton(translate.translate("multiselect"), "Generated", "3", Generated)%>
								<%=RadioButton(translate.translate("ingen"), "Generated", "1", Generated)%>									
								</TD>
							</TR>
						</table>
						<%=Gui.GroupBoxEnd()%>
						<%=Gui.GroupBoxStart(translate.translate("Søg i"))%>
						<table whidth="100%" cellpadding="2" cellspacing="0" align="center" ID="Table4">
								<%=Boxes%>
							<tr>
								<td colspan="3">&nbsp;</td>
							</tr>
							</table>
						<%=Gui.GroupBoxEnd()%>
						<%=Gui.GroupBoxStart(translate.translate("Frontend_editering"))%>
						<table width="100%" cellpadding="2" cellspacing="0" ID="Table677">
							<tr>
								<td colspan="3">&nbsp;</td>
							</tr>
							<TR>
								<TD></TD>
								<TD vAlign="top" width="170"><%=translate.translate("Tilføj") & " " & translate.translate("medarbejder") & " " & translate.translate("template")%></TD>
								<TD><%=Gui.FileManager(FrontendAddAction, "Templates/Employee/FrontendEdit", "FrontendAddAction") %></TD>
							</TR>
							<TR>
								<TD></TD>
								<TD vAlign="top" width="170"><%=translate.translate("Rediger") & " " & translate.translate("medarbejder") & " " & translate.translate("template")%></TD>
								<TD><%=Gui.FileManager(FrontendEditAction, "Templates/Employee/FrontendEdit", "FrontendEditAction") %></TD>
							</TR>	
							<TR>							 
								<TD></TD>
								<TD vAlign="top" width="170"><%=translate.translate("Slet") & " " & translate.translate("medarbejder") & " " & translate.translate("template")%></TD>
								<TD><%=Gui.FileManager(FrontendDeleteAction, "Templates/Employee/FrontendEdit", "FrontendDeleteAction") %></TD>
							</TR>		  
							<TR>
								<TD></TD>
								<TD vAlign="top" width="170"><%=translate.translate("Rediger") & " " & translate.translate("liste") & " " & translate.translate("template")%></TD>
								<TD><%=Gui.FileManager(FrontendEditMaster, "Templates/Employee/FrontendEdit", "FrontendEditMaster") %></TD>
							</TR>
							<TR>
								<TD></TD>
								<TD vAlign="top" width="170"><%=translate.translate("Rediger") & " " & translate.translate("element") & " " & translate.translate("template")%></TD>
								<TD><%=Gui.FileManager(FrontendEditRow, "Templates/Employee/FrontendEdit", "FrontendEditRow") %></TD>
							</TR>
							<TR>
								<TD></TD>
								<TD vAlign="top" width="170"><%=translate.translate("Rediger") & " " & translate.translate("kompetence") & " " & translate.translate("template")%></TD>
								<TD><%=Gui.FileManager(FrontendEditCompetences, "Templates/Employee/FrontendEdit", "FrontendEditCompetences") %></TD>
							</TR>
							<TR>
								<TD></TD>
								<TD vAlign="top" width="170"><%=Translate.Translate("Rediger") & " " & Translate.Translate("afdeling") & " " & Translate.Translate("template")%></TD>
								<TD><%=Gui.FileManager(FrontendEditDepartments, "Templates/Employee/FrontendEdit", "FrontendEditDepartments")%></TD>
							</TR>
							<TR>
								<TD></TD>
								<TD vAlign="top" width="170"><%=translate.translate("Fejlbesked") & " - " & translate.translate("forkert indtastning")%></TD>
								<TD><%=Gui.FileManager(FrontendEditValidationIncorrect, "Templates/Employee/FrontendEdit", "FrontendEditValidationIncorrect") %></TD>
							</TR>
							<TR>			   
								<TD></TD>
								<TD vAlign="top" width="170"><%=translate.translate("Fejlbesked") & " - " & translate.translate("medarbejder") & " " & translate.translate("eksisterer")%></TD>
								<TD><%=Gui.FileManager(FrontendEditValidationUniq, "Templates/Employee/FrontendEdit", "FrontendEditValidationUniq") %></TD>
							</TR>
							<TR>
								<TD></TD>
								<TD vAlign="top" width="170"><%=translate.translate("Fejlbesked") & " - " & translate.translate("manglende indtastning")%></TD>
								<TD><%=Gui.FileManager(FrontendEditValidationReq, "Templates/Employee/FrontendEdit", "FrontendEditValidationReq") %></TD>
							</TR>
							<TR>
								<TD></TD>
								<TD vAlign="top" width="170"><%=translate.translate("Fejlbesked") & " - " & translate.translate("e_-mail") & " " & translate.translate("warning")%></TD>
								<TD><%=Gui.FileManager(FrontendEditValidationEmail, "Templates/Employee/FrontendEdit", "FrontendEditValidationEmail") %></TD>
							</TR>
							<TR>
								<TD></TD>
								<TD vAlign="top" width="170"><%=translate.translate("Rediger status template")%></TD>
								<TD><%=Gui.FileManager(FrontendEditStatus, "Templates/Employee/FrontendEdit", "FrontendEditStatus") %></TD>
							</TR>
							<TR>
								<TD></TD>
								<TD vAlign="top" width="170"><%=translate.translate("Upload_til")%></TD>
								<TD><%=Gui.FolderManager(FrontendFileManagerHomeDir, "FrontendFileManagerHomeDir") %></TD>
							</TR>
						</table>
						<table>
							<TR>
								<TD></TD>
								<TD vAlign="top" width="170"><%=translate.translate("Standard") & " " & translate.translate("felter")%></TD>
								<TD><fieldset  style="width: 350px"><table width="100%" align="center"><%=LabelBoxes%></table></fieldset></TD>
							</TR>
						</table>
						
						<table>
							<TR>
								<TD></TD>
								<TD vAlign="top" width="170"><%=translate.translate("Insert into VCard")%></TD>
								<TD><fieldset  style="width: 350px"><table width="100%" align="center"><%=VCardBoxes%></table></fieldset></TD>
							</TR>
						</table>

						<table>
							<TR>
								<TD></TD>
								<TD vAlign="top" width="170"><%=translate.translate("Brugerdefinerede") & " " & translate.translate("felter")%></TD>
								<TD><fieldset style="width: 350px"><table width="100%" align="center"><%=CustomBoxes%></table></fieldset></TD>
							</TR>
						</table>
						<%=Gui.GroupBoxEnd()%>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<script language="JavaScript">
   OnPageLoad();
</script>
<%Translate.GetEditOnlineScript()%>