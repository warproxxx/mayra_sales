<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Shipping extends Model
{
    protected $fillable = ['user_id', 'title', 'subtitle', 'price', 'long_price', 'threshold', 'free_threshold'];

    public $timestamps = false;

}