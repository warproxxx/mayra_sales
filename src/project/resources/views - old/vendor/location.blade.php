@extends('layouts.vendor')

@section('content')

<div class="content-area">
            <div class="mr-breadcrumb">
              <div class="row">
                <div class="col-lg-12">
                    <h4 class="heading">Locations</h4>
                    <ul class="links">
                      <li>
                        <a href="{{ route('vendor-dashboard') }}">{{ $langg->lang441 }} </a>
                      </li>
                      <li>
                        <a href="javascript:;">{{ $langg->lang452 }}</a>
                      </li>
                      <li>
                        <a href="{{ route('vendor-location-index') }}">Locations</a>
                      </li>
                    </ul>
                </div>
              </div>
            </div>
            <div class="social-links-area">
            <div class="gocover" style="background: url({{asset('assets/images/'.$gs->admin_loader)}}) no-repeat scroll center center rgba(45, 45, 45, 0.5);"></div>
              <form id="geniusform" class="form-horizontal" action="{{ route('vendor-location-update') }}" method="POST">   
              {{ csrf_field() }}

              @include('includes.admin.form-both')  

                <div class="row">
                  <label class="control-label col-sm-3" for="facebook">Location</label>
                  <div class="col-sm-6">
                  <select name="shop_location" class="location selectors nice">
										@foreach(DB::table('locations')->get() as $location)
											<option value="{{$location->id}}" {{ ($data->user_location == $location->id) ? 'selected' : '' }} >{{$location->location}}</option>
										@endforeach
											</select>
                  </div>
                </div>

                <div class="row">
                  <div class="col-12 text-center">
                    <button type="submit" class="submit-btn">{{ $langg->lang530 }}</button>
                  </div>
                </div>
              </form>
            </div>
          </div>

@endsection