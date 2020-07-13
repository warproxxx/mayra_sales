<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class SubscriptionPayment extends Model
{
   protected $fillable = ['user_id', 'subscription_id', 'paid', 'memo', 'shop_name', 'shop_message'];
}
