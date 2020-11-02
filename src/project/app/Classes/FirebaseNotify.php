<?php
namespace App\Classes;

use App\Models\User;


class FirebaseNotify
{
    public function sendNotification($title, $body, $order_id, $user_id)
    {

        $firebaseToken = User::where('id', '=', $user_id)->pluck('device_token')->all();
        $SERVER_API_KEY = 'AAAAAGUwyZc:APA91bF7_JJYb4GQZtjyM0meXoYnddOkMUOENVsHo49TunX1YCYGlx7JCS7B8CiTYZPV_ycfNJqdg8cnEJxQ0KBsI2mIgUqu8Xri_h0Sp2lKsfG6Cd1B7-xqMzA8H_H96UZqxhuMgP32';

        $data = [

            "registration_ids" => $firebaseToken,
            "notification" => [
                "title" => $title,
                "body" => $body,  
            ],
            "data" =>
            [
                "order_id" => $order_id,
                "click_action" => "FLUTTER_NOTIFICATION_CLICK"
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
        return $response;
    }
}