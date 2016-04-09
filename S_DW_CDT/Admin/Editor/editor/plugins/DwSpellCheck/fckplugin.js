// Register the related command. 
// RegisterCommand takes the following arguments: CommandName, DialogCommand 
// FCKDialogCommand takes the following arguments: CommandName, Dialog Title, Path to HTML file, Width, Height 
 
FCKCommands.RegisterCommand( 'DwSpellCheck', new FCKDialogCommand( 'DwSpellCheck', FCKLang.DwSpellCheckDlgTitle,  
'/admin/netspell/netspell.aspx?EditorName=ParagraphText', 700, 700 ) ) ; 
 
// Create the toolbar button. 
// FCKToolbarButton takes the following arguments: CommandName, Button Caption 
 
var oDwSpellCheckItem = new FCKToolbarButton( 'DwSpellCheck', FCKLang.DwSpellCheckBtn ) ; 
oDwSpellCheckItem.IconPath = FCKPlugins.Items['DwSpellCheck'].Path + 'DwSpellCheck.gif' ; 
FCKToolbarItems.RegisterItem( 'DwSpellCheck', oDwSpellCheckItem ) ; 
 
// The object used for all DwSpellCheck operations. 
var FCKDwSpellCheck = new Object() ; 
 
// Add a new DwSpellCheck at the actual selection.  
// This function will be called from the HTML file when the user clicks the OK button. 
// This function receives the values from the Dialog 
 
FCKDwSpellCheck.Add = function( linkname, caption ) 
{ 
if(linkname.substr(0,4) != "http" && linkname.substr(0,4) != "HTTP") 
linkname = "http://"+linkname ; 
FCK.InsertHtml("<a href='"+linkname+"'>"+caption+"</a>") ; 
} 
//End code 