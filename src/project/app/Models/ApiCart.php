<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class ApiCart extends Model
{
    protected $fillable = ['user_id', 'qty', 'size_key', 'size_qty', 'size_price', 'size', 'color', 'stock', 'price', 'product_id', 'license', 'dp'];
    public $timestamps = false;
}
