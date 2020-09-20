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


// ************************************ PUBLIC SECTION **********************************************


#get categories

Route::get('/categories', 'Front\FrontendController@get_categories_api');
Route::get('/categories_with_sub', 'Front\FrontendController@get_categories_with_sub_api');
Route::get('/subcategories', 'Front\FrontendController@get_subcategories_api');
Route::get('/childcategories', 'Front\FrontendController@get_childcategories_api');
Route::get('/advertisement', 'Front\FrontendController@get_banner');
Route::get('/slider', 'Front\FrontendController@get_slider');


Route::get('/category/{id}', 'Front\FrontendController@get_product_by_category_api'); #8

#get products and details
Route::get('/premium_products', 'Front\FrontendController@premium_products_api');
Route::get('/featured_products', 'Front\FrontendController@featured_products_api');

Route::get('/products', 'Front\FrontendController@get_products_api');
Route::get('/product/{id}', 'Front\FrontendController@get_product_detail_api');
Route::get('/product_cat_sub', 'Front\FrontendController@get_product_by_category_sub_cat_api');
Route::get('/product_cat_sub_child', 'Front\FrontendController@get_product_by_category_sub_cat_child_api');



#Cart
// Route::group(['middleware'=>'web'],function(){
//     Route::get('/cart', 'Front\CartController@get_cart');
//     Route::get('/cart/add/{id}', 'Front\CartController@addcart');
//     Route::get('/cart/addbyone', 'Front\CartController@addbyone');
//     Route::get('/cart/reducebyone', 'Front\CartController@reducebyone');
//     Route::get('/cart/remove/{id}', 'Front\CartController@removecart');
// });


#also add by 1 and reduce by 1

// ************************************ PUBLIC SECTION ENDS**********************************************

// ************************************ ADMIN SECTION **********************************************
Route::prefix('admin')->group(function() {
    Route::post('/login', 'Admin\LoginController@api_login');
    
    
    Route::group(['middleware'=>'auth:admin-api'],function(){
        Route::get('details',  function (Request $request) {
            return $request->user();
        });

        

        Route::post('make_vendor',  'Admin\LoginController@make_vendor');

        #category
        Route::post('/category/create', 'Admin\CategoryController@store');
        Route::post('/category/edit/{id}', 'Admin\CategoryController@update');
        Route::get('/category/delete/{id}', 'Admin\CategoryController@destroy');
        Route::get('/category/status/{id1}/{id2}', 'Admin\CategoryController@status');

        #subcategory
        Route::post('/subcategory/create', 'Admin\SubCategoryController@store');
        Route::post('/subcategory/edit/{id}', 'Admin\SubCategoryController@update');
        Route::get('/subcategory/delete/{id}', 'Admin\SubCategoryController@destroy');
        Route::get('/subcategory/status/{id1}/{id2}', 'Admin\SubCategoryController@status');


        #childcategory
        Route::post('/childcategory/create', 'Admin\ChildCategoryController@store');
        Route::post('/childcategory/edit/{id}', 'Admin\ChildCategoryController@update');
        Route::get('/childcategory/delete/{id}', 'Admin\ChildCategoryController@destroy');
        Route::get('/childcategory/status/{id1}/{id2}', 'Admin\ChildCategoryController@status');

    });
});
// ************************************ ADMIN SECTION ENDS**********************************************



// ************************************ USER SECTION **********************************************
Route::prefix('user')->group(function() {
    Route::post('register', 'User\RegisterController@api_register');
    Route::post('login',  'User\LoginController@api_login');

    Route::group(['middleware'=>'auth:api'],function(){
        
        Route::get('details',  function (Request $request) {
            return $request->user();
        });

        Route::get('/modify','User\WishlistController@modify_api');

        //Wishlist
        Route::get('/wishlists','User\WishlistController@wishlists_api');
        Route::get('/wishlist/add/{id}','User\WishlistController@addwish_api');
        Route::get('/wishlist/remove/{id}','User\WishlistController@removewish_api');

        //Cart
        Route::get('/cart','User\WishlistController@cart_api');
        Route::get('/cart/add','User\WishlistController@addcart_api');
        Route::get('/cart/remove','User\WishlistController@removecart_api');
        Route::get('/cart/modifyqty', 'User\WishlistController@modifyqty_api');

        Route::get('/checkout','Front\CheckoutController@checkout_api');

    });

});
// ************************************ USER SECTION ENDS**********************************************




// ************************************ VENDOR SECTION **********************************************
Route::prefix('vendor')->group(function() {

    #this is enough because we send user or vendor while logging in. Frontend dosen't sends unnecessary request.
    Route::group(['middleware'=>'auth:api'],function(){
        //------------ VENDOR PRODUCT SECTION ------------
        Route::post('/products/store', 'Vendor\ProductController@store');
        Route::post('/products/edit/{id}', 'Vendor\ProductController@update');
        Route::get('/products/delete/{id}', 'Vendor\ProductController@destroy');
        //------------ VENDOR PRODUCT SECTION ENDS------------

    });
});
// ************************************ VENDOR SECTION ENDS**********************************************