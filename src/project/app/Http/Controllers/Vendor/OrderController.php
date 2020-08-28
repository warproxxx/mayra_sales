<?php

namespace App\Http\Controllers\Vendor;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Auth;
use App\Models\Conversation;
use App\Models\Message;
use App\Models\Notification;
use App\Models\Order;
use App\Models\VendorOrder;

class OrderController extends Controller
{
    public function __construct()
    {
        $this->middleware('auth');
    }

    public function index()
    {
        $user = Auth::user();
        $orders = VendorOrder::where('user_id','=',$user->id)
        ->leftJoin('conversations', 'vendor_orders.order_number', '=', 'conversations.subject')
        ->select('vendor_orders.id','vendor_orders.user_id', 'vendor_orders.order_id', 'vendor_orders.qty', 'vendor_orders.price', 'vendor_orders.order_number', 'vendor_orders.status', 'conversations.id AS conversation_id')
        ->orderBy('vendor_orders.id','desc')->get()->groupBy('vendor_orders.order_number');

        return view('vendor.order.index',compact('user','orders'));
    }

    public function show($slug)
    {
        $user = Auth::user();
        $order = Order::where('order_number','=',$slug)->first();
        $cart = unserialize(bzdecompress(utf8_decode($order->cart)));
        $conversation_id = Conversation::where('subject', '=', $slug)->first()->id;
        return view('vendor.order.details',compact('user','order','cart','conversation_id'));
    }

    public function message($id)
    {
        $user = Auth::guard('web')->user();
        $conv = Conversation::findOrfail($id);
        $order = Order::where('order_number','=',$conv->subject)
                 ->first();

        return view('vendor.order.message',compact('user','conv', 'order'));
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

    public function status($slug,$status)
    {
        $mainorder = VendorOrder::where('order_number','=',$slug)->first();
        if ($mainorder->status == "completed"){
            return redirect()->back()->with('success','This Order is Already Completed');
        }else{

        $user = Auth::user();
        $order = VendorOrder::where('order_number','=',$slug)->where('user_id','=',$user->id)->update(['status' => $status]);
        $on_user = Order::where('order_number','=',$slug)->update(['status' => $status]);

        $order = Order::where('order_number','=',$slug)->first();

        $conv = Conversation::where('subject','=',$slug)->first();

        $msg = new Message();
        $msg->conversation_id = $conv->id;
        $msg->message = "The status of this order has been changed to " . $status;
        $msg->sent_user = $user->id;
        $msg->save();
        
        $order = Order::where('order_number','=',$slug)->first();
        $notification = new Notification;
        $notification->conversation_id = $conv->id;
        $notification->user_id = $order->user_id;
        $notification->save();

        return redirect()->route('vendor-order-show',$order->order_number);
     }
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
        $notification = new Notification;
        $notification->conversation_id = $conv->id;
        $notification->user_id = $order->user_id;
        $notification->save();

        return redirect()->route('vendor-order-show',$order->order_number);
    }

    public function postmessage(Request $request)
    {
        $msg = new Message();
        $input = $request->all();  
        $msg->fill($input)->save();
        //--- Redirect Section     
        $msg = 'Message Sent!';

        $notification = new Notification;
        $notification->conversation_id = $request->conversation_id;
        $notification->user_id = $request->reciever;
        $notification->save();

        #send admin notification if disputed
        $conv = Conversation::where('id','=',$request->conversation_id)->first();
        if ($conv->is_dispute == 1)
        {
            $notification = new Notification;
            $notification->conversation_id = $request->conversation_id;
            $notification->admin_id = 1;
            $notification->save();
        }

        return response()->json($msg);      
    }


}
