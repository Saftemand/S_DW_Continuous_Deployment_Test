<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/Admin/Module/Common/Records.Master" CodeBehind="CustomFields_specific_records.aspx.vb" Inherits="Dynamicweb.Admin.NewsV2.CustomFields_specific_records" %>
<%@ Register Src="~/Admin/Module/Common/Record.ascx" TagName="Record" TagPrefix="list" %>

<asp:content id="Columns" contentplaceholderid="ListColumns" runat="server">
    <list:Record runat="server" ID="Name" Width="38%" IsAction="true" OnRecordClick="OnEdit" ImgSrc="/Admin/Images/Icons/Module_Form_small.gif" 
        Text='<%# Eval("Name") %>' RecordID='<%# Eval("ID") %>' />
    <list:Record runat="server" ID="TemplateTag" Width="25%" 
        Text='<%# Eval("SystemName") %>' />
    <list:Record runat="server" ID="Type" Width="25%" 
        Text='<%#_typeNames(Eval("TypeID"))%>' />
</asp:content>                            
