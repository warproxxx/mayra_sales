<?php

use Illuminate\Http\Request;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::middleware('auth:api')->get('/user', function (Request $request) {
    return $request->user();
});

// ************************************ USER SECTION **********************************************
Route::prefix('user')->group(function() {

    Route::post('register', 'User\RegisterController@register');
    Route::post('login',  'User\LoginController@api_login');

    Route::post('/forgot', 'User\ForgotController@forgot')->name('user-forgot-submit');

    // User Wishlist
    Route::get('/wishlists','User\WishlistController@wishlists')->name('user-wishlists');
    Route::get('/wishlist/add/{id}','User\WishlistController@addwish')->name('user-wishlist-add');
    Route::get('/wishlist/remove/{id}','User\WishlistController@removewish')->name('user-wishlist-remove');
    // User Wishlist Ends

    // User Review
    Route::post('/review/submit','User\UserController@reviewsubmit')->name('front.review.submit');
    // User Review Ends

    // User Orders
    Route::get('/orders', 'User\OrderController@orders')->name('user-orders');
    Route::get('/order/tracking', 'User\OrderController@ordertrack')->name('user-order-track');
    Route::get('/order/trackings/{id}', 'User\OrderController@trackload')->name('user-order-track-search');
    Route::get('/order/{id}', 'User\OrderController@order')->name('user-order');
    Route::get('/download/order/{slug}/{id}', 'User\OrderController@orderdownload')->name('user-order-download');
    Route::get('print/order/print/{id}', 'User\OrderController@orderprint')->name('user-order-print');
    Route::get('/json/trans','User\OrderController@trans');
    // User Orders Ends

    // User Vendor Send Message
    Route::post('/user/contact', 'User\MessageController@usercontact');
    Route::get('/messages', 'User\MessageController@messages')->name('user-messages');
    Route::get('/message/{id}', 'User\MessageController@message')->name('user-message');
    Route::post('/message/post', 'User\MessageController@postmessage')->name('user-message-post');
    Route::post('/message/vendor_post', 'Vendor\OrderController@postmessage')->name('vendor-message-post');
    Route::get('/message/{id}/delete', 'User\MessageController@messagedelete')->name('user-message-delete');
    Route::get('/message/{id}/dispute', 'User\MessageController@swap_dispute')->name('user-message-dispute');
    Route::get('/message/{id}/close', 'User\MessageController@swap_open')->name('user-message-close');
    Route::get('/message/load/{id}', 'User\MessageController@msgload')->name('user-vendor-message-load');
    // User Vendor Send Message Ends

    // User Admin Send Message


    // Tickets
    Route::get('admin/tickets', 'User\MessageController@adminmessages')->name('user-message-index');

    // User Logout
    Route::get('/logout', 'User\LoginController@logout')->name('user-logout');
    // User Logout Ends
});
// ************************************ USER SECTION ENDS**********************************************


// ************************************ VENDOR SECTION **********************************************
Route::prefix('vendor')->group(function() {
    Route::group(['middleware'=>'vendor'],function(){
         //------------ VENDOR ORDER SECTION ------------
        Route::get('/orders', 'Vendor\OrderController@index')->name('vendor-order-index');
        Route::get('/order/{id}/show', 'Vendor\OrderController@show')->name('vendor-order-show');
        Route::get('/order/{id}/message', 'Vendor\OrderController@message')->name('vendor-message-show');
        Route::get('/order/{id}/invoice', 'Vendor\OrderController@invoice')->name('vendor-order-invoice');
        Route::get('/order/{id}/print', 'Vendor\OrderController@printpage')->name('vendor-order-print');
        Route::get('/order/{id1}/status/{status}', 'Vendor\OrderController@status')->name('vendor-order-status');
        Route::post('/order/email/', 'Vendor\OrderController@emailsub')->name('vendor-order-emailsub');
        Route::post('/order/{slug}/license', 'Vendor\OrderController@license')->name('vendor-order-license');

        //------------ VENDOR SUBCATEGORY SECTION ------------
        Route::get('/load/subcategories/{id}/', 'Vendor\VendorController@subcatload')->name('vendor-subcat-load'); //JSON REQUEST
        //------------ VENDOR SUBCATEGORY SECTION ENDS------------

        //------------ VENDOR CHILDCATEGORY SECTION ------------
        Route::get('/load/childcategories/{id}/', 'Vendor\VendorController@childcatload')->name('vendor-childcat-load'); //JSON REQUEST
        //------------ VENDOR CHILDCATEGORY SECTION ENDS------------

        //------------ VENDOR PRODUCT SECTION ------------
        Route::get('/products/datatables', 'Vendor\ProductController@datatables')->name('vendor-prod-datatables'); //JSON REQUEST
        Route::get('/products', 'Vendor\ProductController@index')->name('vendor-prod-index');

        Route::post('/products/upload/update/{id}', 'Vendor\ProductController@uploadUpdate')->name('vendor-prod-upload-update');

        // CREATE SECTION
        Route::get('/products/types', 'Vendor\ProductController@types')->name('vendor-prod-types');
        Route::get('/products/physical/create', 'Vendor\ProductController@createPhysical')->name('vendor-prod-physical-create');
        Route::get('/products/digital/create', 'Vendor\ProductController@createDigital')->name('vendor-prod-digital-create');
        Route::get('/products/license/create', 'Vendor\ProductController@createLicense')->name('vendor-prod-license-create');
        Route::post('/products/store', 'Vendor\ProductController@store')->name('vendor-prod-store');
        Route::get('/getattributes', 'Vendor\ProductController@getAttributes')->name('vendor-prod-getattributes');
        Route::get('/products/import', 'Vendor\ProductController@import')->name('vendor-prod-import');
        Route::post('/products/import-submit', 'Vendor\ProductController@importSubmit')->name('vendor-prod-importsubmit');

        Route::get('/products/catalog/datatables', 'Vendor\ProductController@catalogdatatables')->name('admin-vendor-catalog-datatables');
        Route::get('/products/catalogs', 'Vendor\ProductController@catalogs')->name('admin-vendor-catalog-index');
        // CREATE SECTION

        // EDIT SECTION
        Route::get('/products/edit/{id}', 'Vendor\ProductController@edit')->name('vendor-prod-edit');
        Route::post('/products/edit/{id}', 'Vendor\ProductController@update')->name('vendor-prod-update');

        Route::get('/products/catalog/{id}', 'Vendor\ProductController@catalogedit')->name('vendor-prod-catalog-edit');
        Route::post('/products/catalog/{id}', 'Vendor\ProductController@catalogupdate')->name('vendor-prod-catalog-update');
        // EDIT SECTION ENDS

        // STATUS SECTION
        Route::get('/products/status/{id1}/{id2}', 'Vendor\ProductController@status')->name('vendor-prod-status');
        // STATUS SECTION ENDS

        // DELETE SECTION
        Route::get('/products/delete/{id}', 'Vendor\ProductController@destroy')->name('vendor-prod-delete');
        // DELETE SECTION ENDS

        //------------ VENDOR GALLERY SECTION ------------
        Route::get('/gallery/show', 'Vendor\GalleryController@show')->name('vendor-gallery-show');
        Route::post('/gallery/store', 'Vendor\GalleryController@store')->name('vendor-gallery-store');
        Route::get('/gallery/delete', 'Vendor\GalleryController@destroy')->name('vendor-gallery-delete');
        //------------ VENDOR GALLERY SECTION ENDS------------

        //------------ VENDOR SHIPPING ------------
        Route::get('/shipping/datatables', 'Vendor\ShippingController@datatables')->name('vendor-shipping-datatables');
        Route::get('/shipping', 'Vendor\ShippingController@index')->name('vendor-shipping-index');
        Route::get('/shipping/create', 'Vendor\ShippingController@create')->name('vendor-shipping-create');
        Route::post('/shipping/create', 'Vendor\ShippingController@store')->name('vendor-shipping-store');
        Route::get('/shipping/edit/{id}', 'Vendor\ShippingController@edit')->name('vendor-shipping-edit');
        Route::post('/shipping/edit/{id}', 'Vendor\ShippingController@update')->name('vendor-shipping-update');
        Route::get('/shipping/delete/{id}', 'Vendor\ShippingController@destroy')->name('vendor-shipping-delete');
        //------------ VENDOR SHIPPING ENDS ------------


         //------------ VENDOR NOTIFICATION SECTION ------------
        Route::get('/order/notf/show/{id}', 'Vendor\NotificationController@order_notf_show')->name('vendor-order-notf-show');
        Route::get('/user/notf/show/{id}', 'User\NotificationController@order_notf_show')->name('user-order-notf-show');

        Route::get('/order/notf/count/{id}','Vendor\NotificationController@order_notf_count')->name('vendor-order-notf-count');
        Route::get('/user/notf/count/{id}','User\NotificationController@order_notf_count')->name('user-order-notf-count');

        Route::get('/order/notf/clear/{id}','Vendor\NotificationController@order_notf_clear')->name('vendor-order-notf-clear');
        Route::get('/user/notf/clear/{id}','User\NotificationController@order_notf_clear')->name('user-order-notf-clear');
        //------------ VENDOR NOTIFICATION SECTION ENDS ------------

        // Vendor Profile
        Route::get('/profile', 'Vendor\VendorController@profile')->name('vendor-profile');
        Route::post('/profile', 'Vendor\VendorController@profileupdate')->name('vendor-profile-update');
        // Vendor Profile Ends

        // Vendor Shipping Cost
        Route::get('/shipping-cost', 'Vendor\VendorController@ship')->name('vendor-shop-ship');

        // Vendor Shipping Cost
        Route::get('/banner', 'Vendor\VendorController@banner')->name('vendor-banner');

        Route::get('/withdraw/datatables', 'Vendor\WithdrawController@datatables')->name('vendor-wt-datatables');
        Route::get('/withdraw', 'Vendor\WithdrawController@index')->name('vendor-wt-index');
        Route::get('/withdraw/create', 'Vendor\WithdrawController@create')->name('vendor-wt-create');
        Route::post('/withdraw/create', 'Vendor\WithdrawController@store')->name('vendor-wt-store');


    });
});
// ************************************ VENDOR SECTION ENDS**********************************************



// ************************************ FRONT SECTION **********************************************

// PRODCT AUTO SEARCH SECTION
Route::get('/autosearch/product/{slug}','Front\FrontendController@autosearch');
// PRODCT AUTO SEARCH SECTION ENDS

// CATEGORY SECTION
Route::get('/category/{category?}/{subcategory?}/{childcategory?}','Front\CatalogController@category')->name('front.category');
Route::get('/category/{slug1}/{slug2}','Front\CatalogController@subcategory')->name('front.subcat');
Route::get('/category/{slug1}/{slug2}/{slug3}','Front\CatalogController@childcategory')->name('front.childcat');
Route::get('/categories/','Front\CatalogController@categories')->name('front.categories');
Route::get('/childcategories/{slug}', 'Front\CatalogController@childcategories')->name('front.childcategories');
// CATEGORY SECTION ENDS

// PRODCT SECTION
Route::get('/item/{slug}','Front\CatalogController@product')->name('front.product');
Route::get('/afbuy/{slug}','Front\CatalogController@affProductRedirect')->name('affiliate.product');
Route::get('/item/quick/view/{id}/','Front\CatalogController@quick')->name('product.quick');
Route::post('/item/review','Front\CatalogController@reviewsubmit')->name('front.review.submit');
Route::get('/item/view/review/{id}','Front\CatalogController@reviews')->name('front.reviews');
// PRODCT SECTION ENDS

// COMMENT SECTION
Route::post('/item/comment/store', 'Front\CatalogController@comment')->name('product.comment');
Route::post('/item/comment/edit/{id}', 'Front\CatalogController@commentedit')->name('product.comment.edit');
Route::get('/item/comment/delete/{id}', 'Front\CatalogController@commentdelete')->name('product.comment.delete');
// COMMENT SECTION ENDS

// REPLY SECTION
Route::post('/item/reply/{id}', 'Front\CatalogController@reply')->name('product.reply');
Route::post('/item/reply/edit/{id}', 'Front\CatalogController@replyedit')->name('product.reply.edit');
Route::get('/item/reply/delete/{id}', 'Front\CatalogController@replydelete')->name('product.reply.delete');
// REPLY SECTION ENDS

// CART SECTION
Route::get('/carts/updatecart','Front\CartController@updatecart');
Route::get('/carts/view','Front\CartController@cartview');
Route::get('/carts/','Front\CartController@cart')->name('front.cart');
Route::get('/addcart/{id}','Front\CartController@addcart')->name('product.cart.add');
Route::get('/addtocart/{id}','Front\CartController@addtocart')->name('product.cart.quickadd');
Route::get('/addnumcart','Front\CartController@addnumcart');
Route::get('/addbyone','Front\CartController@addbyone');
Route::get('/reducebyone','Front\CartController@reducebyone');
Route::get('/upcolor','Front\CartController@upcolor');
Route::get('/removecart/{id}','Front\CartController@removecart')->name('product.cart.remove');
Route::get('/carts/coupon','Front\CartController@coupon');
Route::get('/carts/coupon/check','Front\CartController@couponcheck');
// CART SECTION ENDS

// CHECKOUT SECTION
Route::get('/checkout/','Front\CheckoutController@checkout')->name('front.checkout');
Route::get('/checkout/payment/{slug1}/{slug2}','Front\CheckoutController@loadpayment')->name('front.load.payment');
Route::get('/order/track/{id}','Front\FrontendController@trackload')->name('front.track.search');
Route::get('/checkout/payment/return', 'Front\PaymentController@payreturn')->name('payment.return');
Route::get('/checkout/payment/cancle', 'Front\PaymentController@paycancle')->name('payment.cancle');
Route::post('/checkout/payment/notify', 'Front\PaymentController@notify')->name('payment.notify');
Route::get('/checkout/instamojo/notify', 'Front\InstamojoController@notify')->name('instamojo.notify');

Route::post('/paystack/submit', 'Front\PaystackController@store')->name('paystack.submit');
Route::post('/instamojo/submit', 'Front\InstamojoController@store')->name('instamojo.submit');
Route::post('/paypal-submit', 'Front\PaymentController@store')->name('paypal.submit');
Route::post('/stripe-submit', 'Front\StripeController@store')->name('stripe.submit');
Route::post('/steem-submit', 'Front\SteemController@store')->name('steem.submit');
Route::post('/steem-login-submit', 'Front\SteemLoginController@store')->name('steemlogin.submit');

// Steem Transaction
Route::get('/transaction/','Front\TransactionController@transact')->name('steem.transaction');
Route::get('/subscription_payment/','User\UserController@transact')->name('user-subscription-payment');
Route::get('/subscription_payment/{id}/remove','User\UserController@remove_transaction')->name('remove-subscription-payment');
