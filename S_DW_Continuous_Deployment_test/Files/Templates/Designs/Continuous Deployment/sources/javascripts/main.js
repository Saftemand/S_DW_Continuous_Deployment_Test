var App = App || {};

$(function() {
  /**
   * Initialize modules
   */

  App.Header.initialize();
  App.ScrollPosition.initialize();
  App.Navigation.initialize();
  App.NavTouch.initialize();
  App.ScrollToAnchor.initialize();
  App.ScrollHideContent.initialize();
  App.VideoVimeo.initialize();
  App.ToggleClass.initialize();
  App.Search.initialize();
  // GLS loopup
  App.GLSLookup.initialize();
  // Is depended on jquery.prettySocial.js
  $( '.js-social-bar' ).prettySocial();

  // Product list
  if( $('.js-product-list').length > 0 ) {
    App.ProductList.initialize();
    App.ProductListHover.initialize();
    App.ProductListSorting.initialize();
    App.FilterCheckbox.initialize();
    console.log('New feature!');
  }
  // Product
  if( $('.js-product-form').length > 0 ) {
    App.ProductCard.initialize();
    App.Slider.initialize();
  }
  // Checkout
  if( $( '.js-required-form' ).length > 0 ) {
    App.Checkout.initialize();
    App.Validation.initialize();
  }
  // Ajax content
  App.AjaxContent.initialize();
  // Cookiebar
  App.CookieBar.initialize();

  // Retailers Page Related
  App.Retailers.initialize();

  // Instagram
  if( $('.js-instagram').length > 0 ) {
    App.Instagram.initialize();
  }
});