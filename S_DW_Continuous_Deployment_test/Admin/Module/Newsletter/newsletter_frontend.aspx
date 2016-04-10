<%@ Page CodeBehind="newsletter_frontend.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.newsletter_frontend" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import Namespace="Dynamicweb.Frontend.LegacyModules.Newsletter" %>


<%

    Dim d As New NewsletterFrontend


        Dim strXml As String
        Dim cn As IDbConnection = Database.CreateConnection("Dynamic.mdb")
        Dim cmd As IDbCommand = cn.CreateCommand
        cmd.CommandText = "SELECT ParagraphModuleSettings FROM Paragraph WHERE ParagraphID = 2698"
        Dim dr As IDataReader = cmd.ExecuteReader
        If dr.Read() Then
            strXml = dr("ParagraphModuleSettings").ToString
        Else

        End If

        Response.Write(d.Newsletter(strXml, "2698"))


%>
