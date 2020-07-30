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

// ************************************ ADMIN SECTION **********************************************
Route::prefix('admin')->group(function() {
    Route::post('/login', 'Admin\LoginController@api_login');
    
    
    Route::group(['middleware'=>'auth:admin-api'],function(){
        Route::get('details',  function (Request $request) {
            return $request->user();
        });

        Route::get('make_vendor',  'Admin\LoginController@make_vendor');
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

        #buy product


    });

});
// ************************************ USER SECTION ENDS**********************************************




// ************************************ VENDOR SECTION **********************************************
Route::prefix('vendor')->group(function() {

    #this is enough because we send user or vendor while logging in. Frontend dosen't sends unnecessary request.
    Route::group(['middleware'=>'auth:api'],function(){
        //------------ VENDOR PRODUCT SECTION ------------

        #get categories and child categories
        Route::post('/products/store', 'Vendor\ProductController@store');
        Route::post('/products/edit/{id}', 'Vendor\ProductController@update');
        Route::get('/products/delete/{id}', 'Vendor\ProductController@destroy');
        //------------ VENDOR PRODUCT SECTION ENDS------------

    });
});
// ************************************ VENDOR SECTION ENDS**********************************************

#get product details
#cart, wishlist