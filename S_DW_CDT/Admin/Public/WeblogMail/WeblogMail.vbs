Set oHTTP = CreateObject("Msxml2.ServerXMLHTTP")
oHTTP.Open "POST","http://127.0.0.3/WeblogMail/WeblogMail.aspx", False
oHTTP.Send
Set oHTTP = Nothing
