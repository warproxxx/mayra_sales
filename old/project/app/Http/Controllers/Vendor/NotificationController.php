<?php

namespace App\Http\Controllers\Vendor;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Models\UserNotification;
use App\Models\Notification;

class NotificationController extends Controller
{

    public function __construct()
    {
        $this->middleware('auth');
    }

    public function order_notf_count($id)
    {
        $data = Notification::where('vendor_id','=',$id)->where('is_read','=',0)->get()->count();
        return response()->json($data);            
    } 

    public function order_notf_clear($id)
    {
        print('call');
        $data = Notification::where('vendor_id','=',$id);
        $data->delete();        
    } 

    public function order_notf_show($id)
    {
        $datas = Notification::where('vendor_id','=',$id)->get();
        if($datas->count() > 0){
          foreach($datas as $data){
            $data->is_read = 1;
            $data->update();
          }
        }
        return view('vendor.notification.order',compact('datas'));           
    } 
}
