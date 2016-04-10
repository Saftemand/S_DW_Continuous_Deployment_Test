<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="TemplateSelector.ascx.vb" Inherits="Dynamicweb.Admin.TemplateSelector" %>
<%@ Register Assembly="DynamicWeb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>

<div id="selectorContainer" class="templateSelector" runat="server">
    <dw:TemplatedDropDownList ID="TemplatesList" Width="200" Height="28" runat="server">
        <BoxTemplate>
            <span class="templateItem">
                <span class="templateIcon">
                    <img id="imgIcon" class="iconImage" border="0" width="24" height="24" alt="" runat="server" />
                </span>
                <span class="templateDetails" style="padding-left: 30px">
                    <span class="detailsClean detailsHeading detailsHeadingBig">
                        <asp:Literal ID="litName" runat="server" />
                    </span>
                </span>
            </span>
        </BoxTemplate>
        <ItemTemplate>
            <span class="templateItem">
                <span class="templateIcon">
                    <img id="imgIcon" class="iconImage" alt="" border="0" runat="server" />
                </span>
                <span class="templateDetails" style="padding-left: 48px">
                    <span class="detailsClean">
                        <strong>
                            <asp:Literal ID="litName" runat="server" />
                        </strong>
                        
                        <br />
                        
                        <asp:Literal ID="litFileName" runat="server" />
                        
                        <br />
                        
                        <asp:Literal ID="litDescription" runat="server" />
                        
                        <br />
                        
                        <i>
                            <span class="templateFieldName">
                                <dw:TranslateLabel ID="lbModified" Text="Modified" runat="server" />:&nbsp;
                            </span>
                            
                            <asp:Literal ID="litModifiedDate" runat="server" />
                        </i>
                        
                        <br />
                        
                        <i>
                            <span class="detailsClean ratingRow">
                                <span class="templateFieldName">
                                    <dw:TranslateLabel ID="lbRating" Text="Rating" runat="server" />:&nbsp;
                                </span>
                                
                                <asp:Literal ID="litRating" runat="server" />
                            </span>
                        </i>
                    </span>
                </span>
            </span>
            
            <input id="templateID" type="hidden" class="hiddenTemplateID" runat="server" />
        </ItemTemplate>
    </dw:TemplatedDropDownList>
    
    <input type="hidden" class="selectedTemplateID" id="hiddenSelectedTemplateID" runat="server" />
</div>