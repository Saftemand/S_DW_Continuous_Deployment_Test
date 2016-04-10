
var JsonCartPageId = 0; /* The hidden cart json page */
var ProductListPageId = 0; /* The main productlist page */

function MiniCartInit(JsonPId, ProductId) {
	JsonCartPageId = JsonPId;
	ProductListId = ProductId;

	UpdateCart(("Default.aspx?ID=" + JsonCartPageId + "&Redirect=false"));
}

function AddToCart(e, productid, quantity) {
	/* Stop href linking */
	e.preventDefault();

	/* Animated focus on the cart */
	$('#minipagecart').addClass("dw-minicart-update");
	$('#minipagecart-button').addClass("btn btn-sm dw-minicart-update");

	setTimeout(function () {
	    $('#minipagecart').removeClass("dw-minicart-update");
		$('#minipagecart-button').removeClass("btn btn-sm dw-minicart-update");
	}, 2800);

	var btntext = $(e.target).html();
	$(e.target).html("<i class=\"fa fa-circle-o-notch fa-spin\"></i>");
	$(e.target).addClass('faded');

	setTimeout(function () {
	    $(e.target).html(btntext);
	    $(e.target).removeClass('faded');
	}, 1400);

	/* Update the cart based on the add-new url */
	var Url = "Default.aspx?ID=" + JsonCartPageId + "&cartcmd=add";
	Url += "&Quantity=" + quantity;
    Url += "&ProductID=" + productid;
    Url += "&Redirect=false";

    UpdateCart(Url)
};

function EmptyCart() {
	$('#minipagecart').html("<i class=\"fa fa-shopping-cart\"></i><span class=\"amount\"></span>");

    UpdateCart("Default.aspx?ID=" + JsonCartPageId + "&cartcmd=emptycart");

	location.reload(true); /* Secures that this also makes sense in the checkout flow */
}

function UpdateCart(Url) {
	$.getJSON(Url, function (jd) {
		CartUpdated(jd);
	});

	$('#full-cart').hide();
	$('#empty-cart').show();
}

function CartUpdated(Data) {
	$('#minipagecart').html("<i class=\"fa fa-shopping-cart\"></i> " + Data.numberofproducts + " <span class=\"amount\">" + Data.totalprice + "</span>");
	$('#mincart-total-items').html('<strong>' + Data.numberofproducts + '</strong>');
	
	if (Data.orderlines.length > 0) {
		$('#full-cart').show();
		$('#empty-cart').hide();
	} else {
		$('#full-cart').hide();
		$('#empty-cart').show();
	}

	/* Clean out the old content */
	$('#minicart-content table tbody').empty();

	/* Build the product list, one item after another (Uses a method from js/GeneralMethods.js) */
	for (var i = 0; i < Data.orderlines.length; i++) {
		/* Hack to make the link lead to the rigtht product page */
		Data.orderlines[i].link = Data.orderlines[i].link.replace(("ID="+JsonCartPageId.toString()), ("ID="+ProductListId.toString()));

		if (Data.orderlines[i].id == ""){
			Data.orderlines[i].link = "";
		}

		CreateItemFromJson(Data.orderlines[i], '#minicart-content table tbody', '#OrderlineAjaxTemplate');
	}

	$('#minicart-payment').html(Data.paymentmethod);
	$('#minicart-paymentfee').html(Data.paymentfee);
	$('#minicart-shipping').html(Data.shippingmethod);
	$('#minicart-shippingfee').html(Data.shippingfee);
	$('#minicart-total').html("<strong>" + Data.numberofproducts + "</strong>");
	$('#minicart-totalprice').html("<strong>" + Data.totalprice + "</strong>");
}
