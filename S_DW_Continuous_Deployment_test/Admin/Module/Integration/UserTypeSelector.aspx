<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="UserTypeSelector.aspx.vb" Inherits="Dynamicweb.Admin.UserTypeSelector" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title><%=Translate.Translate("User selector")%></title>
    
    <meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
	<link rel="STYLESHEET" type="text/css" href="../../Stylesheet.css">
	
    <style media="screen" type="text/css">
        html, body 
        {
            margin: 0;
            padding: 0;
            height: 100%;
            width: 100%;
            
            }
        #container 
        {
            position: absolute;
            width: 510px;
            height: 450px;
            left: 50%;
            top: 50%;
            margin-left: -300px;
            margin-top: -200px;
            background: #ebf0f9;
            color: #c0c0c0;
            border: 1px solid #ffffff;
            }
    </style>	
</head>

<%

%>

<body>
    <form id="form1" runat="server">
    <div id="container">
    
    <table cellpadding="0" cellspacing="0" border="0" style="width:402px;height:100%;" align="center">
    <tr style="height:10px;"><td colspan="3"></td></tr>    
    <tr style="height:10px;">
        <td colspan="3">
    	    <b><%=Translate.Translate("First time ?")%></b><br/>
			<%Response.Write(Translate.Translate("Please select your type of user."))%><br/>
	    </td>
    </tr>    
    <tr style="height:50px;"><td colspan="3"></td></tr>    
    <tr>
	    <td valign="top">
		    <table cellpadding="0" cellspacing="0" border="0" style="width:180px;">
		        <tr>
		            <td>
    	                <label for="usertype_beginner">
            			    <img src="images/user_beginner.png" border="0" onclick="document.getElementById('usertype_beginner').checked = true;"><br/><br/>
            			</label>
        		    </td>
		        </tr>
		        <tr valign="top">
		            <td style="height:140px;">
    	                <label for="usertype_beginner">
            			    <b><%=Translate.Translate("Beginner")%></b><br/><br/>
		            	    <%Response.Write(Translate.Translate("Choose ""Beginner"" if you are not an experienced user of XML, XSLT and XPath. A wizard will guide you through the import/export setup"))%><br/>
		            	</label>
        		    </td>
    		    </tr>
	    	    <tr>
	        	    <td>
			            <input type="radio" id="usertype_beginner" name="usertype" value="0" <%=checked%>>
		            </td>
      		    </tr>
		    </table>
	    </td>
    	
	    <td valign="top" style="width:1px;"></td>

	    <td valign="top">
	    
		    <table cellpadding="0" cellspacing="0" border="0" style="width:180px;" <%=dimmedStyle%>>
		        <tr>
		            <td>
		                <label for="usertype_experienced">
			                <img src="images/user_advanced.png" border="0" onclick="document.getElementById('usertype_experienced').checked = true;"><br/><br/>
			            </label>
		            </td>
		        </tr>
		        <tr valign="top">
		            <td style="height:140px;">
		                <label for="usertype_experienced">
	    	                <b><%=Translate.Translate("Experienced")%></b><br/><br/>
    			            <%Response.Write(Translate.Translate("Choose ""Experienced"" if you are familiar with terms like XML, XSLT and XPath. You will have access to wide range of activities allowing you to configure various import/export pipelines."))%>.<br/>
    			            <%
    			                If Not Base.HasAccess("DW_Integration_ImportExportExtended", "") Then
    			                    Response.Write(Translate.Translate("Requires Import/export Extende)") & "<br />")
    			                End If
                            %>
    			        </label>
		            </td>
		        </tr>
		        <tr>
		            <td>
			            <span <%=hiddenStyle%>><input type="radio" id="usertype_experienced" name="usertype" value="1"></span>
		            </td>
		        </tr>		    
		    </table>
		    
	    </td>
    </tr>
    <tr style="height:10px;"><td colspan="3"></td></tr>  
    <tr align="right"><td colspan="3"><button onclick="form1.submit();"><%=Translate.Translate("OK")%></button></td></tr>  
    <tr style="height:10px;"><td colspan="3"></td></tr>  
    </table>    
    
    </div>
    </form>
</body>
</html>
<%Dynamicweb.Backend.Translate.GetEditOnlineScript()%>