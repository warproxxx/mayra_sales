@extends('layouts.front')
@section('content')
<!-- User Dashbord Area Start -->
<section class="user-dashbord">
    <div class="container">
        <div class="row">
            @include('includes.user-dashboard-sidebar')
            <div class="col-lg-8">
                <div class="user-profile-details">
                    <div class="order-details">

                        <div class="process-steps-area">
                            @include('includes.order-process')

                        </div>


                        <div class="header-area">
                            <h4 class="title">
                                {{ $langg->lang284 }}
                            </h4>
                        </div>
                        <div class="view-order-page">
                            <h3 class="order-code">{{ $langg->lang285 }} {{$order->order_number}} [{{$order->status}}]
                            </h3>

                            <p class="order-date">{{ $langg->lang301 }} {{date('d-M-Y',strtotime($order->created_at))}}
                            </p>

                            @if($order->dp == 1)

                            <div class="billing-add-area">
                                <div class="row">
                                    <div class="col-md-6">
                                        <h5>{{ $langg->lang292 }}</h5>

                                        <p>{{ $langg->lang798 }}:
                                             {!! $order->payment_status == 'Pending' ? "<span class='badge badge-danger'>". $langg->lang799 ."</span>":"<span class='badge badge-success'>". $langg->lang800 ."</span>" !!}
                                        </p>

                                        <p>{{ $langg->lang293 }}
                                             {{ $order->pay_amount }} {{$order->currency_sign}}
                                        </p>

                                    </div>
                                </div>
                            </div>

                            @else
                            <div class="shipping-add-area">
                                <div class="row">
                                    <div class="col-md-6">
                                        @if($order->shipping == "shipto")
                                        <h5>{{ $langg->lang302 }}</h5>
                                        <address>
                                            {{ $langg->lang288 }}
                                            {{$order->shipping_name == null ? $order->customer_name : $order->shipping_name}}<br>
                                            {{ $langg->lang290 }}
                                            {{$order->shipping_phone == null ? $order->customer_phone : $order->shipping_phone}}<br>
                                            {{ $langg->lang291 }}<br>
                                            {{$order->shipping_address == null ? $order->customer_address : $order->shipping_address}}<br>
                                            {{$order->shipping_city == null ? $order->customer_city : $order->shipping_city}}-{{$order->shipping_zip == null ? $order->customer_zip : $order->shipping_zip}}
                                        </address>
                                        @else
                                        <h5>{{ $langg->lang303 }}</h5>
                                        <address>
                                            {{ $langg->lang304 }} {{$order->pickup_location}}<br>
                                        </address>
                                        @endif

                                    </div>
                                    <div class="col-md-6">
                                        <h5>{{ $langg->lang305 }}</h5>
                                        @if($order->shipping == "shipto")
                                        <p>{{ $langg->lang306 }}</p>
                                        @else
                                        <p>{{ $langg->lang307 }}</p>
                                        @endif
                                    </div>
                                </div>
                            </div>
                            <div class="billing-add-area">
                                <div class="row">
                                    <div class="col-md-6">
                                        <h5>{{ $langg->lang292 }}</h5>

                                        <p>{{ $langg->lang798 }}
                                             {!! $order->payment_status == 'Pending' ? "<span class='badge badge-danger'>". $langg->lang799 ."</span>":"<span class='badge badge-success'>". $langg->lang800 ."</span>" !!}
                                        </p>



                                        <p>Amount:
                                            {{ $order->pay_amount }} {{$order->currency_sign}}
                                        </p>

                                        @if($order->method != "Cash On Delivery")

                                        <div class="print-order">
                                <a href="/transaction?order={{ $order->order_number }}" target="_blank"
                                    class="print-order-btn">
                                    <i class="fa fa-dollar"></i> View Transaction
                                </a>
                            </div>

                                                
                                                
                                        @endif
                                    </div>
                                </div>
                            </div>
                            @endif
                            <br>




                            <div class="table-responsive">
                                <h5>{{ $langg->lang308 }}</h5>
                                <table class="table table-bordered veiw-details-table">
                                    <thead>
                                        <tr>
                                            <th width="5%">{{ $langg->lang309 }}</th>
                                            <th width="35%">{{ $langg->lang310 }}</th>
                                            <th width="20%">{{ $langg->lang539 }}</th>
                                            <th>{{ $langg->lang314 }}</th>
                                            <th>{{ $langg->lang315 }}</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        @foreach($cart->items as $product)
                                        <tr>
                                            <td>{{ $product['item']['id'] }}</td>
                                            <td>
                                                <input type="hidden" value="{{ $product['license'] }}">

                                                @if($product['item']['user_id'] != 0)
                                                @php
                                                $user = App\Models\User::find($product['item']['user_id']);
                                                @endphp
                                                @if(isset($user))
                                                <a target="_blank"
                                                    href="{{ route('front.product', $product['item']['slug']) }}">{{strlen($product['item']['name']) > 30 ? substr($product['item']['name'],0,30).'...' : $product['item']['name']}}</a>
                                                @else
                                                <a target="_blank"
                                                    href="{{ route('front.product', $product['item']['slug']) }}">
                                                    {{strlen($product['item']['name']) > 30 ? substr($product['item']['name'],0,30).'...' : $product['item']['name']}}
                                                </a>
                                                @endif
                                                @else

                                                <a target="_blank"
                                                    href="{{ route('front.product', $product['item']['slug']) }}">
                                                    {{strlen($product['item']['name']) > 30 ? substr($product['item']['name'],0,30).'...' : $product['item']['name']}}
                                                </a>

                                                @endif
                                                @if($product['item']['type'] != 'Physical')
                                                @if($order->payment_status == 'Completed')
                                                @if($product['item']['file'] != null)
                                                <a href="{{ route('user-order-download',['slug' => $order->order_number , 'id' => $product['item']['id']]) }}"
                                                    class="btn btn-sm btn-primary">
                                                    <i class="fa fa-download"></i> {{ $langg->lang316 }}
                                                </a>
                                                @else
                                                <a target="_blank" href="{{ $product['item']['link'] }}"
                                                    class="btn btn-sm btn-primary">
                                                    <i class="fa fa-download"></i> {{ $langg->lang316 }}
                                                </a>
                                                @endif
                                                @if($product['license'] != '')
                                                <a href="javascript:;" data-toggle="modal" data-target="#confirm-delete"
                                                    class="btn btn-sm btn-info product-btn" id="license"><i
                                                        class="fa fa-eye"></i> {{ $langg->lang317 }}</a>
                                                @endif
                                                @endif
                                                @endif
                                            </td>
                                            <td>
                                                <b>{{ $langg->lang311 }}</b>: {{$product['qty']}} <br>
                                                @if(!empty($product['size']))
                                                <b>{{ $langg->lang312 }}</b>: {{ $product['item']['measure'] }}{{$product['size']}} <br>
                                                @endif
                                                @if(!empty($product['color']))
                                                <div class="d-flex mt-2">
                                                <b>{{ $langg->lang313 }}</b>:  <span id="color-bar" style="border: 10px solid {{$product['color'] == "" ? "white" : '#'.$product['color']}};"></span>
                                                </div>
                                                @endif

                                                    @if(!empty($product['keys']))

                                                    @foreach( array_combine(explode(',', $product['keys']), explode(',', $product['values']))  as $key => $value)

                                                        <b>{{ ucwords(str_replace('_', ' ', $key))  }} : </b> {{ $value }} <br>
                                                    @endforeach

                                                    @endif

                                                  </td>
                                            <td>{{$order->currency_sign}}{{round($product['item']['price'] * $order->currency_value,2)}}
                                            </td>
                                            <td>{{$order->currency_sign}}{{round($product['price'] * $order->currency_value,2)}}
                                            </td>

                                        </tr>
                                        @endforeach
                                    </tbody>
                                </table>

                                <div class="edit-account-info-div">
                                    <div class="form-group">
                                        <a class="back-btn" href="{{ route('user-orders') }}">{{ $langg->lang318 }}</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<div class="modal fade" id="confirm-delete" tabindex="-1" role="dialog" aria-labelledby="modal1" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">

            <div class="modal-header d-block text-center">
                <h4 class="modal-title d-inline-block">{{ $langg->lang319 }}</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>

            <div class="modal-body">
                <p class="text-center">{{ $langg->lang320 }} <span id="key"></span></p>
            </div>
            <div class="modal-footer justify-content-center">
                <button type="button" class="btn btn-danger" data-dismiss="modal">{{ $langg->lang321 }}</button>
            </div>
        </div>
    </div>
</div>

@endsection


@section('scripts')

<script type="text/javascript">
    $('#example').dataTable({
        "ordering": false,
        'paging': false,
        'lengthChange': false,
        'searching': false,
        'ordering': false,
        'info': false,
        'autoWidth': false,
        'responsive': true
    });
</script>
<script>
    $(document).on("click", "#tid", function (e) {
        $(this).hide();
        $("#tc").show();
        $("#tin").show();
        $("#tbtn").show();
    });
    $(document).on("click", "#tc", function (e) {
        $(this).hide();
        $("#tid").show();
        $("#tin").hide();
        $("#tbtn").hide();
    });
    $(document).on("submit", "#tform", function (e) {
        var oid = $("#oid").val();
        var tin = $("#tin").val();
        $.ajax({
            type: "GET",
            url: "{{URL::to('user/json/trans')}}",
            data: {
                id: oid,
                tin: tin
            },
            success: function (data) {
                $("#ttn").html(data);
                $("#tin").val("");
                $("#tid").show();
                $("#tin").hide();
                $("#tbtn").hide();
                $("#tc").hide();
            }
        });
        return false;
    });
</script>
<script type="text/javascript">
    $(document).on('click', '#license', function (e) {
        var id = $(this).parent().find('input[type=hidden]').val();
        $('#key').html(id);
    });
</script>
@endsection