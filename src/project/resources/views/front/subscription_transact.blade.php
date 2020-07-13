@extends('layouts.front')

@section('styles')

<style type="text/css">
	
	    .root.root--in-iframe {
      background: #4682b447 !important;
    }
</style>

@endsection



@section('content')

<!-- Breadcrumb Area Start -->
<div class="breadcrumb-area">
	<div class="container">
		<div class="row">
			<div class="col-lg-12">
				<ul class="pages">
					<li>
						<a href="{{ route('front.index') }}">
						{{ $langg->lang17 }}
						</a>
					</li>
					<li>
						<a href="{{ route('front.checkout') }}">
						Transaction
						</a>
					</li>
				</ul>
			</div>
		</div>
	</div>
</div>
<!-- Breadcrumb Area End -->

<!-- Check Out Area Start -->
<section class="checkout">
		<div class="container">
			<div class="row" style="justify-content: center;">

			


	<div class="col-lg-8">

					<div class="checkout-area">
						<div class="tab-content" id="pills-tabContent">
							<div class="tab-pane fade show active" id="pills-step1" role="tabpanel" aria-labelledby="pills-step1-tab">
								<div class="content-box">
								
									<div class="content">

										<div class="billing-address">
											<h5 class="title">
												Transaction
											</h5>
											<div class="row">

											</div>
										</div>

										<center>
										Please send STEEM to the following address with the following details
										<br/><br/><br/>

										<b>Amount Remaining: </b> {{ $pay_amount }} STEEM<br/>
										<b>Account: </b> steem-keeper <br/>
										<b>Memo: </b> {{ $order_id }} <br/>
										<b>Payment Status: </b> {{ $payment_status }}<br/>


										<br/>Note: This page will automatically refresh every 5 seconds
										<div class="row">
											<div class="col-lg-12  mt-3">
												<div class="bottom-area paystack-area-btn">
													<button type="submit"  class="mybtn1" onClick="window.open('{{ route('user-package') }};">I HAVE PAID</button>

													<button type="submit"  class="mybtn1" onClick="window.open('https://steemlogin.com/sign/transfer?from=&to=steem-keeper&amount={{ $pay_amount }}STEEM&memo={{ $order_id }}','_blank');">Steemlogin</button>
													<button type="submit"  class="redbutton" onClick="window.open('{{ route('remove-subscription-payment', $id) }}');">Remove Transaction</button>
												</div>
												
											</div>
										</div>
										</center>
									</div>
								</div>
							</div>
						</div>
					</div>
	</div>

	</div>
		</div>
	</section>




@endsection

<meta http-equiv='refresh' content='5'>