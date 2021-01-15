<?php

namespace App\Http\Controllers\User;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Models\Wishlist;
use App\Models\Product;
use App\Models\ApiCart;
use App\Models\User;
use Auth;

use App\Classes\GeniusMailer;
use App\Models\Cart;
use App\Models\Conversation;
use App\Models\Coupon;
use App\Models\Currency;
use App\Models\Generalsetting;
use App\Models\Message;
use App\Models\Notification;
use App\Models\Order;
use App\Models\OrderTrack;
use App\Models\PaymentGateway;
use App\Models\Pickup;
use App\Models\UserNotification;
use App\Models\VendorOrder;
use App\Models\VendorNotification;
use DB;
use Session;
use Validator;
use Log;
use Carbon\Carbon;

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
        $required = $request->except(['api_token', 'photo']);
        $response = ['status' => 'success', 'details' => "User Updated"];
        

        if (isset($request->all()['photo']))
        {
            $image = $request->all()['photo'];
            $image = substr($image, strpos($image, ",")+1);

            $decoded = base64_decode($image);
            $image_name = 'user_' .time().str_random(8).'.png';
            $path = 'assets/images/users/'.$image_name;
            file_put_contents($path, $decoded);
            $required['photo'] = $image_name;
            $response = ['status' => 'success', 'details' => "User Updated", 'image' => $image_name];
        }
        

        if (isset($required['password']))
        {
            $required['password'] = bcrypt($required['password']);
        }
        
        $apiCart = User::where('id', '=',$user->id)->update($required);
        return response()->json($response);

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

        try
        {

            $currentCart = ApiCart::where('user_id', '=', $user->id)->get();
            $prev_prod = Product::where('id', '=', $currentCart[0]->product_id)->first();
            $curr_prod = Product::where('id', '=', $request->product_id)->first();

            if ($prev_prod->user_id != $curr_prod->user_id)
            {
                return response()->json(['status' => 'failure', 'details' => "Different vendor"]);
            }
        }  catch (\Exception $e) {
            
        }
        
        
        $apiCart = new ApiCart;
        $apiCart->fill($required);
        $apiCart->save();


        return response()->json(['status' => 'success', 'details' => "Added to cart", 'id'=>$apiCart->id]);


        }  catch (\Exception $e) {
            return response()->json(['status' => 'failure', 'details' => $e->getMessage()]);
        }
    }

    


    public function buynow_api(Request $request)
    {
        $this->addcart_api($request);

        try{
            $gs = Generalsetting::findOrFail(1);
            $dp = 1;
            $vendor_shipping_id = 0;
            $vendor_packing_id = 0;
            $curr = Currency::where('is_default','=',1)->first();
            $user = $request->user();


            $prods = ApiCart::where('user_id', '=', $user->id)->get();

            $vendor_id = -1;

            foreach($prods as $prod)
            {
                if ($prod->id != null)
                {
                    $vendor_id = $prod->user_id;
                    break;
                }
            }

            if ($vendor_id != -1)
            {
                $gateways =  PaymentGateway::where([['status','=',1], ['user_id', '=', $vendor_id]])->get();
            
                // Shipping Method
                $user = Auth::user();
                
                $cash_on_delivery = 1;
                if ($user->reported_times > $gs->cash_only_limit)
                {
                    $cash_on_delivery = 0;
                }

                $vendor = User::where('id', '=', $vendor_id)->first();
                
                $distance = 1;
                // $distance = haversineGreatCircleDistance($vendor->latitude, $vendor->longitude, $user->latitude, $user->longitude);

                $shipping_data  = DB::table('shippings')->first();

                if(count($gateways) == 0)
                {
                    $gateways =  PaymentGateway::where([['status','=',1], ['user_id', '=', 0]])->get();
                }

                $total = 0;


                $cart = ApiCart::where('user_id', '=', $user->id)->get();
                foreach ($cart as $item) 
                {
                    $total = $total + ($item->qty * $item->price); #removed coupon
                }


                $shipping_price = $shipping_data->price;

                if ($distance > $shipping_data->threshold)
                {
                    $shipping_price = $shipping_data->long_price;
                }
            
                if ($total > $shipping_data->free_threshold)
                {
                    $shipping_price = 0;
                }

                return response()->json(['status' => 'success', 'payment_methods' => $gateways, 'shipping_price'=>$shipping_price, 'total_without_shipping'=>$total, 'cash_on_delivery'=>$cash_on_delivery]);
            }
            else
            {
                return response()->json(['status' => 'failure', 'details' => "Vendor not found"]);
            }
            
        }  catch (\Exception $e) {
            return response()->json(['status' => 'failure', 'details' => $e->getMessage(), 'line_number' =>$e->getLine()]);
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
