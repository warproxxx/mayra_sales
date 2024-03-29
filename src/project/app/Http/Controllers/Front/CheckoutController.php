<?php

namespace App\Http\Controllers\Front;

use App\Classes\GeniusMailer;
use App\Http\Controllers\Controller;
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
use App\Models\Product;
use App\Models\User;
use App\Models\UserNotification;
use App\Models\VendorOrder;
use App\Models\VendorNotification;
use App\Models\ApiCart;
use Auth;
use DB;
use Illuminate\Http\Request;
use Session;
use Validator;
use Log;
use Carbon\Carbon;

function haversineGreatCircleDistance(
    $latitudeFrom, $longitudeFrom, $latitudeTo, $longitudeTo, $earthRadius = 6371)
  {
    // convert from degrees to radians
    $latFrom = deg2rad($latitudeFrom);
    $lonFrom = deg2rad($longitudeFrom);
    $latTo = deg2rad($latitudeTo);
    $lonTo = deg2rad($longitudeTo);
  
    $latDelta = $latTo - $latFrom;
    $lonDelta = $lonTo - $lonFrom;
  
    $angle = 2 * asin(sqrt(pow(sin($latDelta / 2), 2) +
      cos($latFrom) * cos($latTo) * pow(sin($lonDelta / 2), 2)));
    return $angle * $earthRadius;
  }

class CheckoutController extends Controller
{
    public function loadpayment($slug1,$slug2)
    {
        if (Session::has('currency')) {
            $curr = Currency::find(Session::get('currency'));
        }
        else {
            $curr = Currency::where('is_default','=',1)->first();
        }
        $payment = $slug1;
        $pay_id = $slug2;
        $gateway = '';
        if($pay_id != 0) {
            $gateway = PaymentGateway::findOrFail($pay_id);
        }
        return view('load.payment',compact('payment','pay_id','gateway','curr'));
    }

    public function checkout()
    {
        $this->code_image();
        if (!Session::has('cart')) {
            return redirect()->route('front.cart')->with('success',"You don't have any product to checkout.");
        }
        $gs = Generalsetting::findOrFail(1);
        $dp = 1;
        $vendor_shipping_id = 0;
        $vendor_packing_id = 0;
            if (Session::has('currency')) 
            {
              $curr = Currency::find(Session::get('currency'));
            }
            else
            {
                $curr = Currency::where('is_default','=',1)->first();
            }

// If a user is Authenticated then there is no problm user can go for checkout

        if(Auth::guard('web')->check())
        {
            $oldCart = Session::get('cart');
            $cart = new Cart($oldCart);

            $vendor_id = 0;

            foreach ($cart->items as $prod) {
                $vendor_id = $prod['item']['user_id'];
                break;
            }

                $gateways =  PaymentGateway::where([['status','=',1], ['user_id', '=', $vendor_id]])->get();
                $pickups = Pickup::all();
                
                $products = $cart->items;
                    
                // Shipping Method
                $user = Auth::user();
                
                $dont_show = 0;
                if ($user->reported_times > $gs->cash_only_limit)
                {
                    $dont_show = 1;
                }

                $vendor = User::where('id', '=', $vendor_id)->first();

                // $distance = haversineGreatCircleDistance($vendor->latitude, $vendor->longitude, $user->latitude, $user->longitude);
                $distance = 1;

                if($gs->multiple_shipping == 1)
                {                        
                    $user = null;
                    foreach ($cart->items as $prod) {
                            $user[] = $prod['item']['user_id'];
                    }
                    $users = array_unique($user);
                    if(count($users) == 1)
                    {

                        $shipping_data  = DB::table('shippings')->where('user_id','=',$users[0])->get();
                        if(count($shipping_data) == 0){
                            $shipping_data  = DB::table('shippings')->where('user_id','=',0)->first();
                        }
                        else{
                            $shipping_data  = DB::table('shippings')->where('user_id','=',$users[0])->first();
                        }
                    }
                    else {
                        $shipping_data  = DB::table('shippings')->where('user_id','=',0)->first();
                    }

                }
                else{
                $shipping_data  = DB::table('shippings')->where('user_id','=',0)->first();
                }

                if ($distance > $shipping_data->threshold)
                {
                    $shipping_data->price = $shipping_data->long_price;
                }



                // Packaging

                if($gs->multiple_packaging == 1)
                {
                    $user = null;
                    foreach ($cart->items as $prod) {
                            $user[] = $prod['item']['user_id'];
                    }
                    $users = array_unique($user);
                    if(count($users) == 1)
                    {
                        $package_data  = DB::table('packages')->where('user_id','=',$users[0])->get();
                        if(count($package_data) == 0){
                            $package_data  = DB::table('packages')->where('user_id','=',0)->get();
                        }
                        else{
                            $vendor_packing_id = $users[0];
                        }
                    }
                    else {
                        $package_data  = DB::table('packages')->where('user_id','=',0)->get();
                    }

                }
                else{
                $package_data  = DB::table('packages')->where('user_id','=',0)->get();
                }


                foreach ($products as $prod) {
                    if($prod['item']['type'] == 'Physical')
                    {
                        $dp = 0;
                        break;
                    }
                }
                if($dp == 1)
                {
                $ship  = 0;                    
                }
                $total = $cart->totalPrice;
                $coupon = Session::has('coupon') ? Session::get('coupon') : 0;
                if($gs->tax != 0)
                {
                    $tax = ($total / 100) * $gs->tax;
                    $total = $total + $tax;
                }
                if(!Session::has('coupon_total'))
                {
                $total = $total - $coupon;     
                $total = $total + 0;               
                }
                else {
                $total = Session::get('coupon_total');  
                $total = $total + round(0 * $curr->value, 2); 
                }
        
        if ($total > $shipping_data->free_threshold)
        {
            $shipping_data->price = 0;
        }

        $today = Carbon::now()->format('Y-m-d');

        return view('front.checkout', ['products' => $cart->items, 'totalPrice' => $total, 'pickups' => $pickups, 'totalQty' => $cart->totalQty, 'gateways' => $gateways, 'shipping_cost' => 0, 'digital' => $dp, 'curr' => $curr,'shipping_data' => $shipping_data,'package_data' => $package_data, 'vendor_shipping_id' => $vendor_shipping_id, 'vendor_packing_id' => $vendor_packing_id, 'today' => $today, 'dont_show' => $dont_show]);             
        }
        else
        {
// If guest checkout is activated then user can go for checkout
           	if($gs->guest_checkout == 1)
              {
                $pickups = Pickup::all();
                $oldCart = Session::get('cart');
                $cart = new Cart($oldCart);
                $products = $cart->items;
                
                $vendor_id = 0;

                foreach ($cart->items as $prod) {
                    $vendor_id = $prod['item']['user_id'];
                    break;
                }
    
                $gateways =  PaymentGateway::where([['status','=',1], ['user_id', '=', $vendor_id]])->get();

                

                // Shipping Method

                if($gs->multiple_shipping == 1)
                {                        
                    $user = null;
                    foreach ($cart->items as $prod) {
                            $user[] = $prod['item']['user_id'];
                    }
                    $users = array_unique($user);
                    if(count($users) == 1)
                    {

                        $shipping_data  = DB::table('shippings')->where('user_id','=',$users[0])->get();
                        if(count($shipping_data) == 0){
                            $shipping_data  = DB::table('shippings')->where('user_id','=',0)->first();
                        }
                        else{
                            $shipping_data  = DB::table('shippings')->where('user_id','=',$users[0])->first();
                        }
                    }
                    else {
                        $shipping_data  = DB::table('shippings')->where('user_id','=',0)->first();
                    }

                }
                else{
                $shipping_data  = DB::table('shippings')->where('user_id','=',0)->first();
                }

                // Packaging

                if($gs->multiple_packaging == 1)
                {
                    $user = null;
                    foreach ($cart->items as $prod) {
                            $user[] = $prod['item']['user_id'];
                    }
                    $users = array_unique($user);
                    if(count($users) == 1)
                    {
                        $package_data  = DB::table('packages')->where('user_id','=',$users[0])->get();

                        if(count($package_data) == 0){
                            $package_data  = DB::table('packages')->where('user_id','=',0)->get();
                        }
                        else{
                            $vendor_packing_id = $users[0];
                        }  
                    }
                    else {
                        $package_data  = DB::table('packages')->where('user_id','=',0)->get();
                    }

                }
                else{
                $package_data  = DB::table('packages')->where('user_id','=',0)->get();
                }


                foreach ($products as $prod) {
                    if($prod['item']['type'] == 'Physical')
                    {
                        $dp = 0;
                        break;
                    }
                }
                if($dp == 1)
                {
                $ship  = 0;                    
                }
                $total = $cart->totalPrice;
                $coupon = Session::has('coupon') ? Session::get('coupon') : 0;
                if($gs->tax != 0)
                {
                    $tax = ($total / 100) * $gs->tax;
                    $total = $total + $tax;
                }
                if(!Session::has('coupon_total'))
                {
                $total = $total - $coupon;     
                $total = $total + 0;               
                }
                else {
                $total = Session::get('coupon_total');  
                $total =  str_replace($curr->sign,'',$total) + round(0 * $curr->value, 2); 
                }
                foreach ($products as $prod) {
                    if($prod['item']['type'] != 'Physical')
                    {
                        if(!Auth::guard('web')->check())
                        {
                $ck = 1;

                if ($total > $shipping_data->free_threshold)
                {
                    $shipping_data->price = 0;
                }

                $dont_show = 0;

                $today = Carbon::now()->format('Y-m-d');
        return view('front.checkout', ['products' => $cart->items, 'totalPrice' => $total, 'pickups' => $pickups, 'totalQty' => $cart->totalQty, 'gateways' => $gateways, 'shipping_cost' => 0, 'checked' => $ck, 'digital' => $dp, 'curr' => $curr,'shipping_data' => $shipping_data,'package_data' => $package_data, 'vendor_shipping_id' => $vendor_shipping_id, 'vendor_packing_id' => $vendor_packing_id, 'today' => $today, 'dont_show' =>$dont_show]);  
                        }
                    }
                }

                if ($total > $shipping_data->free_threshold)
                {
                    $shipping_data->price = 0;
                }
                $dont_show = 0;
                $today = Carbon::now()->format('Y-m-d');
        return view('front.checkout', ['products' => $cart->items, 'totalPrice' => $total, 'pickups' => $pickups, 'totalQty' => $cart->totalQty, 'gateways' => $gateways, 'shipping_cost' => 0, 'digital' => $dp, 'curr' => $curr,'shipping_data' => $shipping_data,'package_data' => $package_data, 'vendor_shipping_id' => $vendor_shipping_id, 'vendor_packing_id' => $vendor_packing_id, 'today' => $today, 'dont_show' =>$dont_show]);                 
               }

// If guest checkout is Deactivated then display pop up form with proper error message

                    else{
                $gateways =  PaymentGateway::where('status','=',1)->get();
                $pickups = Pickup::all();
                $oldCart = Session::get('cart');
                $cart = new Cart($oldCart);
                $products = $cart->items;

                // Shipping Method

                if($gs->multiple_shipping == 1)
                {                        
                    $user = null;
                    foreach ($cart->items as $prod) {
                            $user[] = $prod['item']['user_id'];
                    }
                    $users = array_unique($user);
                    if(count($users) == 1)
                    {

                        $shipping_data  = DB::table('shippings')->where('user_id','=',$users[0])->get();
                        if(count($shipping_data) == 0){
                            $shipping_data  = DB::table('shippings')->where('user_id','=',0)->first();
                        }
                        else{
                            $shipping_data  = DB::table('shippings')->where('user_id','=',$users[0])->first();
                        }
                    }
                    else {
                        $shipping_data  = DB::table('shippings')->where('user_id','=',0)->first();
                    }

                }
                else{
                $shipping_data  = DB::table('shippings')->where('user_id','=',0)->first();
                }

                // Packaging

                if($gs->multiple_packaging == 1)
                {
                    $user = null;
                    foreach ($cart->items as $prod) {
                            $user[] = $prod['item']['user_id'];
                    }
                    $users = array_unique($user);
                    if(count($users) == 1)
                    {
                        $package_data  = DB::table('packages')->where('user_id','=',$users[0])->get();

                        if(count($package_data) == 0){
                            $package_data  = DB::table('packages')->where('user_id','=',0)->get();
                        }
                        else{
                            $vendor_packing_id = $users[0];
                        }  
                    }
                    else {
                        $package_data  = DB::table('packages')->where('user_id','=',0)->get();
                    }

                }
                else{
                $package_data  = DB::table('packages')->where('user_id','=',0)->get();
                }


                $total = $cart->totalPrice;
                $coupon = Session::has('coupon') ? Session::get('coupon') : 0;
                if($gs->tax != 0)
                {
                    $tax = ($total / 100) * $gs->tax;
                    $total = $total + $tax;
                }
                if(!Session::has('coupon_total'))
                {
                $total = $total - $coupon;     
                $total = $total + 0;               
                }
                else {
                $total = Session::get('coupon_total');  
                $total = $total + round(0 * $curr->value, 2); 
                }
                $ck = 1;

                if ($total > $shipping_data->free_threshold)
                {
                    $shipping_data->price = 0;
                }
                
                $today = Carbon::now()->format('Y-m-d');

                $dont_show = 0;
        return view('front.checkout', ['products' => $cart->items, 'totalPrice' => $total, 'pickups' => $pickups, 'totalQty' => $cart->totalQty, 'gateways' => $gateways, 'shipping_cost' => 0, 'checked' => $ck, 'digital' => $dp, 'curr' => $curr,'shipping_data' => $shipping_data,'package_data' => $package_data, 'vendor_shipping_id' => $vendor_shipping_id, 'vendor_packing_id' => $vendor_packing_id, 'today' => $today, 'dont_show' =>$dont_show]);                 
                    }
        }

    }

    public function cashondelivery(Request $request)
    {
        if($request->pass_check) {
            $users = User::where('email','=',$request->personal_email)->get();
            if(count($users) == 0) {
                if ($request->personal_pass == $request->personal_confirm){
                    $user = new User;
                    $user->name = $request->personal_name; 
                    $user->email = $request->personal_email;   
                    $user->password = bcrypt($request->personal_pass);
                    $token = md5(time().$request->personal_name.$request->personal_email);
                    $user->verification_link = $token;
                    $user->affilate_code = md5($request->name.$request->email);
                    $user->emai_verified = 'Yes';
                    $user->save();
                    Auth::guard('web')->login($user);                     
                }else{
                    return redirect()->back()->with('unsuccess',"Confirm Password Doesn't Match.");     
                }
            }
            else {
                return redirect()->back()->with('unsuccess',"This Email Already Exist.");  
            }
        }


        if (!Session::has('cart')) {
            return redirect()->route('front.cart')->with('success',"You don't have any product to checkout.");
        }
            if (Session::has('currency')) 
            {
              $curr = Currency::find(Session::get('currency'));
            }
            else
            {
                $curr = Currency::where('is_default','=',1)->first();
            }
        $gs = Generalsetting::findOrFail(1);
        $oldCart = Session::get('cart');
        $cart = new Cart($oldCart);
        foreach($cart->items as $key => $prod)
        {
        if(!empty($prod['item']['license']) && !empty($prod['item']['license_qty']))
        {
                foreach($prod['item']['license_qty']as $ttl => $dtl)
                {
                    if($dtl != 0)
                    {
                        $dtl--;
                        $produc = Product::findOrFail($prod['item']['id']);
                        $temp = $produc->license_qty;
                        $temp[$ttl] = $dtl;
                        $final = implode(',', $temp);
                        $produc->license_qty = $final;
                        $produc->update();
                        $temp =  $produc->license;
                        $license = $temp[$ttl];
                         $oldCart = Session::has('cart') ? Session::get('cart') : null;
                         $cart = new Cart($oldCart);
                         $cart->updateLicense($prod['item']['id'],$license);  
                         Session::put('cart',$cart);
                        break;
                    }                    
                }
        }
        }
        $order = new Order;
        $success_url = action('Front\PaymentController@payreturn');
        $item_name = $gs->title." Order";
        $item_number = str_random(4).time();
        $order['user_id'] = $request->user_id;
        $order['cart'] = utf8_encode(bzcompress(serialize($cart), 9)); 
        $order['totalQty'] = $request->totalQty;
        $order['pay_amount'] = round($request->total / $curr->value, 2);
        $order['method'] = $request->method;
        $order['shipping'] = $request->shipping;
        $order['pickup_location'] = $request->pickup_location;
        $order['customer_email'] = $request->email;
        $order['customer_name'] = $request->name;
        $order['shipping_cost'] = $request->shipping_cost;
        $order['packing_cost'] = $request->packing_cost;
        $order['tax'] = $request->tax;
        $order['customer_phone'] = $request->phone;
        $order_number = "MAYRA-" . str_random(4).time();
        $order['order_number'] = $order_number;
        $order['customer_address'] = $request->address;
        $order['customer_country'] = $request->customer_country;
        $order['customer_city'] = $request->city;
        $order['customer_zip'] = $request->zip;
        $order['customer_longitude'] = $request->longitude;
        $order['customer_latitude'] = $request->latitude;
        $order['shipping_email'] = $request->shipping_email;
        $order['shipping_name'] = $request->shipping_name;
        $order['shipping_phone'] = $request->shipping_phone;
        $order['shipping_address'] = $request->shipping_address;
        $order['shipping_country'] = $request->shipping_country;
        $order['shipping_city'] = $request->shipping_city;
        $order['shipping_zip'] = $request->shipping_zip;
        $order['shipping_longitude'] = $request->shipping_longitude;
        $order['shipping_latitude'] = $request->shipping_latitude;
        $order['order_note'] = $request->order_notes;
        $order['coupon_code'] = $request->coupon_code;
        $order['coupon_discount'] = $request->coupon_discount;
        $order['dp'] = $request->dp;
        $order['payment_status'] = "Pending";
        $order['currency_sign'] = $curr->sign;
        $order['currency_value'] = $curr->value;
        $order['vendor_shipping_id'] = $request->vendor_shipping_id;
        $order['vendor_packing_id'] = $request->vendor_packing_id;
        $order['delivery_range_start'] = $request->delivery_range_start;
        $order['delivery_range_end'] = $request->delivery_range_end;

            if (Session::has('affilate')) 
            {
                $val = $request->total / 100;
                $sub = $val * $gs->affilate_charge;
                $user = User::findOrFail(Session::get('affilate'));
                $user->affilate_income += $sub;
                $user->update();
                $order['affilate_user'] = $user->name;
                $order['affilate_charge'] = $sub;
            }
        $order->save();


        $track = new OrderTrack;
        $track->title = 'Pending';
        $track->text = 'You have successfully placed your order.';
        $track->order_id = $order->id;
        $track->save();

        
        $vendor_id = 0;

        foreach ($cart->items as $prod) {
            $vendor_id = $prod['item']['user_id'];
            break;
        }

        // $notification = new UserNotification;
        // $notification->order_id = $order->id;
        // $notification->user_id = Auth::user()->id;
        // $notification->save();

        $conversation = new Conversation;
        $conversation->subject = $order_number;
        $conversation->sent_user = Auth::user()->id;
        $conversation->recieved_user = $vendor_id;
        $conversation->message = "Order details discussion";
        $conversation->save();

        $message = new Message;
        $message->conversation_id = $conversation->id;
        $message->message = "Order details discussion";
        $message->sent_user = 0;
        $message->save();

        $notification = new VendorNotification;
        $notification->conversation_id = $conversation->id;;
        $notification->user_id = $vendor_id;
        $notification->save();


                    if($request->coupon_id != "")
                    {
                       $coupon = Coupon::findOrFail($request->coupon_id);
                       $coupon->used++;
                       if($coupon->times != null)
                       {
                            $i = (int)$coupon->times;
                            $i--;
                            $coupon->times = (string)$i;
                       }
                        $coupon->update();

                    }

        foreach($cart->items as $prod)
        {
            $x = (string)$prod['size_qty'];
            if(!empty($x))
            {
                $product = Product::findOrFail($prod['item']['id']);
                $x = (int)$x;
                $x = $x - $prod['qty'];
                $temp = $product->size_qty;
                $temp[$prod['size_key']] = $x;
                $temp1 = implode(',', $temp);
                $product->size_qty =  $temp1;
                $product->update();               
            }
        }


        foreach($cart->items as $prod)
        {
            $x = (string)$prod['stock'];
            if($x != null)
            {

                $product = Product::findOrFail($prod['item']['id']);
                $product->stock =  $prod['stock'];
                $product->update();  
                if($product->stock <= 5)
                {
                    $notification = new Notification;
                    $notification->product_id = $product->id;
                    $notification->save();                    
                }              
            }
        }

        $notf = null;

        foreach($cart->items as $prod)
        {

                $vorder =  new VendorOrder;
                $vorder->order_id = $order->id;
                $vorder->user_id = $prod['item']['user_id'];
                $notf[] = $prod['item']['user_id'];
                $vorder->qty = $prod['qty'];
                $vorder->price = $prod['price'];
                $vorder->order_number = $order->order_number;             
                $vorder->save();
            

        }

        Session::put('temporder',$order);
        Session::put('tempcart',$cart);

        Session::forget('cart');

            Session::forget('already');
            Session::forget('coupon');
            Session::forget('coupon_total');
            Session::forget('coupon_total1');
            Session::forget('coupon_percentage');

        //Sending Email To Buyer

        // if($gs->is_smtp == 1)
        // {
        // $data = [
        //     'to' => $request->email,
        //     'type' => "new_order",
        //     'cname' => $request->name,
        //     'oamount' => "",
        //     'aname' => "",
        //     'aemail' => "",
        //     'wtitle' => "",
        //     'onumber' => $order->order_number,
        // ];


        // $mailer = new GeniusMailer();
        // $mailer->sendAutoOrderMail($data,$order->id);            
        // }
        // else
        // {
        //    $to = $request->email;
        //    $subject = "Your Order Placed!!";
        //    $msg = "Hello ".$request->name."!\nYou have placed a new order.\nYour order number is ".$order->order_number.".Please wait for your delivery. \nThank you.";
        //     $headers = "From: ".$gs->from_name."<".$gs->from_email.">";
        //    mail($to,$subject,$msg,$headers);            
        // }
        // //Sending Email To Admin
        // if($gs->is_smtp == 1)
        // {
        //     $data = [
        //         'to' => $gs->email,
        //         'subject' => "New Order Recieved!!",
        //         'body' => "Hello Admin!<br>Your store has received a new order.<br>Order Number is ".$order->order_number.".Please login to your panel to check. <br>Thank you.",
        //     ];

        //     $mailer = new GeniusMailer();
        //     $mailer->sendCustomMail($data);            
        // }
        // else
        // {
        //    $to = $gs->email;
        //    $subject = "New Order Recieved!!";
        //    $msg = "Hello Admin!\nYour store has recieved a new order.\nOrder Number is ".$order->order_number.".Please login to your panel to check. \nThank you.";
        //     $headers = "From: ".$gs->from_name."<".$gs->from_email.">";
        //    mail($to,$subject,$msg,$headers);
        // }

        return redirect($success_url);
    }

    public function gateway(Request $request)
    {

$input = $request->all();

$rules = [];


$messages = [];

$validator = Validator::make($input, $rules, $messages);

       if ($validator->fails()) {
            Session::flash('unsuccess', $validator->messages()->first());
            return redirect()->back()->withInput();
       }

        if($request->pass_check) {
            $users = User::where('email','=',$request->personal_email)->get();
            if(count($users) == 0) {
                if ($request->personal_pass == $request->personal_confirm){
                    $user = new User;
                    $user->name = $request->personal_name; 
                    $user->email = $request->personal_email;   
                    $user->password = bcrypt($request->personal_pass);
                    $token = md5(time().$request->personal_name.$request->personal_email);
                    $user->verification_link = $token;
                    $user->affilate_code = md5($request->name.$request->email);
                    $user->email_verified = 'Yes';
                    $user->save();
                    Auth::guard('web')->login($user);                     
                }else{
                    return redirect()->back()->with('unsuccess',"Confirm Password Doesn't Match.");     
                }
            }
            else {
                return redirect()->back()->with('unsuccess',"This Email Already Exist.");  
            }
        }

        $gs = Generalsetting::findOrFail(1);
        if (!Session::has('cart')) {
            return redirect()->route('front.cart')->with('success',"You don't have any product to checkout.");
        }
        $oldCart = Session::get('cart');
        $cart = new Cart($oldCart);
            if (Session::has('currency')) 
            {
              $curr = Currency::find(Session::get('currency'));
            }
            else
            {
                $curr = Currency::where('is_default','=',1)->first();
            }


        $vendor_id = 0;

        foreach ($cart->items as $prod) {
            $vendor_id = $prod['item']['user_id'];
            break;
        }

        foreach($cart->items as $key => $prod)
        {
        if(!empty($prod['item']['license']) && !empty($prod['item']['license_qty']))
        {
                foreach($prod['item']['license_qty']as $ttl => $dtl)
                {
                    if($dtl != 0)
                    {
                        $dtl--;
                        $produc = Product::findOrFail($prod['item']['id']);
                        $temp = $produc->license_qty;
                        $temp[$ttl] = $dtl;
                        $final = implode(',', $temp);
                        $produc->license_qty = $final;
                        $produc->update();
                        $temp =  $produc->license;
                        $license = $temp[$ttl];
                         $oldCart = Session::has('cart') ? Session::get('cart') : null;
                         $cart = new Cart($oldCart);
                         $cart->updateLicense($prod['item']['id'],$license);  
                         Session::put('cart',$cart);
                        break;
                    }                    
                }
        }
        }
        $settings = Generalsetting::findOrFail(1);
        $order = new Order;
        $success_url = action('Front\PaymentController@payreturn');
        $item_name = $settings->title." Order";
        $item_number = str_random(4).time();
        $order['user_id'] = $request->user_id;
        $order['cart'] = utf8_encode(bzcompress(serialize($cart), 9));
        $order['totalQty'] = $request->totalQty;
        $order['pay_amount'] = round($request->total / $curr->value, 2);
        $order['method'] = $request->method;
        $order['shipping'] = $request->shipping;
        $order['pickup_location'] = $request->pickup_location;
        $order['customer_email'] = $request->email;
        $order['customer_name'] = $request->name;
        $order['shipping_cost'] = $request->shipping_cost;
        $order['packing_cost'] = $request->packing_cost;
        $order['tax'] = $request->tax;
        $order['customer_phone'] = $request->phone;
        $order_number = "MAYRA-" . str_random(4).time();
        $order['order_number'] = $order_number;
        $order['customer_address'] = $request->address;
        $order['customer_country'] = $request->customer_country;
        $order['customer_city'] = $request->city;
        $order['customer_zip'] = $request->zip;
        $order['customer_longitude'] = $request->longitude;
        $order['customer_latitude'] = $request->customer_latitude;
        $order['shipping_email'] = $request->shipping_email;
        $order['shipping_name'] = $request->shipping_name;
        $order['shipping_phone'] = $request->shipping_phone;
        $order['shipping_address'] = $request->shipping_address;
        $order['shipping_country'] = $request->shipping_country;
        $order['shipping_city'] = $request->shipping_city;
        $order['shipping_zip'] = $request->shipping_zip;
        $order['shipping_longitude'] = $request->shipping_longitude;
        $order['shipping_latitude'] = $request->shipping_latitude;
        $order['order_note'] = $request->order_notes;
        $order['txnid'] = $request->txn_id4;
        $order['coupon_code'] = $request->coupon_code;
        $order['coupon_discount'] = $request->coupon_discount;
        $order['dp'] = $request->dp;
        $order['payment_status'] = "Pending";
        $order['currency_sign'] = $curr->sign;
        $order['currency_value'] = $curr->value;
        $order['vendor_shipping_id'] = $request->vendor_shipping_id;
        $order['vendor_packing_id'] = $request->vendor_packing_id;  
        $order['delivery_range_start'] = $request->delivery_range_start;
        $order['delivery_range_end'] = $request->delivery_range_end;
        
        if ($request->hasFile('txn_image')) 
        {
            //  Let's do everything here
            if ($request->file('txn_image')->isValid()) 
            {
                $image_name = date('mdYHis') . uniqid() .$request->file('txn_image')->getClientOriginalName();
                $order['txn_image'] = $image_name;
                $path = 'assets/images/users';
                $request->file('txn_image')->move($path,$image_name);

            }
        }


            if (Session::has('affilate')) 
            {
                $val = $request->total / 100;
                $sub = $val * $gs->affilate_charge;
                $user = User::findOrFail(Session::get('affilate'));
                $user->affilate_income += $sub;
                $user->update();
                $order['affilate_user'] = $user->name;
                $order['affilate_charge'] = $sub;
            }
        $order->save();

        $track = new OrderTrack;
        $track->title = 'Pending';
        $track->text = 'You have successfully placed your order.';
        $track->order_id = $order->id;
        $track->save();
        
        $conversation = new Conversation;
        $conversation->subject = $order_number;
        $conversation->sent_user = Auth::user()->id;
        $conversation->recieved_user = $vendor_id;
        $conversation->message = "Order details discussion";
        $conversation->save();

        $message = new Message;
        $message->conversation_id = $conversation->id;
        $message->message = "Order details discussion";
        $message->sent_user = 0;
        $message->save();

        $notification = new VendorNotification;
        $notification->conversation_id = $conversation->id;;
        $notification->user_id = $vendor_id;
        $notification->save();

        // gets inserted
        // $user_notification = new UserNotification;
        // $user_notification->user_id = Auth::user()->id;
        // $user_notification->order_number = $order_number;
        // $user_notification->save();


        
                    if($request->coupon_id != "")
                    {
                       $coupon = Coupon::findOrFail($request->coupon_id);
                       $coupon->used++;
                       if($coupon->times != null)
                       {
                            $i = (int)$coupon->times;
                            $i--;
                            $coupon->times = (string)$i;
                       }
                        $coupon->update();

                    }

        foreach($cart->items as $prod)
        {
            $x = (string)$prod['size_qty'];
            if(!empty($x))
            {
                $product = Product::findOrFail($prod['item']['id']);
                $x = (int)$x;
                $x = $x - $prod['qty'];
                $temp = $product->size_qty;
                $temp[$prod['size_key']] = $x;
                $temp1 = implode(',', $temp);
                $product->size_qty =  $temp1;
                $product->update();               
            }
        }


        foreach($cart->items as $prod)
        {
            $x = (string)$prod['stock'];
            if($x != null)
            {

                $product = Product::findOrFail($prod['item']['id']);
                $product->stock =  $prod['stock'];
                $product->update();  
                if($product->stock <= 5)
                {
                    $notification = new Notification;
                    $notification->product_id = $product->id;
                    $notification->save();                    
                }              
            }
        }

        $notf = null;

        foreach($cart->items as $prod)
        {

                $vorder =  new VendorOrder;
                $vorder->order_id = $order->id;
                $vorder->user_id = $prod['item']['user_id'];
                $notf[] = $prod['item']['user_id'];
                $vorder->qty = $prod['qty'];
                $vorder->price = $prod['price'];
                $vorder->order_number = $order->order_number;             
                $vorder->save();
            

        }

        Session::put('temporder',$order);
        Session::put('tempcart',$cart);
        Session::forget('cart');
        Session::forget('already');
        Session::forget('coupon');
        Session::forget('coupon_total');
        Session::forget('coupon_total1');
        Session::forget('coupon_percentage');



        

        //Sending Email To Buyer
        // if($gs->is_smtp == 1)
        // {
        // $data = [
        //     'to' => $request->email,
        //     'type' => "new_order",
        //     'cname' => $request->name,
        //     'oamount' => "",
        //     'aname' => "",
        //     'aemail' => "",
        //     'wtitle' => "",
        //     'onumber' => $order->order_number,
        // ];


        // $mailer = new GeniusMailer();
        // $mailer->sendAutoOrderMail($data,$order->id);            
        // }
        // else
        // {
        //    $to = $request->email;
        //    $subject = "Your Order Placed!!";
        //    $msg = "Hello ".$request->name."!\nYou have placed a new order.\nYour order number is ".$order->order_number.".Please wait for your delivery. \nThank you.";
        //     $headers = "From: ".$gs->from_name."<".$gs->from_email.">";
        //    mail($to,$subject,$msg,$headers);            
        // }
        // //Sending Email To Admin
        // if($gs->is_smtp == 1)
        // {
        //     $data = [
        //         'to' => $gs->email,
        //         'subject' => "New Order Recieved!!",
        //         'body' => "Hello Admin!<br>Your store has received a new order.<br>Order Number is ".$order->order_number.".Please login to your panel to check. <br>Thank you.",
        //     ];

        //     $mailer = new GeniusMailer();
        //     $mailer->sendCustomMail($data);            
        // }
        // else
        // {
        //    $to = $gs->email;
        //    $subject = "New Order Recieved!!";
        //    $msg = "Hello Admin!\nYour store has recieved a new order.\nOrder Number is ".$order->order_number.".Please login to your panel to check. \nThank you.";
        //     $headers = "From: ".$gs->from_name."<".$gs->from_email.">";
        //    mail($to,$subject,$msg,$headers);
        // }

        return redirect($success_url);
    }


    // Capcha Code Image
    private function  code_image()
    {
        $actual_path = str_replace('project','',base_path());
        $image = imagecreatetruecolor(200, 50);
        $background_color = imagecolorallocate($image, 255, 255, 255);
        imagefilledrectangle($image,0,0,200,50,$background_color);

        $pixel = imagecolorallocate($image, 0,0,255);
        for($i=0;$i<500;$i++)
        {
            imagesetpixel($image,rand()%200,rand()%50,$pixel);
        }

        $font = $actual_path.'assets/front/fonts/NotoSans-Bold.ttf';
        $allowed_letters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
        $length = strlen($allowed_letters);
        $letter = $allowed_letters[rand(0, $length-1)];
        $word='';
        //$text_color = imagecolorallocate($image, 8, 186, 239);
        $text_color = imagecolorallocate($image, 0, 0, 0);
        $cap_length=6;// No. of character in image
        for ($i = 0; $i< $cap_length;$i++)
        {
            $letter = $allowed_letters[rand(0, $length-1)];
            imagettftext($image, 25, 1, 35+($i*25), 35, $text_color, $font, $letter);
            $word.=$letter;
        }
        $pixels = imagecolorallocate($image, 8, 186, 239);
        for($i=0;$i<500;$i++)
        {
            imagesetpixel($image,rand()%200,rand()%50,$pixels);
        }
        session(['captcha_string' => $word]);
        imagepng($image, $actual_path."assets/images/capcha_code.png");
    }

    public function checkout_api(Request $request)
    {
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

    public function message_api(Request $request)
    {
        $user = Auth::user();
        $conv = Conversation::where('subject', '=', $request->order_number)->first();
        $other_covs = Conversation::where('sent_user', '=', $conv->sent_user)->where('recieved_user', '=', $conv->recieved_user)->where('id', '!=', $conv->id)->get();
        return response()->json(['status' => 'success', 'conv' => $conv, 'messages' => $conv->messages, 'other_convs'=> $other_covs]);          
    }

    public function message_api_by_id(Request $request)
    {
        try{
            $user = Auth::user();
            $conv = Conversation::where('id', '=', $request->id)->first();
            $other_covs = Conversation::where('sent_user', '=', $conv->sent_user)->where('recieved_user', '=', $conv->recieved_user)->where('id', '!=', $conv->id)->get();
            return response()->json(['status' => 'success', 'conv' => $conv, 'messages' => $conv->messages, 'other_convs'=> $other_covs]);  
        }  catch (\Exception $e) {
            return response()->json(['status' => 'failure', 'details' => $e->getMessage(), 'line_number' =>$e->getLine()]);
        }        
    }

    public function postmessage(Request $request)
    {
        $user = Auth::user(); 
        $msg = new Message();
        $input = $request->except(['file']);
        $input['sent_user'] = $user->id;

        if($request->file) 
        {      

            $image = base64_decode($request->file);
            $image_name = time().str_random(8).'.png';
            $path = 'assets/images/users/'.$image_name;
            file_put_contents($path, $image);
                        
            $input['file'] = $image_name;
        }

        $msg->fill($input)->save();
        //--- Redirect Section     
        $msg = 'Message Sent!';

        $conv = Conversation::where('id','=',$request->conversation_id)->first();

        $notification = new VendorNotification();
        $notification->conversation_id = $conv->id;
        $notification->user_id = $conv->recieved_user;
        $notification->save();
        
        if ($conv->is_dispute == 1)
        {
            $notification = new Notification;
            $notification->conversation_id = $request->conversation_id;
            // $notification->admin_id = 1;
            $notification->type = "admin";
            $notification->save();
        }

        return response()->json(['status' => 'success', 'details' => $msg]);


           
    }

    public function swap_dispute($id)
    {
        $conv = Conversation::findOrfail($id);
        $user = Auth::user();
        $new_disp = 1 - $conv->is_dispute;
        Conversation::where('id', $id)->update(array('is_dispute' => $new_disp));

        $message = "Buyer has closed a dispute";
        $dispute_type = "dispute_close";
        if ($new_disp == 1)
        {
            $message = "Buyer has opened a dispute. Admins will now handle this case";
            $dispute_type = "dispute_open";
        }

        $msg = new Message();
        $msg->conversation_id = $conv->id;
        $msg->message = $message;
        $msg->sent_user = 0;
        $msg->save();
        
        $notification = new VendorNotification();
        $notification->conversation_id = $conv->id;
        $notification->user_id = $conv->recieved_user;
        $notification->save();

        $notification = new Notification;
        $notification->conversation_id = $conv->id;
        // $notification->admin_id = 1;
        $notification->type = $dispute_type;
        $notification->save();

        $conv = Conversation::findOrfail($id);

        return response()->json(['status' => 'success', 'dispute_type' => $dispute_type]);                    
    }

    public function swap_open($id)
    {
        $conv = Conversation::findOrfail($id);
        $user = Auth::guard('web')->user();
        $new_closed = 1 - $conv->closed;
        Conversation::where('id', $id)->update(array('closed' => $new_closed));

        $conv = Conversation::findOrfail($id);

        $notification = new VendorNotification();
        $notification->conversation_id = $conv->id;
        $notification->user_id = $conv->recieved_user;
        $notification->save();

        if ($new_closed == 1)
        {
            $msg = new Message();
            $msg->conversation_id = $conv->id;
            $msg->message = "Buyer has confirmed receiving an item";
            $msg->sent_user = 0;
            $msg->save();
        }

        return response()->json(['status' => 'success', 'new_received_status' => $new_closed]);                   
    }

    public function order_details(Request $request)
    {
        $order = Order::where('id', '=', $request->id)->first();
        $cart = unserialize(bzdecompress(utf8_decode($order->cart)));


        $my_cart = array();

        foreach($cart->items as $item)
        {
            $current = array();
            $current['qty'] = ($item['qty']);
            $current['color'] = ($item['color']);
            $current['price'] = ($item['price']);
            $current['size'] = ($item['size']);
            try
            {
                $current['product_details'] = Product::where('id', '=', $item['item']->id)->first();
                $current['vendor_details'] = User::where('id', '=', $item['item']->user_id)->first();
            }  catch (\Exception $e) {
                
            }

            $my_cart[] = $current;
        }
        $order['cart'] = $my_cart;
        return $order;
    }

    public function user_orders(Request $request)
    {
        $user = $request->user();
        $user_orders = Order::where('user_id', '=', $user->id)->get();

        $all_data = array();

        foreach($user_orders as $order)
        {
            $curr_data = $order;
            $cart = unserialize(bzdecompress(utf8_decode($order->cart)));
            $my_cart = array();

            foreach($cart->items as $item)
            {
                $current = array();
                $current['qty'] = ($item['qty']);
                $current['color'] = ($item['color']);
                $current['price'] = ($item['price']);
                $current['size'] = ($item['size']);
                try
                {
                    $current['product_details'] = Product::where('id', '=', $item['item']->id)->first();
                    $current['vendor_details'] = User::where('id', '=', $item['item']->user_id)->first();
                }  catch (\Exception $e) {
                    
                }

                $my_cart[] = $current;
            }

            $order['cart'] = $my_cart;
        }

        
        return response()->json(['status' => 'success', 'details' => $user_orders]);
    }

    public function order_api(Request $request)
    {

        try{
            $input = $request->all();
            $user = $request->user();
            $api_cart = ApiCart::where('user_id', '=', $user->id)->get();

            $oldCart = null;
            $cart = new Cart($oldCart);

            foreach($api_cart as $api)
            {
                if ($api->product_id != null)
                {
                    $color = null;
                    $size = null;

                    if (isset($api->size))
                        $size = $api->size;

                    if (isset($api->color))
                        $color = $api->color;
                
                    $prod = Product::where('id','=',$api->product_id)->first(['id','user_id','slug','name','photo','size','size_qty','size_price','color','price','stock','type','file','link','license','license_qty','measure','whole_sell_qty','whole_sell_discount','attributes']);
                    if (is_object($prod)) {
                     $cart->add($prod, $prod->id, $size, $color, '', '');
                    }
                }
                
            }

            //just copy paste from gateway now
            $gs = Generalsetting::findOrFail(1);
            $curr = Currency::where('is_default','=',1)->first();
                


            $vendor_id = 0;

            foreach ($cart->items as $prod) 
            {
                $vendor_id = $prod['item']['user_id'];
                break;
            }

            foreach($cart->items as $key => $prod)
            {
                if(!empty($prod['item']['license']) && !empty($prod['item']['license_qty']))
                {
                        foreach($prod['item']['license_qty']as $ttl => $dtl)
                        {
                            if($dtl != 0)
                            {
                                $dtl--;
                                $produc = Product::findOrFail($prod['item']['id']);
                                $temp = $produc->license_qty;
                                $temp[$ttl] = $dtl;
                                $final = implode(',', $temp);
                                $produc->license_qty = $final;
                                $produc->update();
                                $temp =  $produc->license;
                                $license = $temp[$ttl];
                                $oldCart = Session::has('cart') ? Session::get('cart') : null;
                                $cart = new Cart($oldCart);
                                $cart->updateLicense($prod['item']['id'],$license);  
                                Session::put('cart',$cart);
                                break;
                            }                    
                        }
                }
            }

            $settings = Generalsetting::findOrFail(1);
            $order = new Order;
            $item_name = $settings->title." Order";
            $item_number = str_random(4).time();
            $order['user_id'] = $user->id;
            $order['cart'] = utf8_encode(bzcompress(serialize($cart), 9));
            $order['totalQty'] = $request->totalQty;
            $order['pay_amount'] = round($request->total / $curr->value, 2);
            $order['method'] = $request->method;
            $order['shipping'] = "shipto";
            $order['pickup_location'] = null;
            $order['customer_email'] = $request->email;
            $order['customer_name'] = $request->name;
            $order['shipping_cost'] = $request->shipping_cost;
            $order['packing_cost'] = 0;
            $order['tax'] = 0;
            $order['customer_phone'] = $request->phone;
            $order_number = "MAYRA-" . str_random(4).time();
            $order['order_number'] = $order_number;
            $order['customer_address'] = $request->address;
            $order['customer_country'] = $request->customer_country;
            $order['customer_city'] = $request->city;
            $order['customer_zip'] = $request->zip;
            $order['customer_longitude'] = $request->longitude;
            $order['customer_latitude'] = $request->customer_latitude;

            $order['shipping_email'] = $request->email;
            $order['shipping_name'] = $request->shipping_name;
            $order['shipping_phone'] = $request->shipping_phone;
            $order['shipping_address'] = $request->shipping_address;
            $order['shipping_country'] = $request->shipping_country;
            $order['shipping_city'] = $request->shipping_city;
            $order['shipping_zip'] = $request->shipping_zip;
            $order['shipping_longitude'] = $request->shipping_longitude;
            $order['shipping_latitude'] = $request->shipping_latitude;

            $order['order_note'] = $request->order_notes;
            $order['txnid'] = null;
            $order['coupon_code'] = $request->coupon_code;
            $order['coupon_discount'] = $request->coupon_discount;
            $order['dp'] = 0;
            $order['payment_status'] = "Pending";
            $order['currency_sign'] = $curr->sign;
            $order['currency_value'] = $curr->value;
            $order['vendor_shipping_id'] = 0;
            $order['vendor_packing_id'] = 0;  
            $order['delivery_range_start'] = $request->delivery_range_start;
            $order['delivery_range_end'] = $request->delivery_range_end;

            if($request->txn_image) 
            {      

                $image = base64_decode($request->txn_image);
                $image_name = time().str_random(8).'.png';
                $path = 'assets/images/users/'.$image_name;
                file_put_contents($path, $image);
                            
                $order['txn_image'] = $image_name;
            }


            //     if (Session::has('affilate')) 
            //     {
            //         $val = $request->total / 100;
            //         $sub = $val * $gs->affilate_charge;
            //         $user = User::findOrFail(Session::get('affilate'));
            //         $user->affilate_income += $sub;
            //         $user->update();
            //         $order['affilate_user'] = $user->name;
            //         $order['affilate_charge'] = $sub;
            //     }

            $order->save();

            $track = new OrderTrack;
            $track->title = 'Pending';
            $track->text = 'You have successfully placed your order.';
            $track->order_id = $order->id;
            $track->save();
            
            $conversation = new Conversation;
            $conversation->subject = $order_number;
            $conversation->sent_user = Auth::user()->id;
            $conversation->recieved_user = $vendor_id;
            $conversation->message = "Order details discussion";
            $conversation->save();

            $message = new Message;
            $message->conversation_id = $conversation->id;
            $message->message = "Order details discussion";
            $message->sent_user = 0;
            $message->save();

            $notification = new VendorNotification;
            $notification->conversation_id = $conversation->id;;
            $notification->user_id = $vendor_id;
            $notification->save();


            
            //             if($request->coupon_id != "")
            //             {
            //             $coupon = Coupon::findOrFail($request->coupon_id);
            //             $coupon->used++;
            //             if($coupon->times != null)
            //             {
            //                     $i = (int)$coupon->times;
            //                     $i--;
            //                     $coupon->times = (string)$i;
            //             }
            //                 $coupon->update();

            //             }

            foreach($cart->items as $prod)
            {
                $x = (string)$prod['size_qty'];
                if(!empty($x))
                {
                    $product = Product::findOrFail($prod['item']['id']);
                    $x = (int)$x;
                    $x = $x - $prod['qty'];
                    $temp = $product->size_qty;
                    $temp[$prod['size_key']] = $x;
                    $temp1 = implode(',', $temp);
                    $product->size_qty =  $temp1;
                    $product->update();               
                }
            }


            foreach($cart->items as $prod)
            {
                $x = (string)$prod['stock'];
                if($x != null)
                {

                    $product = Product::findOrFail($prod['item']['id']);
                    $product->stock =  $prod['stock'];
                    $product->update();  
                    if($product->stock <= 5)
                    {
                        $notification = new Notification;
                        $notification->product_id = $product->id;
                        $notification->save();                    
                    }              
                }
            }

            $notf = null;

            foreach($cart->items as $prod)
            {

                    $vorder =  new VendorOrder;
                    $vorder->order_id = $order->id;
                    $vorder->user_id = $prod['item']['user_id'];
                    $notf[] = $prod['item']['user_id'];
                    $vorder->qty = $prod['qty'];
                    $vorder->price = $prod['price'];
                    $vorder->order_number = $order->order_number;             
                    $vorder->save();
                

            }

            Session::put('temporder',$order);
            Session::put('tempcart',$cart);
            Session::forget('cart');
            Session::forget('already');
            Session::forget('coupon');
            Session::forget('coupon_total');
            Session::forget('coupon_total1');
            Session::forget('coupon_percentage');



            

            //Sending Email To Buyer
            // if($gs->is_smtp == 1)
            // {
            // $data = [
            //     'to' => $request->email,
            //     'type' => "new_order",
            //     'cname' => $request->name,
            //     'oamount' => "",
            //     'aname' => "",
            //     'aemail' => "",
            //     'wtitle' => "",
            //     'onumber' => $order->order_number,
            // ];

            // $mailer = new GeniusMailer();
            // $mailer->sendAutoOrderMail($data,$order->id);            
            // }
            // else
            // {
            // $to = $request->email;
            // $subject = "Your Order Placed!!";
            // $msg = "Hello ".$request->name."!\nYou have placed a new order.\nYour order number is ".$order->order_number.".Please wait for your delivery. \nThank you.";
            //     $headers = "From: ".$gs->from_name."<".$gs->from_email.">";
            // mail($to,$subject,$msg,$headers);            
            // }
            // //Sending Email To Admin
            // if($gs->is_smtp == 1)
            // {
            //     $data = [
            //         'to' => $gs->email,
            //         'subject' => "New Order Recieved!!",
            //         'body' => "Hello Admin!<br>Your store has received a new order.<br>Order Number is ".$order->order_number.".Please login to your panel to check. <br>Thank you.",
            //     ];

            //     $mailer = new GeniusMailer();
            //     $mailer->sendCustomMail($data);            
            // }
            // else
            // {
            // $to = $gs->email;
            // $subject = "New Order Recieved!!";
            // $msg = "Hello Admin!\nYour store has recieved a new order.\nOrder Number is ".$order->order_number.".Please login to your panel to check. \nThank you.";
            //     $headers = "From: ".$gs->from_name."<".$gs->from_email.">";
            // mail($to,$subject,$msg,$headers);
            // }

            ApiCart::where('user_id', '=', $user->id)->delete();


            return response()->json(['status' => 'success', 'id' => $order->id, 'order_number' => $order_number]);

        }  catch (\Exception $e) {
            return response()->json(['status' => 'failure', 'details' => $e->getMessage(), 'line_number' =>$e->getLine()]);
        }

    }

}
