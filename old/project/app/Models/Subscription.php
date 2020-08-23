<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Subscription extends Model
{
    protected $fillable = ['title','currency','currency_code','price','days','allowed_products','details','percentage_commission','custom_shop'];
    public $timestamps = false;
}