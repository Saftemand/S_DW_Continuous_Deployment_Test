<%@ Page Language="vb" MasterPageFile="~/Admin/Module/Common/Records.Master" AutoEventWireup="false" CodeBehind="CustomFields_records.aspx.vb" Inherits="Dynamicweb.Admin.ModulesCommon.CustomFields_records" %>
<%@ Register Src="~/Admin/Module/Common/Record.ascx" TagName="Record" TagPrefix="list" %>

<asp:content id="Columns" contentplaceholderid="ListColumns" runat="server">
    <list:Record runat="server" ID="Name" Width="38%" IsAction="true" OnRecordClick="OnEdit" ImgSrc="/Admin/Module/NewsLetterV3/Img/CustomFields.gif" 
        Text='<%# Eval("Name") %>' RecordID='<%# Eval("ID") %>' />
    <list:Record runat="server" ID="TemplateTag" Width="25%" 
        Text='<%# Eval("SystemName") %>' />
    <list:Record runat="server" ID="Type" Width="25%" 
        Text='<%#_typeNames(Eval("TypeID"))%>' />
</asp:content>                            
