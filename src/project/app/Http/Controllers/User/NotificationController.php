<?php

namespace App\Http\Controllers\User;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Models\UserNotification;
use App\Models\Notification;
use App\Models\User;
use Auth;
use App\Classes\FirebaseNotify;


class NotificationController extends Controller
{

    public function __construct()
    {
        $this->middleware('auth');
    }

    public function order_notf_count($id)
    {
        $data = UserNotification::where('user_id','=',$id)->where('is_read','=',0)->get()->count();
        return response()->json($data);            
    } 

    public function order_notf_clear($id)
    {
        $data = UserNotification::where('user_id','=',$id);
        $data->delete();        
    } 

    public function single_notf_clear($id)
    {
        $data = UserNotification::where('id','=',$id);
        $data->delete();        
    } 

    public function order_notf_show($id)
    {
        $datas = UserNotification::where('user_id','=',$id)->get();
        if($datas->count() > 0){
          foreach($datas as $data){
            $data->is_read = 1;
            $data->update();
          }
        }       
        return view('user.notification.order',compact('datas'));           
    } 

    public function order_notf_show_api($id)
    {
        try{
            $datas = UserNotification::where('user_id','=',$id)->get();
            if($datas->count() > 0){
            foreach($datas as $data){
                $data->is_read = 1;
                $data->update();
            }
            }
                   
            return response()->json($datas);  
            
        
        } 
        catch (\Exception $e) 
        {
            echo($e);
        }     
    } 

    public function saveToken(Request $request)
    {
        try{
            $user = Auth::user();
            $user->device_token = $request->token;
            $user->save();

            return response()->json(['status' => 'success', 'details' => "Token updated"]);
        } 
        catch (\Exception $e) 
        {
            echo($e);
        }    
    }

    

}
