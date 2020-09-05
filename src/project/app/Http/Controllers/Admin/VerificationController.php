<?php

namespace App\Http\Controllers\Admin;

use Carbon\Carbon;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Datatables;
use App\Models\Verification;
use App\Models\User;
use App\Models\Subscription;
use App\Models\UserSubscription;
use Log;


class VerificationController extends Controller
{
    public function __construct()
    {
        $this->middleware('auth:admin');
    }

    //*** JSON Request
    public function datatables($status)
    {
        if($status == 'Pending'){
            $datas = Verification::where('status','=','Pending')->get();
        }
        else{
           $datas = Verification::where('status','!=','Pending')->get();
        }
         
         return Datatables::of($datas)
                            ->addColumn('name', function(Verification $data) {
                                $name = isset($data->user->owner_name) ? '<a href="'. route('admin-vendor-show',$data->user->id) .'" target="_blank">'.$data->user->owner_name.'</a>' : 'Removed';
                                return  $name;
                            })
                            ->addColumn('email', function(Verification $data) {
                                $name = isset($data->user->email) ? $data->user->email : 'Removed';
                                return  $name;
                            })
                            ->editColumn('text', function(Verification $data) {
                                $details = strlen($data->text) > 250 ? substr($data->text,0,250).'...' : $data->text;
                                return  $details;
                            })
                            ->addColumn('status', function(Verification $data) {
                                $class = $data->status == 'Pending' ? '' : ($data->status == 'Verified' ? 'drop-success' : 'drop-danger');
                                $s = $data->status == 'Verified' ? 'selected' : '';
                                $ns = $data->status == 'Declined' ? 'selected' : '';
                                return '<div class="action-list"><select class="process select vendor-droplinks '.$class.'">'.
                                 '<option value="'. route('admin-vr-st',['id1' => $data->id, 'id2' => 'Pending']).'" '.$s.'>Pending</option>'.
                                '<option value="'. route('admin-vr-st',['id1' => $data->id, 'id2' => 'Verified']).'" '.$s.'>Verified</option>'.
                                '<option value="'. route('admin-vr-st',['id1' => $data->id, 'id2' => 'Declined']).'" '.$ns.'>Declined</option></select></div>';
                            }) 
                            ->addColumn('action', function(Verification $data) {
                                return '<div class="action-list"><a href="javascript:;" class="set-gallery" data-toggle="modal" data-target="#setgallery"><input type="hidden" value="'.$data->id.'"><i class="fas fa-paperclip"></i> View Attachments</a><a href="javascript:;" data-href="' . route('admin-vr-delete',$data->id) . '" data-toggle="modal" data-target="#confirm-delete" class="delete"><i class="fas fa-trash-alt"></i></a></div>';
                            }) 
                            ->rawColumns(['name','status','action'])
                            ->toJson(); //--- Returning Json Data To Client Side
    }

    public function payment_details($id)
    {
        $user = User::where('users.id','=',$id)
                ->join('subscriptions', 'users.subs_id', '=', 'subscriptions.id')
                ->select('users.*', 'subscriptions.title', 'subscriptions.days', 'subscriptions.currency', 'subscriptions.price') 
                ->first();

        return view('admin.verify.details',compact('user'));
    }

    public function payment_datatables()
    {
        $datas = User::where('payment_request','=',1)->get();
         
         return Datatables::of($datas)
                            ->addColumn('action', function(User $data) {
                                return '<a href="' . route('admin-payments-detail',$data->id) . '" class="btn btn-primary product-btn"><i class="fa fa-eye"></i> Details </a>';
                            }) 
                            ->rawColumns(['email', 'shop_name', 'method', 'action'])
                            ->toJson(); //--- Returning Json Data To Client Side
    }

    public function approve($id)
    {
        $today = Carbon::now()->format('Y-m-d');
        $user = User::where('id','=',$id)->first();

        $subs = Subscription::where('id','=',$user->subs_id)->first();
        $newday = strtotime($today);
        $lastday = strtotime($user->date);

        if (is_null($user->date) || $lastday < $newday)
        {
            $user->date = date('Y-m-d', strtotime($today.' + '.$subs->days.' days'));
            $user->is_vendor = 2;
            $user->payment_request = 0;
            $user->update();
        }
        else if ($lastday >= $newday)
        {
            $secs = $lastday-$newday;
            $days = $secs / 86400;
            $total = $days+$subs->days;
            $user->date = date('Y-m-d', strtotime($today.' + '.$total.' days'));
            $user->payment_request = 0;
            $user->update();
        }

        $sub = new UserSubscription;
        $sub->user_id = $user->id;
        $sub->subscription_id = $subs->id;
        $sub->title = $subs->title;
        $sub->currency = $subs->currency;
        $sub->currency_code = $subs->currency_code;
        $sub->price = $subs->price;
        $sub->days = $subs->days;
        $sub->allowed_products = $subs->allowed_products;
        $sub->details = $subs->details;
        $sub->method = $user->method;
        $sub->status = 1;
        $sub->save();

        return redirect()->route('admin-subscription-payment');
    }

    public function reject($id)
    {
        $user = User::where('id','=',$id)->first();
        $user->payment_request = 0;
        $user->update();
        
        return redirect()->route('admin-subscription-payment');
    }


    public function index()
    {
        return view('admin.verify.index');
    }

    public function pending()
    {
        return view('admin.verify.pending');
    }

    public function pending_payment()
    {
        return view('admin.verify.pending_payment');
    }

    public function show()
    {
        $data[0] = 0;
        $id = $_GET['id'];
        $prod1 = Verification::findOrFail($id);
        $prod = explode(',', $prod1->attachments);
        if(count($prod))
        {
            $data[0] = 1;
            $data[1] = $prod;
            $data[2] = $prod1->text;
            $data[3] = ''.route('admin-vr-st',['id1' => $prod1->id, 'id2' => 'Verified']).'';
            $data[4] = ''.route('admin-vr-st',['id1' => $prod1->id, 'id2' => 'Declined']).'';
        }
        return response()->json($data);              
    }  


    public function edit($id)
    {
        $data = Order::find($id);
        return view('admin.order.delivery',compact('data'));
    }


    //*** POST Request
    public function update(Request $request, $id)
    {
        //--- Logic Section
        $data = Order::findOrFail($id);

        $input = $request->all();


        // Then Save Without Changing it.
            $input['status'] = "completed";
            $data->update($input);
            //--- Logic Section Ends
    

        //--- Redirect Section          
        $msg = 'Status Updated Successfully.';
        return response()->json($msg);    
        //--- Redirect Section Ends     

    }


    //*** GET Request
    public function status($id1,$id2)
    {
        $user = Verification::findOrFail($id1);
        $user->status = $id2;
        $user->update();
        //--- Redirect Section        
        $msg[0] = 'Status Updated Successfully.';
        return response()->json($msg);      
        //--- Redirect Section Ends    

    }


    //*** GET Request
    public function destroy($id)
    {
        $data = Verification::findOrFail($id);
        $photos =  explode(',',$data->attachments);
        foreach($photos as $photo){
            unlink(public_path().'/assets/images/attachments/'.$photo);
        }
        $data->delete();
        //--- Redirect Section     
        $msg = 'Data Deleted Successfully.';
        return response()->json($msg);      
        //--- Redirect Section Ends    

    }






}
