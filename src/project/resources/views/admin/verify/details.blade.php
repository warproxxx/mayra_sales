@extends('layouts.admin') 
     
@section('styles')


@endsection


@section('content')
    <div class="content-area">
                        <div class="mr-breadcrumb">
                            <div class="row">
                                <div class="col-lg-12">
                                        <h4 class="heading">Subscription Details <a class="add-btn" href="{{ route('admin.dashboard') }}"><i class="fas fa-arrow-left"></i> {{ $langg->lang550 }}</a></h4>
                                </div>
                            </div>
                        </div>

                        <div class="order-table-wrap">
                            @include('includes.admin.form-both')
                            <div class="row">

                                <div class="col-lg-6">
                                    <div class="special-box">
                                        <div class="heading-area">
                                            <h4 class="title">
                                                Subscription Payment Details
                                            </h4>
                                        </div>
                                        <div class="table-responsive-sm">
                                            <table class="table">
                                                <tbody>
                                                    <tr>
                                                        <th class="45%" width="45%">User Email</th>
                                                        <td width="10%">:</td>
                                                        <td class="45%" width="45%">{{$user->email}}</td>
                                                    </tr>

                                                    <tr>
                                                        <th class="45%" width="45%">Contact</th>
                                                        <td width="10%">:</td>
                                                        <td class="45%" width="45%">{{$user->phone}}</td>
                                                    </tr>

                                                    <tr>
                                                        <th class="45%" width="45%">Payment Method</th>
                                                        <td width="10%">:</td>
                                                        <td class="45%" width="45%">{{$user->method}}</td>
                                                    </tr>

                                                    <tr>
                                                        <th class="45%" width="45%">Transaction ID</th>
                                                        <td width="10%">:</td>
                                                        <td class="45%" width="45%">{{$user->txn_id4}}</td>
                                                    </tr>

                                                    <tr>
                                                        <th class="45%" width="45%">Subscription Plan</th>
                                                        <td width="10%">:</td>

                                                        @if($user->subscription_type == "renew")
                                                            <td class="45%" width="45%">Renew {{$user->title}} for {{ $user->days }} days for {{ $user->currency }} {{ $user->price }}</td>
                                                        @else    
                                                            <td class="45%" width="45%">{{$user->title}} for {{ $user->days }} days costing {{ $user->currency }} {{ $user->price }}</td>
                                                        @endif
                                                    </tr>
                                        
                                                    
                                                    <tr>
                                                        <th width="45%">Transaction Screenshot</th>
                                                        <td width="10%">:</td>
                                                        
                                                        <td width="45%">
                                                            @if(is_null($user->txn_image))
                                                                Not Uploaded
                                                            @else
                                                                <a target="_blank" href="/assets/images/users/{{$user->txn_image}}" ><img src="/assets/images/users/{{$user->txn_image}}"></a>
                                                            @endif
                                                        </td>
                                                    </tr> 
                                                </tbody>
                                            </table>
                                        </div>
                                        <div class="footer-area">
                                            &nbsp;&nbsp;<a href="{{route('admin-payments-approve', $user->id) }}" class="mybtn1"><i class="fas fa-check"></i>Approve</a>
                                            &nbsp;&nbsp;<a href="{{route('admin-payments-reject', $user->id) }}" class="mybtn1"><i class="fas fa-ban"></i>Reject</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
    </div>            
@endsection