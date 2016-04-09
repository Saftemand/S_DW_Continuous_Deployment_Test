<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PhraseAnalyzer.aspx.vb" Inherits="Dynamicweb.Admin.PhraseAnalyzer"%>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="Dynamicweb" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
  <head>
		<title></title>
		<link rel="STYLESHEET" type="text/css" href="/Admin/Stylesheet.css">
			<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
			<script language="javascript">
			    function t(RowId, img) {
			        if (document.getElementById(RowId).className == 'h') {
			            document.getElementById(RowId).className = 'd';
			            img.src = "/Admin/Images/Expand_off.gif"
			        }
			        else {
			            document.getElementById(RowId).className = 'h';
			            img.src = "/Admin/Images/Expand.gif"
			        }
			    }

			    function send(btn) {
			        if (document.forms.words.w) {
			            var checkedCounter = 0;
			            for (var i = 0; i < document.forms.words.w.length; i++) {
			                if (document.forms.words.w[i].checked) {
			                    checkedCounter++
			                }

			            }
			            if (checkedCounter > 3) {
			                alert('<%=Translate.JSTranslate("Choose_no_more_than_3_phrases_at_a_time")%>');
			                return;
			            }
			            if (checkedCounter > 0) {
			                btn.disabled = true;
			                document.forms.words.submit();
			                return;
			            }
			            alert('<%=Translate.JSTranslate("Choose_at_least_one_phrase")%>');
			        }
			    }
			    function MSSelected(value) {
			        /*if (value == "0" || value == "1" || value == "3") {
			            window.parent.document.getElementById("SetSessionVar").children[1].value = "en";
			            window.parent.document.getElementById("SetSessionVar").children[3].value = "US";
			            window.parent.document.getElementById("SetSessionVar").children[1].disabled = true;
			            window.parent.document.getElementById("SetSessionVar").children[3].disabled = true;
                        }
			        else {
			            window.parent.document.getElementById("SetSessionVar").children[1].disabled = false;
			            window.parent.document.getElementById("SetSessionVar").children[3].disabled = false;
			        }

			        window.parent.document.getElementById("SetSessionVar").submit();*/
                }
			</script>
			<style>
			.t{
				border-left:1px solid #ccc;
				border-top:1px solid #ccc;
				width:100%;
			}
			
			.w{
				height:20px;
			}
			
			.w td{
				border-right:1px solid #ccc;
				border-bottom:1px solid #ccc;
				margin:3px;
			}
			.h{
				display:none;
			}
			.h td{
				border-bottom:1px solid #ccc;
			}
			.d{display:;}
			.p{cursor:pointer;}
			</style>
	</head>
  <body onload="parent.ac1(parent.document.getElementById('PhraseAnalyzer'))">
		<dw:tabheader id="TabHeader1" runat="server" title="Phrase analysis" returnwhat="All" headers="Document"></dw:tabheader>
		<table border="0" cellpadding="0" cellspacing="0" class="tabTable">
			<tr>
				<td valign="top">
				<br>
					<form action="PhraseAlternativesStart.aspx" method="get" name="words">
					<input type="hidden" value="<%=Base.Request("ID")%>" name="ID">
					<table border="0" cellpadding="0" width="598">
						<tr>
							<td><%=getWordTable()%></td>
						</tr>
					</table>
					</form>
				</td>
			</tr>
		</table>
        <%Dynamicweb.Backend.Translate.GetEditOnlineScript()%>
	<script language="javascript">
      MSSelected("0")
  </script>
  </body>
</html>
