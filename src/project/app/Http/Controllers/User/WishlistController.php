<?php

namespace App\Http\Controllers\User;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Models\Wishlist;
use App\Models\Product;
use App\Models\ApiCart;
use App\Models\User;
use Auth;

class WishlistController extends Controller
{
    public function __construct()
    {
        $this->middleware('auth');
    }

    public function wishlists(Request $request)
    {
        $sort = '';
        $user = Auth::guard('web')->user();

        // Search By Sort

        if(!empty($request->sort))
        {
        $sort = $request->sort;
        $wishes = Wishlist::where('user_id','=',$user->id)->pluck('product_id');
        if($sort == "date_desc")
        {
        $wishlists = Product::where('status','=',1)->whereIn('id',$wishes)->orderBy('id','desc')->paginate(8);
        }
        else if($sort == "date_asc")
        {
        $wishlists = Product::where('status','=',1)->whereIn('id',$wishes)->paginate(8);
        }
        else if($sort == "price_asc")
        {
        $wishlists = Product::where('status','=',1)->whereIn('id',$wishes)->orderBy('price','asc')->paginate(8);
        }
        else if($sort == "price_desc")
        {
        $wishlists = Product::where('status','=',1)->whereIn('id',$wishes)->orderBy('price','desc')->paginate(8);
        }
        if($request->ajax())
        {
            return view('front.pagination.wishlist',compact('user','wishlists','sort'));
        }
        return view('user.wishlist',compact('user','wishlists','sort'));
        }


        $wishlists = Wishlist::where('user_id','=',$user->id)->paginate(8);
        if($request->ajax())
        {
            return view('front.pagination.wishlist',compact('user','wishlists','sort'));
        }
        return view('user.wishlist',compact('user','wishlists','sort'));
    }

    public function wishlists_api(Request $request)
    {
        $sort = '';
        $user = $request->user();
        try {
            $wishlists = Wishlist::where('wishlists.user_id','=',$user->id)->leftJoin('products', 'wishlists.product_id', '=', 'products.id')->get();
            return response()->json(['status' => 'success', 'details' => $wishlists]);
        } catch (\Exception $e) {

            return $e->getMessage();
        }
    }

    public function modify_api(Request $request)
    {
        $user = $request->user();

        try {

        if($request->photo) 
        {      

            $image = base64_decode($request->photo);
            $image_name = time().str_random(8).'.png';
            $path = 'assets/images/users/'.$image_name;
            file_put_contents($path, $image);
                        
            $request['photo'] = $image_name;
        }

        

            
        $required = $request->except(['api_token']);
        if (isset($required['password']))
        {
            $required['password'] = bcrypt($required['password']);
        }
        
        $apiCart = User::where('id', '=',$user->id)->update($required);
        return response()->json(['status' => 'success', 'details' => "User Updated"]);
        } catch (\Exception $e) {

            return $e->getMessage();
        }
    }

    public function cart_api(Request $request)
    {
        $sort = '';
        $user = $request->user();
        try {
            $carts = ApiCart::where('api_carts.user_id','=',$user->id)->leftJoin('products', 'api_carts.product_id', '=', 'products.id')->get();
            return response()->json(['status' => 'success', 'details' => $carts]);
        } catch (\Exception $e) {

            return $e->getMessage();
        }
    }


    public function addwish($id)
    {
        $user = Auth::guard('web')->user();
        $data[0] = 0;
        $ck = Wishlist::where('user_id','=',$user->id)->where('product_id','=',$id)->get()->count();
        if($ck > 0)
        {
            return response()->json($data);
        }
        $wish = new Wishlist();
        $wish->user_id = $user->id;
        $wish->product_id = $id;
        $wish->save();
        $data[0] = 1;
        $data[1] = count($user->wishlists);
        return response()->json($data);
    }

    public function addwish_api(Request $request, $id)
    {
        $user = $request->user();
        $data[0] = 0;
        $ck = Wishlist::where('user_id','=',$user->id)->where('product_id','=',$id)->get()->count();
        if($ck > 0)
        {
            return response()->json(['status' => 'failure', 'details' => "Already in wishlist"]);
        }
        $wish = new Wishlist();
        $wish->user_id = $user->id;
        $wish->product_id = $id;
        $wish->save();
        $data[0] = 1;
        $data[1] = count($user->wishlists);
        return response()->json(['status' => 'success', 'details' => "Added to wishlist",]);
    }

    public function addcart_api(Request $request)
    {
        try{
        $user = $request->user();
        $required = $request->except(['api_token']);
        $required['user_id'] = $user->id;
        
        $apiCart = new ApiCart;
        $apiCart->fill($required);
        $apiCart->save();


        return response()->json(['status' => 'success', 'details' => "Added to cart", 'id'=>$apiCart->id]);


        }  catch (\Exception $e) {
            return response()->json(['status' => 'failure', 'details' => $e->getMessage()]);
        }
    }




    public function removewish($id)
    {
        $user = Auth::guard('web')->user();
        $wish = Wishlist::findOrFail($id);
        $wish->delete();
        $data[0] = 1;
        $data[1] = count($user->wishlists);
        return response()->json($data);
    }

    public function removecart_api(Request $request)
    {
        try{
            $user = $request->user();
            $required = $request->except(['api_token']);
            $required['user_id'] = $user->id;
            
            $apiCart = ApiCart::where('product_id', '=',$required['product_id'])->where('size', '=',$required['size'])->where('color', '=',$required['size'])->where('user_id', '=',$required['user_id'])->delete();
    
            return response()->json(['status' => 'success', 'details' => "Remove from cart"]);
    
    
            }  catch (\Exception $e) {
                return response()->json(['status' => 'failure', 'details' => $e->getMessage()]);
        }
    }

    public function modifyqty_api(Request $request)
    {
        try{
        $user = $request->user();
        $required = $request->except(['api_token']);
        $required['user_id'] = $user->id;

        $apiCart = ApiCart::where('product_id', '=',$required['product_id'])->where('size', '=',$required['size'])->where('color', '=',$required['size'])->where('user_id', '=',$required['user_id'])->update(['qty' => $required['qty']]);
        return response()->json(['status' => 'success', 'details' => "Updated quantity"]);

        }  catch (\Exception $e) {
        return response()->json(['status' => 'failure', 'details' => $e->getMessage()]);
        }
    }

    public function removewish_api(Request $request, $id)
    {
        $user = $request->user();
        $prod_id = $id;
        $wish = Wishlist::where('product_id', '=', $prod_id)->delete();
        return response()->json(['status' => 'success', 'details' => "Removed from wishlist"]);
    }

}
