<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Message extends Model
{
    protected $fillable = ['conversation_id','message','sent_user','recieved_user','file'];
	public function conversation()
	{
	    return $this->belongsTo('App\Models\Conversation');
	}
}
