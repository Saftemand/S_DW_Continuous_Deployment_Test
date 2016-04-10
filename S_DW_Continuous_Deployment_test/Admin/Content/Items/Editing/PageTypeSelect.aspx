<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PageTypeSelect.aspx.vb" Inherits="Dynamicweb.Admin.PageTypeSelect" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Import Namespace="Dynamicweb" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
    <head runat="server">
        <dw:ControlResources CombineOutput="false" IncludePrototype="true" runat="server">
            <Items>
                <dw:GenericResource Url="/Admin/Content/Items/js/Default.js" />
                <dw:GenericResource Url="/Admin/Content/Items/js/PageTypeSelect.js" />
                <dw:GenericResource Url="/Admin/Content/Items/css/Default.css" />
                <dw:GenericResource Url="/Admin/Content/Items/css/PageTypeSelect.css" />
            </Items>
        </dw:ControlResources>
    </head>
    <body>
        <dw:Overlay ID="ribbonOverlay" runat="server" Message="" ShowWaitAnimation="True" />

        <h1 class="title"><dw:TranslateLabel ID="TranslateLabel3" runat="server" Text="New page" /></h1>
	    <h2 class="subtitle"><dw:TranslateLabel ID="TranslateLabel4" runat="server" Text="Choose page type" /></h2>

        <div id="myContent">
            <table id="tabBlankPage" class="new-page-container" runat="server">
				<tr class="newPage">
					<td style="width: 300px" onclick="Dynamicweb.Items.PageTypeSelect.get_current().newPage(0);" onmouseover="Dynamicweb.Items.PageTypeSelect.get_current().onRowOver(this);" onmouseout="Dynamicweb.Items.PageTypeSelect.get_current().onRowOut(this);">
						<div class="hover">
							<table>
								<tr>
									<td valign="top">
										<img src="/Admin/Images/Ribbon/Icons/Document_plain_new.png" alt="" /></td>
									<td valign="top">
										<h1><a href="#" id="TemplateName0"><dw:TranslateLabel runat="server" Text="Blank page" /></a></h1>
										<h2><dw:TranslateLabel ID="TranslateLabel6" runat="server" Text="Choose this to create a new blank page" /></h2>
									</td>
								</tr>
							</table>
						</div>
					</td>
                    <td></td>
				</tr>
				<tr class="newPage blank-page-separator">
					<td colspan="2"><div></div></td>
				</tr>
            </table>

            <div class="columns">
                <div id="colPageTemplates" class="column" runat="server">
	                <asp:Repeater ID="TemplatesRepeater" runat="server" EnableViewState="false">
		                <HeaderTemplate>
			                <table width="100%">
                                <tr class="column-header">
                                    <td>
                                        <h3><dw:TranslateLabel ID="lbPageTemplates" Text="Page templates" runat="server" /></h3>
                                    </td>
                                </tr>
		                </HeaderTemplate>

		                <ItemTemplate>
			                <tr onmouseover="Dynamicweb.Items.PageTypeSelect.get_current().onRowOver(this);" onmouseout="Dynamicweb.Items.PageTypeSelect.get_current().onRowOut(this);" 
                                onclick="Dynamicweb.Items.PageTypeSelect.get_current().onPageTypeClick(<%#Eval("ID")%>);">

				                <td>
					                <div class="hover">
						                <table>
							                <tr>
								                <td valign="top">
									                <img src="/Admin/Images/Ribbon/Icons/Paragraph.png" alt="" /></td>
								                <td valign="top">
									                <h1><a href="#" id="BasedOn_<%#Eval("ID")%>"><%#Eval("Menutext")%></a></h1>
									                <h2><%#Dynamicweb.Base.IIf(Base.ChkString(Eval("TemplateDescription")).Length > 0, Eval("TemplateDescription"), "")%></h2>
                                                </td>
							                </tr>
						                </table>
					                </div>
				                </td>
			                </tr>
		                </ItemTemplate>
		                <FooterTemplate>
			                </table>
		                </FooterTemplate>
	                </asp:Repeater>
                </div>
                <div id="colItemTypes" class="column column-types" runat="server">
                    <asp:Repeater ID="ItemTypeRepeater" runat="server" EnableViewState="false">
		                <HeaderTemplate>
			                <table width="100%">
                                <tr class="column-header">
                                    <td>
                                        <h3><dw:TranslateLabel ID="lbItemTypes" Text="Item types" runat="server" /></h3>
                                    </td>
                                </tr>
		                </HeaderTemplate>

		                <ItemTemplate>
			                <tr onmouseover="Dynamicweb.Items.PageTypeSelect.get_current().onRowOver(this);" onmouseout="Dynamicweb.Items.PageTypeSelect.get_current().onRowOut(this);" 
                                onclick="return Dynamicweb.Items.PageTypeSelect.get_current().onPageTypeClick('<%#Eval("SystemName")%>');">

				                <td>
					                <div class="hover">
						                <table>
							                <tr>
								                <td valign="top" class="item-icon">
									                <img src="<%#Dynamicweb.Base.IIf(Base.ChkString(Eval("LargeIcon")).Length > 0, Eval("LargeIcon"), "/Admin/Images/Ribbon/Icons/cube_blue.png")%>" alt="" /></td>
								                <td valign="top">
									                <h1><a href="#" id="BasedOn_<%#Eval("SystemName")%>"><%#Eval("Name")%></a></h1>
									                <h2><%#Dynamicweb.Base.IIf(Base.ChkString(Eval("Description")).Length > 0, Eval("Description"), "")%></h2>
                                                </td>
							                </tr>
						                </table>
					                </div>
				                </td>
			                </tr>
		                </ItemTemplate>
		                <FooterTemplate>
			                </table>
		                </FooterTemplate>
	                </asp:Repeater>
                </div>

                <div class="clearfix"></div>
	        </div>
            
            <div class="centered-wrapper" id="MessageBlock" Visible="False" runat="server">
                <div class="centered">
                    <span class="label"><dw:TranslateLabel Text="No content is available." runat="server"/></span>
                </div>
            </div>
	
	        <div id="BottomInformationBg">
	            <table border="0" cellpadding="0" cellspacing="0">
		            <tr>
			            <td id="colTemplatesImage" runat="server"><img src="/Admin/Images/Ribbon/Icons/small/paragraph.png" alt="" /></td>
			            <td id="colTemplatesNumbers" runat="server">
                            <ul class="stats stats-first">
                                <li>
                                    <span class="label"><dw:TranslateLabel runat="server" Text="Skabeloner" />:</span> 
                                    <span id="TemplateCount" runat="server"></span>
                                </li>
                            </ul>
                        </td>
                        <td id="colItemTypesImage" runat="server"><img src="/Admin/Images/Ribbon/Icons/small/cube_blue.png" alt="" /></td>
                        <td id="colItemTypesNumbers" runat="server">
                            <ul class="stats">
                                <li>
                                    <span class="label"><dw:TranslateLabel ID="TranslateLabel2" runat="server" Text="Item types" />:</span> 
                                    <span id="ItemTypeCount" runat="server"></span>
                                </li>
                            </ul>
                        </td>
		            </tr>
		            <tr>
			            <td>&nbsp;</td>
		            </tr>
	            </table>
	        </div>
        </div>

        <dw:Dialog ID="NewPageDialog" runat="server" Title="Ny side" ShowOkButton="true" ShowCancelButton="true" ShowClose="false" OkAction="Dynamicweb.Items.PageTypeSelect.get_current().newPageSubmit(); ">
		    <table border="0" style="width:350px;">
			    <tr>
				    <td style="width:100px;"><dw:TranslateLabel ID="TranslateLabel1" runat="server" Text="Sidenavn" /></td>
				    <td><input type="text" runat="server" id="PageName" name="PageName" class="NewUIinput" maxlength="255" />
				    </td>
			    </tr>
			    <tr><td style="height:3px;"></td></tr>
			    <tr id="rowBasedOn">
				    <td><dw:TranslateLabel runat="server" Text="Based on" /></td>
				    <td><span id="ChosenTemplateName"></span></td>
			    </tr>
		    </table>
		    <br />
		    <br />
	    </dw:Dialog>

        <script type="text/javascript">
            Dynamicweb.Items.PageTypeSelect.get_current().set_parentPageId(<%=Base.ChkInteger(Base.Request("ParentPageID")) %>);
            Dynamicweb.Items.PageTypeSelect.get_current().set_areaId(<%=Base.ChkInteger(Base.Request("AreaID"))%>);
            Dynamicweb.Items.PageTypeSelect.get_current().get_terminology()['SpecifyPageName'] = '<%=Translate.JsTranslate("Der skal angives en værdi i: %%", "%%", Translate.JsTranslate("Navn"))%>';
            Dynamicweb.Items.PageTypeSelect.get_current().get_terminology()['ItemType'] = '<%=Translate.JsTranslate("item type")%>';
            Dynamicweb.Items.PageTypeSelect.get_current().get_terminology()['Template'] = '<%=Translate.JsTranslate("page template")%>';
            Dynamicweb.Items.PageTypeSelect.get_current().initialize();
        </script>
    </body>

    <%Dynamicweb.Backend.Translate.GetEditOnlineScript()%>
</html>
