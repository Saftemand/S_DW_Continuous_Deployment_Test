<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Admin/Module/OMC/EntryContent.Master" CodeBehind="EmailTypeSelect.aspx.vb" Inherits="Dynamicweb.Admin.OMC.Emails.EmailTypeSelect" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Import Namespace="Dynamicweb" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <dw:Overlay ID="ribbonOverlay" runat="server" Message="" ShowWaitAnimation="True" />

	<h2 class="subtitle"><dw:TranslateLabel ID="TranslateLabel4" runat="server" Text="Choose email type" /></h2>

    <div id="myContent">
        <table id="tabBlankPage" class="new-page-container" runat="server">
			<tr class="newPage">
				<td style="width: 300px" onclick="EmailTypeSelect.newBlankEmail();" onmouseover="EmailTypeSelect.onRowOver(this);" onmouseout="EmailTypeSelect.onRowOut(this);">
					<div class="hover">
						<table>
							<tr>
								<td valign="top">
									<img src="/Admin/Images/Ribbon/Icons/Document_plain_new.png" alt="" /></td>
								<td valign="top">
									<h1><a href="#" id="TemplateName0"><dw:TranslateLabel ID="TranslateLabel1" runat="server" Text="Blank e-mail" /></a></h1>
									<h2><dw:TranslateLabel ID="TranslateLabel6" runat="server" Text="Choose this to create a new blank e-mail and select an already created page to send" /></h2>
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
                                    <h3><dw:TranslateLabel ID="lbPageTemplates" Text="E-mail templates" runat="server" /></h3>
                                </td>
                            </tr>
		            </HeaderTemplate>

		            <ItemTemplate>
			            <tr onmouseover="EmailTypeSelect.onRowOver(this);" onmouseout="EmailTypeSelect.onRowOut(this);" 
                            onclick="EmailTypeSelect.newTemplateBasedEmail(<%#Eval("Id")%>, '<%#Eval("Subject")%>');">

				            <td>
					            <div class="hover">
						            <table>
							            <tr>
								            <td valign="top">
									            <img src="/Admin/Images/Icons/Module_NewsletterExtended.gif" alt="" /></td>
								            <td valign="top">
									            <h1><a href="#" id='<%#Eval("Id")%>'><%#Eval("TemplateName")%></a></h1>
                                                <small><strong>Subject</strong>: <%#Eval("Subject")%></small><br />
									            <h2><%#Dynamicweb.Base.IIf(Base.ChkString(Eval("TemplateDescription")).Length > 0, Eval("TemplateDescription"), String.Format("({0})", Dynamicweb.Backend.Translate.Translate("No description").ToLowerInvariant()))%></h2>
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
            <%--
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
			            <tr onmouseover="EmailTypeSelect.onRowOver(this);" onmouseout="EmailTypeSelect.onRowOut(this);" 
                            onclick="alert('Not implemented yet: Items <%#Eval("SystemName")%>');">

				            <td>
					            <div class="hover">
						            <table>
							            <tr>
								            <td valign="top">
									            <img src="<%#Dynamicweb.Base.IIf(Base.ChkString(Eval("LargeIcon")).Length > 0, Eval("LargeIcon"), "/Admin/Images/Ribbon/Icons/document_ok.png")%>" alt="" /></td>
								            <td valign="top">
									            <h1><a href="#" id='BasedOn_<%#Eval("SystemName")%>'><%#Eval("Name")%></a></h1>
									            <h2><%#Dynamicweb.Base.IIf(Base.ChkString(Eval("Description")).Length > 0, Eval("Description"), String.Format("({0})", Dynamicweb.Backend.Translate.Translate("No description").ToLowerInvariant()))%></h2>
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
            --%>

            <div class="clearfix"></div>
	    </div>
	
	    <div id="BottomInformationBg">
	        <table border="0" cellpadding="0" cellspacing="0">
		        <tr>
			        <td id="colTemplatesImage" runat="server"><img src="/Admin/Images/Ribbon/Icons/small/paragraph.png" alt="" /></td>
			        <td id="colTemplatesNumbers" runat="server">
                        <ul class="stats stats-first">
                            <li>
                                <span class="label"><dw:TranslateLabel ID="TranslateLabel2" runat="server" Text="Skabeloner" />:</span> 
                                <span id="TemplateCount" runat="server"></span>
                            </li>
                        </ul>
                    </td>
                    <%--
                    <td id="colItemTypesImage" runat="server"><img src="/Admin/Images/Ribbon/Icons/small/document_ok.png" alt="" /></td>
                    <td id="colItemTypesNumbers" runat="server">
                        <ul class="stats">
                            <li>
                                <span class="label"><dw:TranslateLabel ID="TranslateLabel3" runat="server" Text="Item types" />:</span> 
                                <span id="ItemTypeCount" runat="server"></span>
                            </li>
                        </ul>
                    </td>
                    --%>
		        </tr>
		        <tr>
			        <td>&nbsp;</td>
		        </tr>
	        </table>
	    </div>
    </div>

    <dw:Dialog ID="NewEmailDialog" runat="server" Title="New e-mail" ShowOkButton="true" ShowCancelButton="true" ShowClose="false" OkAction="EmailTypeSelect.newEmailOk();">
		<table border="0" style="width:350px;">
			<tr>
				<td style="width:100px;"><dw:TranslateLabel runat="server" Text="Subject" /></td>
				<td><input type="text" id="subject" name="subject" class="NewUIinput" maxlength="255" />
				</td>
			</tr>
		</table>
		<br />
		<br />
	</dw:Dialog>

    <input type="hidden" name="templateId" id="templateId" value="" />
    <input type="hidden" name="topFolderId" id="topFolderId" value="<%=TopFolderId%>" />
    <input type="submit" name="cmdSubmit" id="cmdSubmit" style="display: none;" />

    <script type="text/javascript">
        EmailTypeSelect.topFolderSubject = '<%=TopFolderSubject %>';
    </script>

</asp:Content>
