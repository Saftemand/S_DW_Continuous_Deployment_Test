<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Copy.aspx.vb" Inherits="Dynamicweb.Admin.Copy1" Buffer="True"  %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
	<title></title>
	<meta http-equiv="Pragma" content="no-cache" />
	<meta name="Cache-control" content="no-cache" />
	<meta http-equiv="Cache-control" content="no-cache" />
	<meta http-equiv="Expires" content="Tue, 20 Aug 1996 14:25:27 GMT" />
    <script type="text/javascript">
        <%If IsNew Then%>
            location = "List.aspx";
        <%Else %>
            parent.location = "List.aspx";
        <%End if %>
    	top.left.location = "/Admin/menu.aspx?AreaID=<%=NewAreaID%>";
	</script>
</head>
<body>
Done...
</body>
</html>
