<%@ Page Language="vb" AutoEventWireup="false"%>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>


<%
Dim MediaDBOrientationMaxratio As Double
Dim MediaDBOrientationMinratio As Double
Dim sql As String
Dim mediaConn As IDbConnection = Database.CreateConnection("DWMedia.mdb")
Dim cmdMedia As IDbCommand = mediaConn.CreateCommand

sql = "SELECT * FROM MediaDBOrientation WHERE MediaDBOrientationID = " & Base.ChkNumber(Request.Form("MediaDBOrientationID"))

Dim adMediaAdapter As IDbDataAdapter = Database.CreateAdapter()
Dim cb As Object = Database.CreateCommandBuilder(adMediaAdapter)
Dim dsMedia As DataSet = New DataSet
Dim newRow As DataRow

cmdMedia.CommandText = SQL
adMediaAdapter.SelectCommand = cmdMedia
adMediaAdapter.Fill(dsMedia)

If Len(Request.Form("MediaDBOrientationID")) > 0 Then
    newRow = dsMedia.Tables(0).Rows(0)
Else
    newRow = dsMedia.Tables(0).NewRow()
    dsMedia.Tables(0).Rows.Add(newRow)
End If

newRow("MediaDBOrientationName") = Base.ChkValue(Request.Form("MediaDBOrientationName"))
If Base.StripIllegalCharsExt(Request.Form("MediaDBOrientationMinratio"), "0123456789,.") <> "" Then
	MediaDBOrientationMinratio = Base.StripIllegalCharsExt(Request.Form("MediaDBOrientationMinratio"), "0123456789,.")
	If InStr(MediaDBOrientationMinratio, ",") > 0 Or InStr(MediaDBOrientationMinratio, ".") Then
		MediaDBOrientationMinratio = Replace(MediaDBOrientationMinratio, ",", "")
		MediaDBOrientationMinratio = Replace(MediaDBOrientationMinratio, ".", "")
		MediaDBOrientationMinratio = MediaDBOrientationMinratio / 10
	End If
	newRow("MediaDBOrientationMinratio") = MediaDBOrientationMinratio
Else
	Response.Write("<script>alert('" & Translate.JSTranslate("Der skal angives en værdi i: %%", "%%", Translate.JSTranslate("Min. ratio")) & "');history.go(-1);</script>")
	Response.End()
End If

If Base.StripIllegalCharsExt(Request.Form("MediaDBOrientationMaxratio"), "0123456789,.") <> "" Then
	MediaDBOrientationMaxratio = Base.StripIllegalCharsExt(Request.Form("MediaDBOrientationMaxratio"), "0123456789,.")
	If InStr(MediaDBOrientationMaxratio, ",") > 0 Or InStr(MediaDBOrientationMaxratio, ".") Then
		MediaDBOrientationMaxratio = Replace(MediaDBOrientationMaxratio, ",", "")
		MediaDBOrientationMaxratio = Replace(MediaDBOrientationMaxratio, ".", "")
		MediaDBOrientationMaxratio = MediaDBOrientationMaxratio / 10
	End If
	If CDbl(MediaDBOrientationMinratio) >= CDbl(MediaDBOrientationMaxratio) Then
		Response.Write("<script>alert('" & Translate.JSTranslate("ґ%f%ґ mе ikke vжre stшrre end ґ%t%ґ!", "%f%", Translate.JSTranslate("Maks. ratio"), "%t%", Translate.JSTranslate("Min. ratio")) & "');history.go(-1);</script>")
		Response.End()
	End If
	newRow("MediaDBOrientationMaxratio") = MediaDBOrientationMaxratio
Else
	Response.Write("<script>alert('" & Translate.JSTranslate("Der skal angives en værdi i: %%", "%%", Translate.JSTranslate("Maks. ratio")) & "');history.go(-1);</script>")
	Response.End()
End If

adMediaAdapter.Update(dsMedia)

dsMedia.Dispose
mediaConn.Dispose

Translate.GetEditOnlineScript()

Response.Redirect(("Media_Orientation_List.aspx"))
%>
