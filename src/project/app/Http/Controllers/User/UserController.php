<?php

namespace App\Http\Controllers\User;

use App\Classes\GeniusMailer;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Auth;
use Illuminate\Support\Facades\Input;
use Validator;
use Carbon\Carbon;
use Illuminate\Support\Facades\Hash;
use App\Models\Subscription;
use App\Models\Generalsetting;
use App\Models\UserSubscription;
use App\Models\FavoriteSeller;
use App\Models\PaymentGateway;
use Log;
use Session;

class UserController extends Controller
{
    public function __construct()
    {
        $this->middleware('auth');
    }

    public function index()
    {
        $user = Auth::user();  
        return view('user.dashboard',compact('user'));
    }

    public function profile()
    {
        $user = Auth::user();  
        return view('user.profile',compact('user'));
    }

    public function profileupdate(Request $request)
    {
        //--- Validation Section

        $rules =
        [
            'photo' => 'mimes:jpeg,jpg,png,svg',
            'email' => 'unique:users,email,'.Auth::user()->id
        ];


        $validator = Validator::make(Input::all(), $rules);
        
        if ($validator->fails()) {
          return response()->json(array('errors' => $validator->getMessageBag()->toArray()));
        }
        //--- Validation Section Ends
        $input = $request->all();  
        $data = Auth::user();        
            if ($file = $request->file('photo')) 
            {              
                $name = time().$file->getClientOriginalName();
                $file->move('assets/images/users/',$name);
                if($data->photo != null)
                {
                    if (file_exists(public_path().'/assets/images/users/'.$data->photo)) {
                        unlink(public_path().'/assets/images/users/'.$data->photo);
                    }
                }            
            $input['photo'] = $name;
            } 
        $data->update($input);
        $msg = 'Successfully updated your profile';
        return response()->json($msg); 
    }

    public function resetform()
    {
        return view('user.reset');
    }

    public function reset(Request $request)
    {
        $user = Auth::user();
        if ($request->cpass){
            if (Hash::check($request->cpass, $user->password)){
                if ($request->newpass == $request->renewpass){
                    $input['password'] = Hash::make($request->newpass);
                }else{
                    return response()->json(array('errors' => [ 0 => 'Confirm password does not match.' ]));     
                }
            }else{
                return response()->json(array('errors' => [ 0 => 'Current password Does not match.' ]));   
            }
        }
        $user->update($input);
        $msg = 'Successfully change your passwprd';
        return response()->json($msg);
    }


    public function package()
    {
        $user = Auth::user();
        $subs = Subscription::all();
        $package = $user->subscribes()->where('status',1)->orderBy('id','desc')->first();
        return view('user.package.index',compact('user','subs','package'));
    }


    public function vendorrequest($id)
    {

        $subs = Subscription::findOrFail($id);
        $gs = Generalsetting::findOrfail(1);
        $user = Auth::user();
        $package = $user->subscribes()->where('status',1)->orderBy('id','desc')->first();
        if($gs->reg_vendor != 1)
        {
            return redirect()->back();
        }

        $payment_gateways = PaymentGateway::where('user_id', '=', 0)->get();
        return view('user.package.details',compact('user','subs','package', 'payment_gateways'));
    }

    public function vendorrequestsub(Request $request)
    {
        
        try{

        

        $input = $request->all();  


        $rules =
        [
            'shop_name'   => 'unique:users',
        ];


        $validator = Validator::make(Input::all(), $rules);
        
        if ($validator->fails()) {
            return redirect()->back()->with('message', 'This shop name already exist');  
        }
            
            
        #There should be pending subscription which admins will later approve.
        if ($request->hasFile('txn_image')) 
        {
            //  Let's do everything here
            if ($request->file('txn_image')->isValid()) 
            {
                $image_name = date('mdYHis') . uniqid() .$request->file('txn_image')->getClientOriginalName();
                $input['txn_image'] = $image_name;
                $path = 'assets/images/users';
                $request->file('txn_image')->move($path,$image_name);
            }
        }



        $user = Auth::user();
        $package = $user->subscribes()->where('status',1)->orderBy('id','desc')->first();
        $settings = Generalsetting::findOrFail(1);
        
        
        $user->payment_request = 1;
        $user->update($input);
        

        if($settings->is_smtp == 1)
        {
            $data = [
                'to' => $user->email,
                'type' => "vendor_accept",
                'cname' => $user->name,
                'oamount' => "",
                'aname' => "",
                'aemail' => "",
                'onumber' => "",
            ];    
            $mailer = new GeniusMailer();
            $mailer->sendAutoMail($data);        
        }
        else
        {
            $headers = "From: ".$settings->from_name."<".$settings->from_email.">";
            mail($user->email,'Your Vendor Account Activation Request','Vendor Account Activation Request submitted. It will work once your payment has been verified by admin.',$headers);
        }

        return redirect()->route('user-dashboard')->with('success','Vendor Account Activation Request submitted. It will work once your payment has been verified by admin');
        } catch (\Exception $e) {
            echo($e->getMessage());
            echo("The exception was created on line: " . $e->getLine());

            
        }
    
    }


    public function favorite($id1,$id2)
    {
        $fav = new FavoriteSeller();
        $fav->user_id = $id1;
        $fav->vendor_id = $id2;
        $fav->save();
    }

    public function favorites()
    {
        $user = Auth::guard('web')->user();
        $favorites = FavoriteSeller::where('user_id','=',$user->id)->get();
        return view('user.favorite',compact('user','favorites'));
    }


    public function favdelete($id)
    {
        $wish = FavoriteSeller::findOrFail($id);
        $wish->delete();
        return redirect()->route('user-favorites')->with('success','Successfully Removed The Seller.');
    }


}
