<%@ Page Language="vb" AutoEventWireup="false"%>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>

<%
'*** NP 09082005
        Private Function BoTranslate(ByVal str As String) As String
            Select Case str
                Case "Angiv e-mail adresse"
                    Return "Enter e-mail address!"
                Case "Angiv emne"
                    Return "Enter subject!"
                Case "Angiv forfatter"
                    Return "Enter author!"
                Case "Angiv kodeord"
                    Return "Enter password!"
                Case "Angiv navn", "Enter your name"
                    Return "Enter name!"
                Case "Der er ikke valg nogen nyhedsliste", "You must select select a newsletter!"
                    Return "No newslettter list selected!"
                Case "Der er ikke valg nogen nyhedsliste.\nEr det korrekt?"
                    Return "No newslettter list selected!\nContinue?"
                Case "Enter a valid e-mail address"
                    Return "Enter valid e-mail address!"
                Case "Enter valid e-mail to receive copy."
                    Return "Enter valid e-mail address to send copy to."
                Case "Feltet %% skal udfyldes!"
                    Return "The field %% must be filled in!"
                Case "Kodeordet er gentaget forkert"
                    Return "Passwords do not match!"
                Case "Registrering gennemført"
                    Return "Registration complete"
                Case Else
                    Return str
            End Select
        End Function

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
				alert('<%=BoTranslate("Angiv emne")%>.');
				document.ForumMessageReply.ForumMessageName.focus();
			}
			else if (document.ForumMessageReply.ForumMessageAuthor.value == "") {
				alert('<%=BoTranslate("Angiv forfatter")%>.');
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
				alert('<%=BoTranslate("Angiv emne")%>.');
				document.ForumMessageNew.ForumMessageName.focus();
			}
			else if (document.ForumMessageNew.ForumMessageAuthor.value == "") {
				alert('<%=BoTranslate("Angiv forfatter")%>.');
				document.ForumMessageNew.ForumMessageAuthor.focus();
			}
			else {
				document.ForumMessageNew.action = document.location.href + "&Cmd=post";
				document.ForumMessageNew.submit();
			}
		}
	}
