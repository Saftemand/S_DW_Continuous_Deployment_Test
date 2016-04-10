<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="spellchecker.aspx.vb" Inherits="Dynamicweb.Admin.spellchecker" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <link rel="stylesheet" type="text/css" href="../spellerStyle.css" />
    <script language="javascript" src="../wordWindow.js"></script>
    <script language="javascript" type="text/javascript">
    
        var wordWindowObj = new wordWindow();
        wordWindowObj.originalSpellings = words;
        wordWindowObj.suggestions = suggs;
        wordWindowObj.textInputs = textinputs;

        function init_spell() {
	        if( error ) {
		        alert( error );
	        } else {
		        if (parent.frames.length) {
			        parent.init_spell( wordWindowObj );
		        } else {
			        alert('This page was loaded outside of a frameset. It might not display properly');
		        }
	        }
        }
    </script>
    <title></title>
</head>
<body onload="init_spell();" bgcolor="#ffffff">
    <script type="text/javascript">
        wordWindowObj.writeBody();
    </script>
</body>
</html>
