<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Color.aspx.vb" Inherits="Dynamicweb.Admin.ColorTest" %>

<!DOCTYPE html>
<html>
<head runat="server">
	<title></title>
	<style type="text/css">
		body {
			background-color: #e1e1e1;
		}

		.color {
			display: inline-block;
			padding: 10px;
			margin: 0px;
			width: 90px;
			font-size: 9px;
			font-family: Arial;
			border-radius: 4px;
			/*border: 2px solid inherit;*/
		}

		.active {
			/*border: 2px solid black;*/
		}

		.palette div.color:nth-child(6n+1) {
			/*clear: left;*/
		}

		.palette {
			display: inline-grid;
			padding: 10px;
			background-color: #fff;
			margin-bottom: 10px;
			width: 800px;
		}

		.text {
			visibility: hidden;
		}

		.color:hover .text {
			visibility: inherit;
		}

		h2 {
			clear: left;
			text-transform: uppercase;
			float: left;
			margin-top: 5px;
			margin-bottom: 5px;
			font-family: Arial;
			width: 150px;
			overflow: hidden;
		}

			h2 small {
				font-size: xx-small;
			}
	</style>
	<script>
		function c(hex) {
			location = "Color.aspx?hex=" + hex.replace("#", "");
		}
	</script>
</head>
<body>

	<div id="colors">
		<%=colors()%>
	</div>
</body>
<script runat="server" type="text/VB">
	Function Colors() As String
		Dim sb As New System.Text.StringBuilder

		Dim hex As String = "0085CA"
		If Dynamicweb.Input.RequestBoolean("clear") Then
			ClearHistory()
		End If
		If Not String.IsNullOrEmpty(Dynamicweb.Base.Request("hex")) Then
			hex = Dynamicweb.Base.Request("hex")
		End If
		RememberColor(hex)
		Dim myColor As Dynamicweb.Rendering.Colors.Color = Dynamicweb.Rendering.Colors.Color.FromHex(hex)

		sb.Append("<div class=""palette"">")
		sb.Append("<h2>History<br><small><a href=""Color.aspx?hex=" & hex & "&clear=true"">Clear</a></small></h2>")
		For Each historyhex As String In ColorHistory()
			sb.AppendLine(Cb(Dynamicweb.Rendering.Colors.Color.FromHex(historyhex)))
		Next
		sb.Append("</div>")
		sb.Append("<div class=""palette"">")
		sb.Append("<h2>Base & Clear</h2>")
		sb.AppendLine(Cb(myColor))
		sb.AppendLine(Cb(myColor.CleanColor))
		sb.Append("</div>")
		sb.Append("<div class=""palette"">")
		sb.Append("<h2>Accents<br><small>7, 12, 20</small></h2>")
		sb.AppendLine(Cb(myColor.AccentColor(7)))
		sb.AppendLine(Cb(myColor.AccentColor(-7)))
		sb.AppendLine(Cb(myColor.AccentColor(12)))
		sb.AppendLine(Cb(myColor.AccentColor(-12)))
		sb.AppendLine(Cb(myColor.AccentColor(20)))
		sb.Append("</div>")
		sb.Append("<div class=""palette"">")
		sb.Append("<h2>Accents<br><small>90, 135, 180, 270, 315</small></h2>")
		sb.AppendLine(Cb(myColor.AccentColor(90)))
		sb.AppendLine(Cb(myColor.AccentColor(135)))
		sb.AppendLine(Cb(myColor.AccentColor(180)))
		sb.AppendLine(Cb(myColor.AccentColor(270)))
		sb.AppendLine(Cb(myColor.AccentColor(315)))
		sb.Append("</div>")
		sb.Append("<div class=""palette"">")
		sb.Append("<h2>Clear</h2>")
		For Each c As Dynamicweb.Rendering.Colors.Color In myColor.GenerateClearColors(5)
			sb.AppendLine(Cb(c))
		Next
		sb.Append("</div>")
		
		sb.Append("<div class=""palette"">")
		sb.Append("<h2>Ligthen<br><small>5%, 10%, 15%, 20%, 25%</small></h2>")
		
		For i As Integer = 1 To 5
			sb.AppendLine(Cb(myColor.Lighten(i * 5)))
		Next
		sb.Append("</div>")
		
		sb.Append("<div class=""palette"">")
		sb.Append("<h2>Darken<br><small>5%, 10%, 15%, 20%, 25%</small></h2>")
		For i As Integer = 1 To 5
			sb.AppendLine(Cb(myColor.Darken(i * 5)))
		Next
		sb.Append("</div>")
		
		sb.Append("<div class=""palette"">")
		sb.Append("<h2>Shades</h2>")
		For Each c As Dynamicweb.Rendering.Colors.Color In myColor.GenerateShadeColors(5)
			sb.AppendLine(Cb(c))
		Next
		sb.Append("</div>")
		
		sb.Append("<div class=""palette"">")
		sb.Append("<h2>Tones</h2>")
		For Each c As Dynamicweb.Rendering.Colors.Color In myColor.GenerateToneColors(5)
			sb.AppendLine(Cb(c))
		Next
		sb.Append("</div>")
		
		sb.Append("<div class=""palette"">")
		sb.Append("<h2>Tints</h2>")
		For Each c As Dynamicweb.Rendering.Colors.Color In myColor.GenerateTintColors(5)
			sb.AppendLine(Cb(c))
		Next
		sb.Append("</div>")
		sb.Append("<div class=""palette"">")
		sb.Append("<h2>Pastels</h2>")
		For Each c As Dynamicweb.Rendering.Colors.Color In myColor.GeneratePastelColors(5)
			sb.AppendLine(Cb(c))
		Next
		sb.Append("</div>")
		
		sb.Append("<div class=""palette"">")
		sb.Append("<h2>Light greys</h2>")
		For Each c As Dynamicweb.Rendering.Colors.Color In myColor.GenerateLightGreyColors(5)
			sb.AppendLine(Cb(c))
		Next
		sb.Append("</div>")
		
		sb.Append("<div class=""palette"">")
		sb.Append("<h2>Greys</h2>")
		For Each c As Dynamicweb.Rendering.Colors.Color In myColor.GenerateGreyColors(5)
			sb.AppendLine(Cb(c))
		Next
		sb.Append("</div>")
		sb.Append("<div class=""palette"">")
		sb.Append("<h2>Dark greys</h2>")
		For Each c As Dynamicweb.Rendering.Colors.Color In myColor.GenerateDarkGreyColors(5)
			sb.AppendLine(Cb(c))
		Next
		sb.Append("</div>")
		
		sb.Append("<div class=""palette"">")
		sb.Append("<h2>Similar</h2>")
		For Each c As Dynamicweb.Rendering.Colors.Color In myColor.GenerateSimilarColors(5)
			sb.AppendLine(Cb(c))
		Next
		sb.Append("</div>")
		
		Return sb.ToString
	End Function
	
	Private Shared Function GetSeed(min As Integer, max As Integer, count As Integer, index As Integer) As Integer
		Return min + ((index - 1) * Convert.ToInt32(((max - min) / (count - 1))))
	End Function

	Private Shared Function Cb(ByVal c As Dynamicweb.Rendering.Colors.Color) As String
		Dim fontColor As String = "inherit"
		If c.Brightness < 100 Then
			fontColor = "#e1e1e1"
		End If
		Dim selectedClass As String = ""
		If Not String.IsNullOrEmpty(Dynamicweb.Base.Request("hex")) AndAlso c.ToHex.Replace("#", "").ToLower = Dynamicweb.Base.Request("hex").ToLower Then
			selectedClass = " active"
		End If
		Return "<div style=""background-color:" & c.ToHex & ";color:" & fontColor & """ class=""color" & selectedClass & """><div class=""text"">HEX: " & c.ToHex & " <a href=""#"" onclick=""c('" & c.ToHex & "');"">GO</a><br>HSV: " & Math.Round(c.Hsv.Hue) & "," & Math.Round(c.Hsv.Saturation * 100) & "," & Math.Round(c.Hsv.Value * 100) & "<br>RGB: " & c.BaseColor.R & "," & c.BaseColor.G & "," & c.BaseColor.B & "<br>HSL: " & Math.Round(c.Hsl.Hue) & "," & Math.Round(c.Hsl.Saturation * 100) & "," & Math.Round(c.Hsl.Lightness * 100) & "<br>RGB: " & c.BaseColor.R & "," & c.BaseColor.G & "," & c.BaseColor.B & "<br>Brigtness: " & c.Brightness & "</div></div>"
	End Function
	
	Private Sub RememberColor(hex As String)
		If Not ColorHistory.Contains(hex) Then
			ColorHistory.Add(hex)
		End If
	End Sub
	
	Private Sub ClearHistory()
		HttpContext.Current.Session("colorhistory") = New Generic.List(Of String)
	End Sub
	
	Private Shared Function ColorHistory() As Generic.List(Of String)
		If HttpContext.Current.Session("colorhistory") Is Nothing Then
			HttpContext.Current.Session("colorhistory") = New Generic.List(Of String)
		End If
		Return DirectCast(HttpContext.Current.Session("colorhistory"), Generic.List(Of String))
	End Function
</script>
</html>
