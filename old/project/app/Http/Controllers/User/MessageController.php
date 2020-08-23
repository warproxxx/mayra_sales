<?php

namespace App\Http\Controllers\User;

use App\Classes\GeniusMailer;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Auth;
use App\Models\Conversation;
use App\Models\Message;
use App\Models\AdminUserConversation;
use App\Models\AdminUserMessage;
use App\Models\Generalsetting;
use App\Models\Notification;
use App\Models\User;


class MessageController extends Controller
{
    public function __construct()
    {
        $this->middleware('auth');
    }

   public function messages()
    {
        $user = Auth::guard('web')->user();
        $convs = Conversation::where('sent_user','=',$user->id)->orWhere('recieved_user','=',$user->id)->get();
        return view('user.message.index',compact('user','convs'));            
    }

    public function message($id)
    {
            $user = Auth::guard('web')->user();
            $conv = Conversation::findOrfail($id);
            return view('user.message.create',compact('user','conv', 'order'));                 
    }

    public function messagedelete($id)
    {
            $conv = Conversation::findOrfail($id);
            if($conv->messages->count() > 0)
            {
                foreach ($conv->messages as $key) {
                    $key->delete();
                }
            }
            $conv->delete();
            return redirect()->back()->with('success','Message Deleted Successfully');                 
    }

    public function swap_dispute($id)
    {
            $conv = Conversation::findOrfail($id);
            $user = Auth::guard('web')->user();
            $new_disp = 1 - $conv->is_dispute;
            Conversation::where('id', $id)->update(array('is_dispute' => $new_disp));

            $message = "Buyer has closed a dispute";
            $dispute_type = "dispute_close";
            if ($new_disp == 1)
            {
                $message = "Buyer has opened a dispute. Admins will now handle this case";
                $dispute_type = "dispute_open";
            }

            $msg = new Message();
            $msg->conversation_id = $conv->id;
            $msg->message = $message;
            $msg->sent_user = 0;
            $msg->save();

            $notification = new Notification;
            $notification->conversation_id = $conv->id;
            $notification->vendor_id = $conv->recieved_user;
            $notification->type = $dispute_type;
            $notification->save();

            $notification = new Notification;
            $notification->conversation_id = $conv->id;
            $notification->admin_id = 1;
            $notification->type = $dispute_type;
            $notification->save();

            $conv = Conversation::findOrfail($id);

            return view('user.message.create',compact('user','conv', 'order'));                     
    }

    public function swap_open($id)
    {
        $conv = Conversation::findOrfail($id);
        $user = Auth::guard('web')->user();
        $new_closed = 1 - $conv->closed;
        Conversation::where('id', $id)->update(array('closed' => $new_closed));

        $conv = Conversation::findOrfail($id);

        $notification = new Notification;
        $notification->conversation_id = $conv->id;
        $notification->vendor_id = $conv->recieved_user;
        $notification->type = "vendor_received";
        $notification->save();

        $msg = new Message();
        $msg->conversation_id = $conv->id;
        $msg->message = "Buyer has confirmed receiving an item";
        $msg->sent_user = 0;
        $msg->save();

        return view('user.message.create',compact('user','conv', 'order'));                   
    }

    public function msgload($id)
    {
            $conv = Conversation::findOrfail($id);
            return view('load.usermsg',compact('conv'));                 
    }  

    //Send email to user
    public function usercontact(Request $request)
    {
        $data = 1;
        $user = User::findOrFail($request->user_id);
        $vendor = User::where('username','=',$request->username)->first();

        if(empty($vendor))
        {
            $data = 0;
            return response()->json($data);   
        }

        $subject = $request->subject;
        $to = $vendor->username;
        $from = $request->username;

        $conv = Conversation::where('sent_user','=',$user->id)->where('subject','=',$subject)->first();
        
        if(isset($conv)){
            $msg = new Message();
            $msg->conversation_id = $conv->id;
            $msg->message = $request->message;
            $msg->sent_user = $user->id;
            $msg->save();

            $notification = new Notification;
            $notification->conversation_id = $conv->id;
            $notification->vendor_id = $conv->received_user;
            $notification->type = "vendor";
            $notification->save();

            return response()->json($data);   
        }
        else{
            $message = new Conversation();
            $message->subject = $subject;
            $message->sent_user= $request->user_id;
            $message->recieved_user = $vendor->id;
            $message->message = $request->message;
            $message->save();

            $msg = new Message();
            $msg->conversation_id = $message->id;
            $msg->message = $request->message;
            $msg->sent_user = $request->user_id;;
            $msg->save();

            $notification = new Notification;
            $notification->conversation_id = $message->id;
            $notification->vendor_id = $request->user_id;
            $notification->type = "vendor";
            $notification->save();

            return response()->json($data);   
        }
    }

    public function postmessage(Request $request)
    {
        $msg = new Message();
        $input = $request->all();  
        $msg->fill($input)->save();
        //--- Redirect Section     
        $msg = 'Message Sent!';

        $notification = new Notification;
        $notification->conversation_id = $request->conversation_id;
        $notification->vendor_id = $request->reciever;
        $notification->type = "vendor";
        $notification->save();

        #send admin notification if disputed
        $conv = Conversation::where('id','=',$request->conversation_id)->first();
        if ($conv->is_dispute == 1)
        {
            $notification = new Notification;
            $notification->conversation_id = $request->conversation_id;
            $notification->admin_id = 1;
            $notification->type = "admin";
            $notification->save();
        }

        return response()->json($msg);      
    }

    public function adminmessages()
    {
            $user = Auth::guard('web')->user();
            $convs = AdminUserConversation::where('type','=','Ticket')->where('user_id','=',$user->id)->get();
            return view('user.ticket.index',compact('convs'));            
    }

    public function adminDiscordmessages()
    {
            $user = Auth::guard('web')->user();
            $convs = Conversation::where('is_dispute','=',1)->get();
            print_r($convs);
            return view('user.dispute.index',compact('convs'));            
    }

    public function messageload($id)
    {
            $conv = AdminUserConversation::findOrfail($id);
            return view('load.usermessage',compact('conv'));                 
    }   

    public function adminmessage($id)
    {
            $conv = AdminUserConversation::findOrfail($id);
            return view('user.ticket.create',compact('conv'));                 
    }   

    public function adminmessagedelete($id)
    {
            $conv = AdminUserConversation::findOrfail($id);
            if($conv->messages->count() > 0)
            {
                foreach ($conv->messages as $key) {
                    $key->delete();
                }
            }
            $conv->delete();
            return redirect()->back()->with('success','Message Deleted Successfully');                 
    }

    public function adminpostmessage(Request $request)
    {
        $msg = new AdminUserMessage();
        $input = $request->all();  
        $msg->fill($input)->save();
        $notification = new Notification;
        $notification->conversation_id = $msg->conversation->id;
        $notification->save();
        //--- Redirect Section     
        $msg = 'Message Sent!';
        return response()->json($msg);      
        //--- Redirect Section Ends  
    }

    public function adminusercontact(Request $request)
    {
        $data = 1;
        $user = Auth::guard('web')->user();        
        $gs = Generalsetting::findOrFail(1);
        $subject = $request->subject;
        $to = $gs->email;
        $from = $user->email;
        $msg = "Email: ".$from."\nMessage: ".$request->message;
        if($gs->is_smtp == 1)
        {
            $data = [
            'to' => $to,
            'subject' => $subject,
            'body' => $msg,
        ];

        $mailer = new GeniusMailer();
        $mailer->sendCustomMail($data);
        }
        else
        {
            $headers = "From: ".$gs->from_name."<".$gs->from_email.">";
        mail($to,$subject,$msg,$headers);
        }
        if($request->type == 'Ticket'){
            $conv = AdminUserConversation::where('type','=','Ticket')->where('user_id','=',$user->id)->where('subject','=',$subject)->first(); 
        }
        else{
            $conv = AdminUserConversation::where('type','=','Dispute')->where('user_id','=',$user->id)->where('subject','=',$subject)->first(); 
        }

        if(isset($conv)){
            $msg = new AdminUserMessage();
            $msg->conversation_id = $conv->id;
            $msg->message = $request->message;
            $msg->user_id = $user->id;
            $msg->save();
            return response()->json($data);   
        }
        else{
            $message = new AdminUserConversation();
            $message->subject = $subject;
            $message->user_id= $user->id;
            $message->message = $request->message;
            $message->order_number = $request->order;
            $message->type = $request->type;
            $message->save();
            $notification = new Notification;
            $notification->conversation_id = $message->id;
            $notification->save();
            $msg = new AdminUserMessage();
            $msg->conversation_id = $message->id;
            $msg->message = $request->message;
            $msg->user_id = $user->id;
            $msg->save();
            return response()->json($data);   

        }
}
}