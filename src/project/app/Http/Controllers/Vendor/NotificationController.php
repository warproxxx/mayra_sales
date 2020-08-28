<?php

namespace App\Http\Controllers\Vendor;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Models\VendorNotification;

class NotificationController extends Controller
{

    public function __construct()
    {
        $this->middleware('auth');
    }

    public function order_notf_count($id)
    {
        $data = VendorNotification::where('user_id','=',$id)->where('is_read','=',0)->get()->count();
        return response()->json($data);            
    } 

    public function order_notf_clear($id)
    {
        $data = VendorNotification::where('user_id','=',$id);
        $data->delete();        
    } 

    public function order_notf_show($id)
    {
        $datas = VendorNotification::where('user_id','=',$id)->get();
        if($datas->count() > 0){
          foreach($datas as $data){
            $data->is_read = 1;
            $data->update();
          }
        }       
        return view('vendor.notification.order',compact('datas'));           
    } 
}
