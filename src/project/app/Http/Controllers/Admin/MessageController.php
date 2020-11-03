<?php

namespace App\Http\Controllers\Admin;

use App\Classes\GeniusMailer;
use Datatables;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Input;
use Validator;
use App\Models\AdminUserConversation;
use App\Models\AdminUserMessage;
use App\Models\User;
use App\Models\UserNotification;
use App\Models\Generalsetting;
use App\Models\Conversation;
use App\Models\Message;
use App\Models\Notification;
use App\Models\VendorNotification;
use App\Classes\FirebaseNotify;


use Auth;
use Log;

class MessageController extends Controller
{
    public function __construct()
    {
        $this->middleware('auth:admin');
    }

    //*** JSON Request
    public function datatables($type)
    {
         $datas =  Conversation::where('is_dispute','=',1)->get();
         
         return Datatables::of($datas)
                            ->editColumn('created_at', function(Conversation $data) {
                                $date = $data->created_at->diffForHumans();
                                return  $date;
                            })
                            ->addColumn('action', function(Conversation $data) {
                                return '<div class="action-list"><a href="' . route('admin-message-show',$data->id) . '"> <i class="fas fa-eye"></i> Details</a></div>';
                            }) 
                            ->rawColumns(['action'])
                            ->toJson(); //--- Returning Json Data To Client Side
    }

    public function datatables_ticket($type)
    {
         $datas = AdminUserConversation::where('type','=',$type)->get();
         //--- Integrating This Collection Into Datatables
         return Datatables::of($datas)
                            ->editColumn('created_at', function(AdminUserConversation $data) {
                                $date = $data->created_at->diffForHumans();
                                return  $date;
                            })
                            ->addColumn('name', function(AdminUserConversation $data) {
                                $name = $data->user->name;
                                return  $name;
                            })
                            ->addColumn('action', function(AdminUserConversation $data) {
                                return '<div class="action-list"><a href="' . route('admin-ticket-show',$data->id) . '"> <i class="fas fa-eye"></i> Details</a><a href="javascript:;" data-href="' . route('admin-message-delete',$data->id) . '" data-toggle="modal" data-target="#confirm-delete" class="delete"><i class="fas fa-trash-alt"></i></a></div>';
                            }) 
                            ->rawColumns(['action'])
                            ->toJson(); //--- Returning Json Data To Client Side
    }

    //*** GET Request
    public function message_ticket($id)
    {
        $conv = AdminUserConversation::findOrfail($id);
        return view('admin.message.create_ticket',compact('conv'));                 
    }   

    //*** GET Request
    public function messageshow_ticket($id)
    {
        $conv = AdminUserConversation::findOrfail($id);
        return view('load.message',compact('conv'));                 
    }   

    //*** GET Request
    public function messagedelete_ticket($id)
    {
        $conv = AdminUserConversation::findOrfail($id);
        if($conv->messages->count() > 0)
         {
           foreach ($conv->messages as $key) {
            $key->delete();
            }
         }
          $conv->delete();
        //--- Redirect Section     
        $msg = 'Data Deleted Successfully.';
        return response()->json($msg);      
        //--- Redirect Section Ends               
    }

    //*** POST Request
    public function postmessage_ticket(Request $request)
    {
        $msg = new AdminUserMessage();
        $input = $request->all();  
        $msg->fill($input)->save();
        //--- Redirect Section     
        $msg = 'Message Sent!';

        $conv = AdminUserConversation::findOrfail($request->conversation_id);

        $notification = new UserNotification;
        $notification->ticket_id = $request->conversation_id;
        $notification->user_id = $conv->user_id;
        $notification->save();
        
        $order = Order::where('order_number','=',$conv->order_number)->first();

        $firebase = new FirebaseNotify();
        $response = $firebase->sendNotification("New Notification", "You have a new message", $order->id, $conv->user_id);

        return response()->json($msg);      
        //--- Redirect Section Ends    
    }

    //*** GET Request
    public function index()
    {
        return view('admin.message.index');            
    }

    //*** GET Request
    public function disputes()
    {
        return view('admin.message.dispute');            
    }

     //*** GET Request
     public function message($id)
     {
         $conv = Conversation::findOrfail($id);
         return view('admin.message.create',compact('conv'));                 
     }   
 
     //*** GET Request
     public function messageshow($id)
     {
         $conv = Conversation::findOrfail($id);
         return view('load.message',compact('conv'));                 
     }

    public function dispute($id)
    {
        $conv = Conversation::findOrfail($id);
        $user = Auth::guard('web')->user();
        $new_disp = 1 - $conv->is_dispute;
        Conversation::where('id', $id)->update(array('is_dispute' => $new_disp));

        $message = "Admin has closed the dispute";

        $msg = new Message();
        $msg->conversation_id = $conv->id;
        $msg->message = $message;
        $msg->sent_user = 0;
        $msg->save();

        $notification = new UserNotification();
        $notification->conversation_id = $conv->id;
        $notification->user_id = $conv->sent_user;
        $notification->save();

        $order = Order::where('order_number','=',$conv->order_number)->first();

        $firebase = new FirebaseNotify();
        $response = $firebase->sendNotification("New Notification", "You have a new message", $order->id, $conv->user_id);

        $notification = new VendorNotification();
        $notification->conversation_id = $conv->id;
        $notification->user_id = $conv->recieved_user;
        $notification->save();

        $conv = Conversation::findOrfail($id);

        return view('admin.message.dispute', compact('convs'));                 
    }

    //*** GET Request
    public function messagedelete($id)
    {
        $conv = AdminUserConversation::findOrfail($id);
        if($conv->messages->count() > 0)
         {
           foreach ($conv->messages as $key) {
            $key->delete();
            }
         }
          $conv->delete();
        //--- Redirect Section     
        $msg = 'Data Deleted Successfully.';
        return response()->json($msg);      
        //--- Redirect Section Ends               
    }

    //*** POST Request
    public function postmessage(Request $request)
    {
        $input = $request->all(); 
        
        $msg = new Message();
        $msg->conversation_id = $input['conversation_id'];
        $msg->message = $input['message'];
        $msg->sent_user = 0;
        $msg->save();


        $conv = Conversation::findOrfail($input['conversation_id']);

        $notification = new UserNotification();
        $notification->conversation_id = $input['conversation_id'];
        $notification->user_id = $conv->sent_user;
        $notification->save();

        $order = Order::where('order_number','=',$conv->order_number)->first();

        $firebase = new FirebaseNotify();
        $response = $firebase->sendNotification("New Notification", "You have a new message", $order->id, $conv->user_id);

        $notification = new VendorNotification();
        $notification->conversation_id = $input['conversation_id'];
        $notification->user_id = $conv->recieved_user;
        $notification->save();

        $msg = 'Message Sent!';

        return response()->json($msg);      
    }

    //*** POST Request
    public function usercontact(Request $request)
    {
        $data = 1;
        $admin = Auth::guard('admin')->user();
        $user = User::where('email','=',$request->to)->first();
        if(empty($user))
        {
            $data = 0;
            return response()->json($data);   
        }
        $to = $request->to;
        $subject = $request->subject;
        $from = $admin->email;
        $msg = "Email: ".$from."<br>Message: ".$request->message;
        $gs = Generalsetting::findOrFail(1);
        if($gs->is_smtp == 1)
        {

        $datas = [
            'to' => $to,
            'subject' => $subject,
            'body' => $msg,
        ];
        $mailer = new GeniusMailer();
         $mailer->sendCustomMail($datas);
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
            $msg = new AdminUserMessage();
            $msg->conversation_id = $message->id;
            $msg->message = $request->message;
            $msg->save();
            return response()->json($data);   
        }
    }
}