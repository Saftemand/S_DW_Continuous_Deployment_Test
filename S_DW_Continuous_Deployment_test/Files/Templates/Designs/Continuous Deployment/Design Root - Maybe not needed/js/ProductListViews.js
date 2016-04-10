
function InitListView(View) {
	if (View == "box"){
		if (!getCookie("productviewtype")) {
			BoxView();
		} else {
			listviewCookietest();
		}
	} else {
		if (!getCookie("productviewtype")) {
			ListView();
		} else {
			listviewCookietest();
		}
	}
}

function listviewCookietest() {
	if (getCookie("productviewtype")) {
		if (getCookie("productviewtype") == "box"){
			BoxView();
		} else {
			ListView();
		}
	} 
}

window.onresize = function () {
	TestScreenSize();
}

function TestScreenSize(){
	if ($(this).width() < 768) {
		BoxView();
	} else {
		listviewCookietest();
	}
}
	
function BoxView() {
	var arr = new Array();
	arr = document.getElementsByClassName("productlist");
    
	for(var i = 0; i < arr.length; i++)
	{
		arr.item(i).className = "productlist col-md-4 col-sm-4 col-xs-12";
	}
	
	arr = document.getElementsByClassName("listproductright");
	for(var i = 0; i < arr.length; i++)
	{
		arr.item(i).className = "listproductright";
	}

	arr = document.getElementsByClassName("extracolumn");
	for(var i = 0; i < arr.length; i++)
	{
		arr.item(i).className = "extracolumn";
	}

	arr = document.getElementsByClassName("boxproduct");
	for(var i = 0; i < arr.length; i++)
	{
		arr.item(i).className = "boxproduct wp-block product";
	}

	arr = document.getElementsByClassName("listproductleft");
	for(var i = 0; i < arr.length; i++)
	{
		arr.item(i).className = "listproductleft wp-block-footer";
	}

	arr = document.getElementsByClassName("shortproductdescription");
	for(var i = 0; i < arr.length; i++)
	{
		arr.item(i).style = "";
	}

	arr = document.getElementsByClassName("longproductdescription");
	for(var i = 0; i < arr.length; i++)
	{
		arr.item(i).style = "display: none !important; text-align: left !important";
	}

	arr = document.getElementsByClassName("productfigure");
	for(var i = 0; i < arr.length; i++)
	{
		arr.item(i).style = "border-bottom: 1px solid #E0EDED";
	}

	document.cookie = "productviewtype=box"; 
}	
	
function ListView() {
	var arr = new Array();
	arr = document.getElementsByClassName("productlist");
    
	for(var i = 0; i < arr.length; i++)
	{
		arr.item(i).className = "productlist col-md-12 col-sm-12 col-xs-12";
	}

	arr = document.getElementsByClassName("listproductright");
	for(var i = 0; i < arr.length; i++)
	{
		arr.item(i).className = "listproductright col-md-4 col-sm-4 col-xs-12";
	}

	arr = document.getElementsByClassName("extracolumn");
	for(var i = 0; i < arr.length; i++)
	{
		arr.item(i).className = "extracolumn col-md-8 col-sm-8 col-xs-12";
	}

	arr = document.getElementsByClassName("boxproduct");
	for(var i = 0; i < arr.length; i++)
	{
		arr.item(i).className = "boxproduct wp-block product";
	}

	arr = document.getElementsByClassName("listproductleft");
	for(var i = 0; i < arr.length; i++)
	{
		arr.item(i).className = "listproductleft col-md-8 col-sm-8 col-xs-12";
	}

	arr = document.getElementsByClassName("shortproductdescription");
	for(var i = 0; i < arr.length; i++)
	{
		arr.item(i).style = "display: none !important";
	}

	arr = document.getElementsByClassName("longproductdescription");
	for(var i = 0; i < arr.length; i++)
	{
		arr.item(i).style = "text-align: left !important";
	}

	arr = document.getElementsByClassName("productfigure");
	for(var i = 0; i < arr.length; i++)
	{
		arr.item(i).style = "border-bottom: none";
	}
	
	document.cookie = "productviewtype=list"; 
}


function SortProductsBy(sortcode) {
	var Page = "@grouplink";
	
	document.cookie = "sortby=" + sortcode; 
	document.location.href = Page + "&SortBy=" + sortcode;
}