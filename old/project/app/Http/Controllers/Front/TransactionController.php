<?php

namespace App\Http\Controllers\Front;

use App\Classes\GeniusMailer;
use App\Http\Controllers\Controller;
use App\Models\Order;
use Auth;
use DB;
use Illuminate\Http\Request;
use Session;
use Validator;

class TransactionController extends Controller
{
    public function transact()
    {
        $order_id = $_GET['order'];
        $selected = Order::select('pay_amount', 'payment_status', 'created_at')->where('order_number', $order_id)->get();

        $pay_amount = $selected[0]->pay_amount;
        $payment_status = $selected[0]->payment_status;
        $expirity_time = $selected[0]->created_at;

        $posted_date = strtotime ( $expirity_time );
        $expirity_date = $posted_date + 30 * 60;

        $current_time = time();
        $expirity_time = $expirity_date - $current_time;

        $expirity = "EXPIRED";
        
        if ($expirity_time > 0)
        {
            $expirity = strval(intval($expirity_time/60)) . " Minutes";
        }

        return view('front.transact',compact('order_id', 'pay_amount', 'payment_status', 'expirity'));
    }

}
