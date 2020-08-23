<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Order extends Model
{
	protected $fillable = ['user_id', 'cart', 'method','shipping', 'totalQty', 'pay_amount', 'txnid', 'charge_id', 'order_number', 'payment_status', 'customer_username','shipping_name', 'shipping_phone', 'shipping_address', 'shipping_city', 'shipping_zip', 'order_note', 'status'];

    public function vendororders()
    {
        return $this->hasMany('App\Models\VendorOrder');
    }

    public function tracks()
    {
        return $this->hasMany('App\Models\OrderTrack','order_id');
    }

}
