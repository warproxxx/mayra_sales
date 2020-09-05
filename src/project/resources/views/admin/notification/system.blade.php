@extends('layouts.admin')

@section('content')

<input type="hidden" id="headerdata" value="{{ __('ORDER') }}">

                    <div class="content-area">
                        <div class="mr-breadcrumb">
                            <div class="row">
                                <div class="col-lg-12">
                                        <h4 class="heading">{{ __('System Notifications') }}</h4>
                                        <ul class="links">
                                            <li>
                                                <a href="{{ route('system-notifications-show') }}">{{ __('Dashboard') }} </a>
                                            </li>
                                            <li>
                                                <a href="javascript:;">{{ __('System Notification') }}</a>
                                            </li>
                                        </ul>
                                </div>
                            </div>
                        </div>
                        <div class="product-area">
                            <div class="row">

                                
                                <div class="col-lg-12">

        
                                    <div class="mr-table allproduct">
                                        @include('includes.admin.form-success') 

                                        <h5 class="heading">Expiring Accounts</h2><br/>
                                        <div class="table-responsiv" style="width:80%; padding-left: 20%">
                                        <div class="gocover" style="background: url({{asset('assets/images/'.$gs->admin_loader)}}) no-repeat scroll center center rgba(45, 45, 45, 0.5);"></div>
                                                <table id="geniustable" class="table table-hover dt-responsive" cellspacing="0" width="50%">
                                                    <thead>
                                                        <tr>
                                                            <th>{{ __('User') }}</th>
                                                            <th>{{ __('Expiring In') }}</th>
                                                            <th>{{ __('Action') }}</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        @foreach($expiring_notifications as $notification)
                                                            <td><a href="{{ route('admin-user-show',$notification->user_id) }}">{{ $notification->user_id }}</a></td>
                                                            <td>{{ $notification->expiring_in }} days</td>
                                                            <td><a href="{{ route('admin-user-show',$notification->user_id) }}" class="btn btn-primary product-btn"><i class="fa fa-eye"></i> User Details </a>
                                                                <a href="{{ route('system-mark-read',$notification->id) }}" class="btn btn-primary product-btn"><i class="fa fa-eye"></i> Mark as Read </a></td>
                                                        @endforeach
                                                    </tbody>
                                                    
                                                </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

@endsection