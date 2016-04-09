<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Editor.aspx.vb" Inherits="Dynamicweb.Admin.Management.QueryAnalyzer.Editor" %>

<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Query Analyzer</title>
    <dw:ControlResources ID="ControlResources1" runat="server">
    </dw:ControlResources>
    <script src="/Admin/Filemanager/FileEditor/CodeMirror-3.21.a/lib/codemirror.js" type="text/javascript"></script>
    <script src="/Admin/Filemanager/FileEditor/CodeMirror-3.21.a/mode/sql/sql.js" type="text/javascript"></script>
    <link rel="stylesheet" href="/Admin/Filemanager/FileEditor/CodeMirror-3.21.a/lib/codemirror.css" />
    <script type="text/javascript" src="/Admin/Filemanager/FileEditor/jquery/jquery.js"></script>

    <style type="text/css">
        #Tab1 {
            border-top: 1px solid #A0AFC3;
            position: fixed;
            bottom: 0;
            left: 0;
            top: 0;
            right: 0;
        }

        .CodeMirror {
            height: 100% !important;
        }
    </style>

    <script language="javascript" type="text/javascript">
        var Database = "Dynamic.mdb";
        
        function SetDatabase(DatabaseName){
            Database = DatabaseName;
        }
        
        function catchKey(e){
            if (e.ctrlKey && (e.keyCode == 0xA || e.keyCode == 0xD)){
                Fetch();
            }
        }
        
        
        function Fetch(){
        
            Query = escape(editor.getValue());
            $.ajax(
                {
                    type: "GET",
                    url: "QueryTester.aspx",
                    data: "Database=" + Database + "&Query=" + Query,
                    datatype: "xml",
                    success: function(xml){
                        $(xml).find("status").each(function(){
                        
                            var status = $(this).find("code").text();
                            var message = $(this).find("msg").text();
                            complete = false;
                            if (status == 200){
                                if (!isNaN(message)){
                                    if (message > 0){//update, insert, delete
                                        msg = "<%=Dynamicweb.Backend.Translate.JsTranslate("This will affect {#} records. Do you wish to continue?") %>"
                                        if (confirm(msg.replace("{#}", message))){
                                            complete = true;
                                        }
                                    }else{
                                        complete = true;
                                    }
                                }
                                
                            }else if (status == "15002"){
                                if (confirm("<%=Dynamicweb.Backend.Translate.JsTranslate("The effect of this statement cannot be evaluated prior to execution, but will affect the database immediately. Do you wish to continue?") %>")){
                                    complete = true;
                                }
                            }else{
                                alert("<%=Dynamicweb.Backend.Translate.JsTranslate("The following message was returned by the server") %>\n\n" + message)
                            }
                            if (complete){
                                window.parent.frames["Result"].document.location.href = "QueryResult.aspx?Query=" + Query + "&Database=" + Database;
                            }
                        }
                    )},
                    error: function(xml){
                        alert("<%=Dynamicweb.Backend.Translate.JsTranslate("An error occured while attempting to contact the server.") %>!" + xml + "!");
                    }
                }
            );
        }
        
        function Init(){
            $(document).keypress(catchKey);
            editor.focus();
        }
        
    </script>
</head>
<body onload="setTimeout('Init()', 2000);">
    <form id="form1" runat="server">
    <div>
        
        <div id="Tab1">
            <div style="height: 100%; width: 100%;">
                <textarea id="txtSql" style="float: left;width: 100%;">SELECT * FROM </textarea>
            </div>
        </div>
    </div>
    </form>
    
    <script type="text/javascript">
        var editor = CodeMirror.fromTextArea(document.getElementById('txtSql'), {
    		mode: "text/x-mysql",
    		tabMode: "indent",
    		matchBrackets: true,
    		lineNumbers: true,
            dragDrop: false
    	});
    </script>
    
</body>
</html>
<%  Dynamicweb.Backend.Translate.GetEditOnlineScript()%>