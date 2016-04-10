<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ColorPick.aspx.vb" Inherits="Dynamicweb.Admin.ColorPick" EnableViewState="False" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script type="text/javascript" src="/Admin/Filemanager/FileEditor/jquery/jquery.js"></script>
    <script type="text/javascript" language="JavaScript">
        jQuery(document).ready(function () {
            $("#Logo").click(function (e) {
                var x = e.pageX - this.offsetLeft;
                var y = e.pageY - this.offsetTop;
                document.getElementById('X').value = x;
                document.getElementById('Y').value = y;
                $('#form1').submit();
            });
            window.parent.document.getElementById('basicColor').value = document.getElementById('ChosenColor').value;
            window.parent.document.getElementById('basicColorPreview').style.backgroundColor = document.getElementById('ChosenColor').value;

        })
</script>
</head>
<body>
    
    <form id="form1" runat="server" enableviewstate="False">
    <asp:HiddenField ID="ChosenColor" runat="server" value="#FFFFFF"/>
    <asp:HiddenField ID="X" runat="server" EnableViewState="False" Value="-1"/>
    <asp:HiddenField ID="Y" runat="server" EnableViewState="False" Value="-1"/>
   <asp:Image ID="Logo" runat="server" Width="500" style="cursor:crosshair;" />
   
    </form>
</body>
</html>
