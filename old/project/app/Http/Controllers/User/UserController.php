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
use App\Models\SubscriptionPayment;

class UserController extends Controller
{
    public function __construct()
    {
        $this->middleware('auth');
    }

    public function index()
    {
        $user = Auth::user();  

        if ($user != null)
        {
            if (time() > $user->token_expirity)
            {
                return redirect()->route('user-logout');
            }
        }

        return view('user.dashboard',compact('user'));
    }

    public function profile()
    {
        $user = Auth::user();  
        return view('user.profile',compact('user'));
    }

    public function api_profile()
    {
        return Auth::user();  
    }

    public function profileupdate(Request $request)
    {
        //--- Validation Section

        $rules =
        [
            'photo' => 'mimes:jpeg,jpg,png,svg'
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
        $user = Auth::user();
        $selected = SubscriptionPayment::where('user_id', $user->id)->where('paid', 0)->get();

        if($selected->isNotEmpty())
        {
            return redirect()->route('user-subscription-payment', ['order'=> $selected[0]->id]);
        }
        else
        {
            $subs = Subscription::findOrFail($id);
            $gs = Generalsetting::findOrfail(1);
            
            $package = $user->subscribes()->where('status',1)->orderBy('id','desc')->first();
            if($gs->reg_vendor != 1)
            {
                return redirect()->back();
            }
            return view('user.package.details',compact('user','subs','package'));
        }
    }

    public function vendorrequestsub(Request $request)
    {
        $this->validate($request, [
            'shop_name'   => 'unique:users',
           ],[ 
               'shop_name.unique' => 'This shop name has already been taken.'
            ]);
        $user = Auth::user();


        $sub = new SubscriptionPayment;
        $sub->user_id = $user->id;
        $sub->subscription_id = $request->subs_id;
        $sub->memo = md5(uniqid(rand(), true));
        $sub->shop_name = $request->shop_name;
        $sub->shop_message = $request->shop_message;
        $sub->save();   

        return redirect()->route('user-subscription-payment', ['order'=> $sub->id]);
    }

    public function transact()
    {
        $order_id = $_GET['order'];
        $selected = SubscriptionPayment::where('id', $order_id)->where('paid', 0)->first();

        $order_id = $selected->memo;

        $payment_status = "PAID";

        if ($selected->paid == 0)
            $payment_status = "UNPAID";


        $pay_amount = Subscription::where('id', $selected->subscription_id)->first()->price;
        $id = $_GET['order'];
        return view('front.subscription_transact',compact('id','order_id', 'pay_amount', 'payment_status'));
    }

    public function remove_transaction($id)
    {
        $file = SubscriptionPayment::where('id', $id)->first(); // File::find($id)
        $file->delete();
        return redirect()->route('user-package');
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
