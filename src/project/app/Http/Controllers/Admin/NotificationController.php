<?php

namespace App\Http\Controllers\Admin;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Models\Notification;
use App\Models\SystemNotification;
use Log;

class NotificationController extends Controller
{
    public function __construct()
    {
        $this->middleware('auth:admin');
    }

    public function user_notf_count()
    {
        $data = Notification::where('user_id','!=',null)->where('is_read','=',0)->get()->count();
        return response()->json($data);            
    } 

    public function user_notf_clear()
    {
        $data = Notification::where('user_id','!=',null);
        $data->delete();        
    } 

    public function system_notifications()
    {
        $expiring_notifications = SystemNotification::where('is_read', '=', 0)->where('message_type', '=', 'expiring')->get();
        $reported_notifications = SystemNotification::where('is_read', '=', 0)->where('message_type', '=', 'report')->get();

        return view('admin.notification.system', compact('expiring_notifications','reported_notifications'));        
    }

    public function mark_as_read($id)
    {
        $notification = SystemNotification::where('id', '=', $id)->first();
        $notification->is_read = 1;
        $notification->update();

        return redirect()->route('system-notifications-show');
    }

    public function user_notf_show()
    {
        $datas = Notification::where('user_id','!=',null)->get();
        if($datas->count() > 0){
          foreach($datas as $data){
            $data->is_read = 1;
            $data->update();
          }
        }       
        return view('admin.notification.register',compact('datas'));           
    } 


    public function order_notf_count()
    {
        $data = Notification::where('order_id','!=',null)->where('is_read','=',0)->get()->count();
        return response()->json($data);            
    } 

    public function order_notf_clear()
    {
        $data = Notification::where('order_id','!=',null);
        $data->delete();        
    } 

    public function order_notf_show()
    {
        $datas = Notification::where('order_id','!=',null)->get();
        if($datas->count() > 0){
          foreach($datas as $data){
            $data->is_read = 1;
            $data->update();
          }
        }       
        return view('admin.notification.order',compact('datas'));           
    } 


    public function product_notf_count()
    {
        $data = Notification::where('product_id','!=',null)->where('is_read','=',0)->get()->count();
        return response()->json($data);            
    } 

    public function product_notf_clear()
    {
        $data = Notification::where('product_id','!=',null);
        $data->delete();        
    } 

    public function product_notf_show()
    {
        $datas = Notification::where('product_id','!=',null)->get();
        if($datas->count() > 0){
          foreach($datas as $data){
            $data->is_read = 1;
            $data->update();
          }
        }       
        return view('admin.notification.product',compact('datas'));           
    } 


    public function conv_notf_count()
    {
        $data = Notification::where('conversation_id','!=',null)
        ->orWhere('ticket_id','!=',null)
        ->where('is_read','=',0)->get()->count();
        return response()->json($data);            
    } 

    public function conv_notf_clear()
    {
        $data = Notification::where('conversation_id','!=',null);
        $data->delete();        
    } 

    public function conv_notf_show()
    {
        $datas = Notification::where('conversation_id','!=',null)->orWhere('ticket_id','!=',null)->get();
        if($datas->count() > 0){
          foreach($datas as $data){
            $data->is_read = 1;
            $data->update();
          }
        }       
        return view('admin.notification.message',compact('datas'));           
    } 

}
