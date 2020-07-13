<?php

namespace App\Http\Controllers\User;

use App\Models\Notification;
use App\Models\SocialProvider;
use App\Models\Socialsetting;
use App\Models\User;
use App\Http\Controllers\Controller;
use Auth;
use Config;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Session;
use Socialite;
use Redirect;

class SteemRegisterController extends Controller
{

    public function __construct()
    {
    //   $link = Socialsetting::findOrFail(1);
    //   Config::set('services.google.client_id', $link->gclient_id);
    //   Config::set('services.google.client_secret', $link->gclient_secret);
    //   Config::set('services.google.redirect', url('/auth/google/callback'));
    //   Config::set('services.facebook.client_id', $link->fclient_id);
    //   Config::set('services.facebook.client_secret', $link->fclient_secret);
    //   $url = url('/auth/facebook/callback');
    //   $url = preg_replace("/^http:/i", "https:", $url);
    //   Config::set('services.facebook.redirect', $url);
    }

    public function redirectToProvider($provider)
    {
        return Socialite::driver($provider)->redirect();
    }

    public function handleProviderCallback()
    {
        $req = request()->all();

        if (isset($req['access_token']))
        {

            $cURLConnection = curl_init();

            curl_setopt($cURLConnection, CURLOPT_URL, 'https://api.steemlogin.com/api/me');
            curl_setopt($cURLConnection, CURLOPT_RETURNTRANSFER, true);
            curl_setopt($cURLConnection, CURLOPT_HTTPHEADER, array(
                'Authorization: ' . $req['access_token']
            ));

            $validation = curl_exec($cURLConnection);
            curl_close($cURLConnection);

            $jsonArrayResponse = json_decode($validation);

            if(property_exists($jsonArrayResponse, "user"))
            {
                $user = User::where('username', '=', $jsonArrayResponse->user)->first();

                if ($user === null) {
                    $user = new User;
                    $user->username = $jsonArrayResponse->user;
                    $user->access_token = $req['access_token'];
                    $user->token_expirity = time() + $req['expires_in'];

                    $user->save();
            
                    $notification = new Notification;
                    $notification->user_id = $user->id;
                    $notification->save();
                }
                else
                {
                    $user->access_token = $req['access_token'];
                    $user->token_expirity = time() + $req['expires_in'];
                    $user->save();
                }

                Auth::loginUsingId($user->id, TRUE);

                if ($user->authorized == 0)
                {
                    return Redirect::to("https://steemlogin.com/authorize/opnmarket.com/?redirect_uri=http://opnmarket.local/authorized");
                }

                return view('user.dashboard',compact('user'));
            }
            else
            {
                print("Error! Invalid access token.");
            }

            
        }
        // Auth::guard('web')->login($user); 
        // return redirect()->route('user-dashboard');

    }

    public function authorized()
    {
        $user = Auth::user();
        $user->authorized = 1;
        $user->save();
        return view('user.dashboard',compact('user'));
    }
}
