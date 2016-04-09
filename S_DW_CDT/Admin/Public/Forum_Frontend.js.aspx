<%@ Page CodeBehind="Forum_Frontend.js.aspx.vb" Language="vb" AutoEventWireup="false" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>

<%
'*** NP 09082005
Response.ContentType = "application/x-javascript"
%>
	function ToggleForumMessage(intMessageID, intParagraphID) {
		if (document.getElementById("Forum_Message_" + intMessageID)) {
			if (document.getElementById("Forum_Message_" + intMessageID).style.display == "") {
				document.getElementById("Forum_Message_" + intMessageID).style.display = "none";
				document.images["Forum_Message_Image_" + intMessageID].src = "/" + eval("ForumBulletPictureExpanded" + intParagraphID);
			}
			else {
				document.getElementById("Forum_Message_" + intMessageID).style.display = "";
				document.images["Forum_Message_Image_" + intMessageID].src = "/" + eval("ForumBulletPicture" + intParagraphID);
			}
		}
	}

	function DoPostReply () {
		// If the postform there?
		if (ForumMessageReply) {
			if (document.ForumMessageReply.ForumMessageName.value == "") {
				alert('<%=("Angiv emne")%>.');
				document.ForumMessageReply.ForumMessageName.focus();
			}
			else if (document.ForumMessageReply.ForumMessageAuthor.value == "") {
				alert('<%=("Angiv forfatter")%>.');
				document.ForumMessageReply.ForumMessageAuthor.focus();
			}
			else {
				document.ForumMessageReply.action = document.location.href + "&Cmd=post";
				document.ForumMessageReply.submit();
			}
		}
	}
	
	function DoPostNew () {
		// If the postform there?
		if (document.ForumMessageNew) {
			if (document.ForumMessageNew.ForumMessageName.value == "") {
				alert('<%=("Angiv emne")%>.');
				document.ForumMessageNew.ForumMessageName.focus();
			}
			else if (document.ForumMessageNew.ForumMessageAuthor.value == "") {
				alert('<%=("Angiv forfatter")%>.');
				document.ForumMessageNew.ForumMessageAuthor.focus();
			}
			else {
				document.ForumMessageNew.action = document.location.href + "&Cmd=post";
				document.ForumMessageNew.submit();
			}
		}
	}
