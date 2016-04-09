<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="JobRunner.aspx.vb" Inherits="Dynamicweb.Admin.JobRunner" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body style="height: 100%;">
    <form id="form1" runat="server" style="height: 100%;">
        <div>
            Job started successfully.<br/>
            See log file: <label runat="server" id="logFilePath"></label>
        </div>
    </form>
</body>
</html>
