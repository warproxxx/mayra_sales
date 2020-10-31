<?php

namespace App\Http\Controllers\User;

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
        Auth::user()->update(['device_token'=>$request->token]);
        return response()->json(['token saved successfully.']);
    }

  

    /**

     * Write code on Method

     *

     * @return response()

     */

    public function sendNotification(Request $request)
    {

        $firebaseToken = User::whereNotNull('device_token')->pluck('device_token')->all();
        $SERVER_API_KEY = 'AAAA1n09VQY:APA91bHnpqAyN8e7dwfMpsGYYIkTwWEb8mRatgRSgCmqU7vEowL1Kn4VztaF_ljwWBOKM5TeYL4q1MZ66Wkm-DvTHjF43y9paU0nEIcicRqcCX6NN8O8FtHb8cKGD__y4NxUhj1hSj_m';

        $data = [

            "registration_ids" => $firebaseToken,
            "notification" => [
                "title" => $request->title,
                "body" => $request->body,  
            ]
        ];

        $dataString = json_encode($data);
    
        $headers = [
            'Authorization: key=' . $SERVER_API_KEY,
            'Content-Type: application/json',
        ];


        $ch = curl_init();
      

        curl_setopt($ch, CURLOPT_URL, 'https://fcm.googleapis.com/fcm/send');
        curl_setopt($ch, CURLOPT_POST, true);
        curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $dataString);

        $response = curl_exec($ch);

        dd($response);

    }

}
