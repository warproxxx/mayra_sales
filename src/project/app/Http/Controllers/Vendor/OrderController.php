<?php

namespace App\Http\Controllers\Vendor;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Auth;
use App\Models\Conversation;
use App\Models\Message;
use App\Models\Notification;
use App\Models\UserNotification;
use App\Models\VendorNotification;
use App\Models\Order;
use App\Models\VendorOrder;
use App\Models\SystemNotification;
use App\Models\User;
use App\Classes\FirebaseNotify;
use Log;

class OrderController extends Controller
{
    public function __construct()
    {
        $this->middleware('auth');
    }

    public function index()
    {
        try{
        $user = Auth::user();
        $orders = VendorOrder::where('vendor_orders.user_id','=',$user->id)
        ->leftJoin('conversations', 'vendor_orders.order_number', '=', 'conversations.subject')
        ->leftJoin('orders', 'vendor_orders.order_number', '=', 'orders.order_number')
        ->select('vendor_orders.id','vendor_orders.user_id', 'vendor_orders.order_id', 'vendor_orders.qty', 'vendor_orders.price', 'vendor_orders.order_number', 'vendor_orders.status', 'conversations.id AS conversation_id', 'orders.pay_amount', 'orders.method')
        ->orderBy('vendor_orders.id','desc')->get();

        return view('vendor.order.index',compact('user','orders'));
        } catch (\Exception $e) {

            return $e->getMessage();
        }
    }

    public function show($slug)
    {
        try 
        {

            $user = Auth::user();

            if (strlen($slug) < 5)
            {
                $conversation =  Conversation::where('id', '=', $slug)->first();
                $conversation_id = $conversation->id;

                $order = Order::where('order_number','=',$conversation->subject)->first();
            }
            else
            {
                $order = Order::where('order_number','=',$slug)->first();

                $conversation =  Conversation::where('subject', '=', $slug)->first();
                $conversation_id = $conversation->id;
            }
            
            $cart = unserialize(bzdecompress(utf8_decode($order->cart)));

            return view('vendor.order.details',compact('user','order','cart','conversation_id'));
        } 
        catch (\Exception $e) {

            return $e->getMessage();
        }
    }

    public function message($id)
    {
        $user = Auth::guard('web')->user();
        $conv = Conversation::findOrfail($id);
        $order = Order::where('order_number','=',$conv->subject)
                 ->first();
        $other_covs = Conversation::where('sent_user', '=', $conv->sent_user)->where('recieved_user', '=', $conv->recieved_user)->where('id', '!=', $id)->get();

        return view('vendor.order.message',compact('user','conv', 'order','other_covs'));
    }

    public function license(Request $request, $slug)
    {
        $order = Order::where('order_number','=',$slug)->first();
        $cart = unserialize(bzdecompress(utf8_decode($order->cart)));
        $cart->items[$request->license_key]['license'] = $request->license;
        $order->cart = utf8_encode(bzcompress(serialize($cart), 9));
        $order->update();         
        $msg = 'Successfully Changed The License Key.';
        return response()->json($msg);
    }



    public function invoice($slug)
    {
        $user = Auth::user();
        $order = Order::where('order_number','=',$slug)->first();
        $cart = unserialize(bzdecompress(utf8_decode($order->cart)));
        return view('vendor.order.invoice',compact('user','order','cart'));
    }

    public function printpage($slug)
    {
        $user = Auth::user();
        $order = Order::where('order_number','=',$slug)->first();
        $cart = unserialize(bzdecompress(utf8_decode($order->cart)));
        return view('vendor.order.print',compact('user','order','cart'));
    }

    public function report($slug)
    {
       $order = Order::where('order_number','=',$slug)->orWhere('id', '=', $slug)->first();
       $user = User::where('id', '=', $order->user_id)->first();
       $user->reported_times = $user->reported_times + 1;
       $order->reported = 1;


       $notification = new SystemNotification;
       $notification->user_id = $user->id;
       $notification->message_type = 'report';
       $notification->save();
       $order->update();
       $user->update();

       return redirect()->route('vendor-order-show', $slug);
    }

    public function status($slug,$status)
    {


        $user = Auth::user();
        
        try
        {
            $order = VendorOrder::where('order_number','=',$slug)->where('user_id','=',$user->id)->update(['status' => $status]);
        }
        catch (Exception $e)
        {

        }

        $on_user = Order::where('order_number','=',$slug)->update(['status' => $status]);

        $order = Order::where('order_number','=',$slug)->first();

        $conv = Conversation::where('subject','=',$slug)->first();

        $msg = new Message();
        $msg->conversation_id = $conv->id;
        $msg->message = "The status of this order has been changed to " . $status;
        $msg->sent_user = $user->id;
        $msg->save();
        
        $order = Order::where('order_number','=',$slug)->first();

        $notification = new UserNotification();
        $notification->conversation_id =  $conv->id;
        $notification->user_id = $order->user_id;
        $notification->save();

        $firebase = new FirebaseNotify();
        $response = $firebase->sendNotification("New Notification", "You have a new message", $order->id, $order->user_id);

        if ($conv->is_dispute == 1)
        {
            $notification = new Notification;
            $notification->conversation_id = $conv->id;
            // $notification->admin_id = 1;
            $notification->save();
        }

        return redirect()->route('vendor-order-show',$order->order_number);
     
    }

    public function payment($slug,$status)
    {
        $mainorder = VendorOrder::where('order_number','=',$slug)->first();


        $user = Auth::user();
        $on_user = Order::where('order_number','=',$slug)->update(['payment_status' => $status]);

        $order = Order::where('order_number','=',$slug)->first();

        $conv = Conversation::where('subject','=',$slug)->first();

        $msg = new Message();
        $msg->conversation_id = $conv->id;
        $msg->message = "The payment status of this order has been changed to " . $status;
        $msg->sent_user = $user->id;
        $msg->save();
        
        $order = Order::where('order_number','=',$slug)->first();

        $notification = new UserNotification();
        $notification->conversation_id =  $conv->id;
        $notification->user_id = $order->user_id;
        $notification->save();

        $firebase = new FirebaseNotify();
        $response = $firebase->sendNotification("New Notification", "You have a new message", $order->id, $order->user_id);

        if ($conv->is_dispute == 1)
        {
            $notification = new Notification;
            $notification->conversation_id = $conv->id;
            // $notification->admin_id = 1;
            $notification->save();
        }


        return redirect()->route('vendor-order-show',$order->order_number);
    }

    public function postmessage(Request $request)
    {
        #copy image upload and fix redirect
        $msg = new Message();
        $input = $request->except(['file']);

        if ($request->hasFile('file')) 
        {
            if ($request->file('file')->isValid()) 
            {
                $image_name = date('mdYHis') . uniqid() .$request->file('file')->getClientOriginalName();
                $input['file'] = $image_name;
                $path = 'assets/images/users';
                $request->file('file')->move($path,$image_name);
            }
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

        if($request->ajax()){
            return response()->json($msg);   
        }
        else
        {
            return redirect()->back();
        }


           
    }


}
