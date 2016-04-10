<%@ Page Language="vb" MasterPageFile="~/Admin/Module/Common/Records.Master" AutoEventWireup="false" CodeBehind="CustomGroups_records.aspx.vb" Inherits="Dynamicweb.Admin.ModulesCommon.CustomGroups_records" %>
<%@ Register Src="~/Admin/Module/Common/Record.ascx" TagName="Record" TagPrefix="list" %>

<asp:content id="Columns" contentplaceholderid="ListColumns" runat="server">
    <list:Record runat="server" ID="Name" Width="67%" IsAction="true" OnRecordClick="OnEdit" ImgSrc="/Admin/Images/Icons/Module_NewsV2_CFG_s.gif" 
        Text='<%# Eval("Name") %>' RecordID='<%# Eval("ID") %>' />
    <list:Record runat="server" ID="TemplateTag" Width="25%" 
        Text='<%# Eval("FieldsCount") %>' />
</asp:content>                            
