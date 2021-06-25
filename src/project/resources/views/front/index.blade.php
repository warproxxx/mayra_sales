@extends('layouts.front')

@section('content')

	@if($ps->slider == 1)

		@if(count($sliders))

			@include('includes.slider-style')
		@endif
	@endif


	@if($ps->slider == 1)
		<!-- Hero Area Start -->
		<section class="hero-area">
			@if($ps->slider == 1)

				@if(count($sliders))
					<div class="hero-area-slider">
						<div class="slide-progress"></div>
						<div class="intro-carousel">
							@foreach($sliders as $data)
								<div class="intro-content {{$data->position}}" style="background-image: url({{asset('assets/images/sliders/'.$data->photo)}})">
									<div class="container">
										<div class="row">
											<div class="col-lg-12">
												<div class="slider-content">
													<!-- layer 1 -->
													<div class="layer-1">
														<h4 style="font-size: {{$data->subtitle_size}}px; color: {{$data->subtitle_color}}" class="subtitle subtitle{{$data->id}}" data-animation="animated {{$data->subtitle_anime}}">{{$data->subtitle_text}}</h4>
														<h2 style="font-size: {{$data->title_size}}px; color: {{$data->title_color}}" class="title title{{$data->id}}" data-animation="animated {{$data->title_anime}}">{{$data->title_text}}</h2>
													</div>
													<!-- layer 2 -->
													<div class="layer-2">
														<p style="font-size: {{$data->details_size}}px; color: {{$data->details_color}}"  class="text text{{$data->id}}" data-animation="animated {{$data->details_anime}}">{{$data->details_text}}</p>
													</div>
													<!-- layer 3 -->
													<div class="layer-3">
														<a href="{{$data->link}}" target="_blank" class="mybtn1"><span>{{ $langg->lang25 }} <i class="fas fa-chevron-right"></i></span></a>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							@endforeach
						</div>
					</div>
				@endif

			@endif

		</section>
		<!-- Hero Area End -->
	@endif

	
	@if($ps->featured_category == 1)

	{{-- Slider buttom Category Start --}}
	<section class="slider-buttom-category d-none d-md-block">
		<div class="container">
			<div class="row category-list" style="">
				@foreach($categories->where('is_featured','=',1) as $cat)<!-- 
					<div class="category-list-item" style="margin:10px 15px; width: 320px; padding:0px; border: 1px solid #222">
						<a href="{{ route('front.category',$cat->slug) }}" class="single-category" style="border: none">
							<div class="left">
								<h5 class="title">
									{{ $cat->name }}
								</h5>
								<p class="count">
									{{ count($cat->products) }} {{ $langg->lang4 }}
								</p>
							</div>
							<div class="right">
								<img style="width:25px" src="{{asset('assets/images/categories/'.$cat->image) }}" alt="">
							</div>
						</a>
					</div> -->
					<style>
						.category-list{
							display: flex;
							flex-wrap: wrap;
							justify-content: center;
							/*align-items: stretch;*/
						}
						.category-list-item{
							display: flex;
							justify-content: space-between;
							align-items: center;
							width: 230px;
							border: 1px solid #aaa;
							padding:12px;
							margin: 4px 12px;
						}
						.category-list-item:hover {
							border: 1px solid ;
						  border-image-slice: 1;
							border-image-source: linear-gradient(to right, #ff85b2, #f885c2, #ed87d2, #de8ae1, #ca8fef, #ae9cfa, #90a7ff, #74b0ff, #54bfff, #2ecdff, #00d9ff, #00e5ff);
						  cursor: pointer;	
						  box-shadow: 2.5px 2.5px 5px 1px #aaa
						}

						.category-list .details .name{
							font-weight: bold;
							font-size: 0.85em;
							height: 38px;
							display: flex;
							align-items: center;
						}
						.category-list .details .item-count{
							font-size: 0.65em;
							color:#333;
						}
						.category-list .img{
							margin-left: 12px;
						}
						.category-list img{
							width:42px;
						}
					</style>
					<a href="{{ route('front.category',$cat->slug) }}">
						<div class="category-list-item">
							<div class="details">
								<div class="name">
										{{ $cat->name }}
								</div>
								<div class="item-count">
									{{ count($cat->products) }} {{ $langg->lang4 }}
								</div>
							</div>
							<div class="img">
								<img src="{{asset('assets/images/categories/'.$cat->image) }}" alt="category image not found">
							</div>
						</div>
					</a>
				@endforeach
			</div>
		</div>
	</section>
	{{-- Slider buttom banner End --}}

	@endif


		<style>
			.ads{
				display: flex; 
				flex-wrap: wrap;
				justify-content: space-between;
			}
			.ads .ad{
				width: 49%;
				min-width: 400px;
				margin: 20px auto;
				background-color: #ccc;
			}
			.ads .ad img{
				width: 100%;
			}
		</style>

		@if(count($feature_products)>0)		
		<!-- Trending Item Area Start -->
		<section  class="trending">
			<div class="container">
				<div class="row">
					<div class="col-lg-12 remove-padding">
						<div class="section-top">
							<h2 class="section-title">
								{{ $langg->lang26 }}
							</h2>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-lg-12 remove-padding">
							<div class="trending-item-slider">
								@foreach($feature_products as $prod)
									@include('includes.product.slider-product')
								@endforeach
							</div
					</div>

				</div>
			</div>
		</section>
		<!-- Tranding Item Area End -->
		<!-- Ads -->
		<div class="container remove-padding">
			<div class="ads">
				<div class="ad left">
					<img src="{{asset('assets/images/banners/1600053152104320674_2572119316359706_6563804097001371169_o.jpg')}}" alt="Your ad here">
				</div>

				<div class="ad right">
					<img src="{{asset('assets/images/banners/1602406594ujjwal baraili ad copy-min-min.jpg')}}" alt="Your ad here">
				</div>
			</div>
		</div>
		@endif	


		<!-- Premium Section Start -->
			<!-- Current Code copied from feature -->
				<section  class="trending">
					<div class="container">
						<div class="row">
							<div class="col-lg-12 remove-padding">
								<div class="section-top">
									<h2 class="section-title">
										Premium
									</h2>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-lg-12 remove-padding">
								<div class="trending-item-slider">
									@foreach($premium_products as $prod)
										@include('includes.product.slider-product')
									@endforeach
								</div>
							</div>

						</div>
					</div>
				</section>
				<div class="container remove-padding">
				<div class="ads">
					@foreach($top_small_banners as $img)
					@if($loop->index==0)
					<div class="ad left">
						<a class="banner-effect" href="{{ $img->link }}" target="_blank">
							<img src="{{asset('assets/images/banners/'.$img->photo)}}" alt="Ads">
						</a>
					</div>
					@endif
					@if($loop->index==1)
					<div class="ad right">
						<a class="banner-effect" href="{{ $img->link }}" target="_blank">
							<img src="{{asset('assets/images/banners/'.$img->photo)}}" alt="Ads">
						</a>
					</div>
					@endif
					@endforeach
				</div>
				</div>

		<!-- Previum Section End  -->


		<!-- Flash sale Section Start -->

		<style>
			.product-flash-section{
				display: flex;
				justify-content: space-between;
			}
			.product-flash-section .left{
				width: 100%;
				display: flex;
				flex-wrap: wrap;
			}
			
			.product-flash-section .ad{
				display: flex;
				justify-content: center;
				align-items: center;
				height: 270px;
				width: 250px;
				margin: 13px;
			}
			.product-flash-section .ad img{
				/*width: 100%;*/
				height: 100%;
				object-fit: contain;
			}
			@media screen and (max-width: 1200px) {
				.product-flash-section .right {
					display: flex;
					flex-wrap: wrap;
					margin: auto;
				}
			 	.product-flash-section .left{
					width: 100%;
					align-items: center;
					justify-content: center;
				}
				.product-flash-section{
					flex-wrap: wrap;
				}
				.product-flash-section .right .ad{
				margin: 12px 10px;
				background-color: #eee;
			}
		  	}
			@media screen and (max-width: 560px) {
			 	.product-flash-section .left{
					width: 100%;
					align-items: center;
					justify-content: center;
				}
				.product-flash-section .right .ad{
					display: none;
				}
		  	}

		</style>

				<section  class="trending">
					<div class="container">
						<div class="row">
							<div class="col-lg-12 remove-padding">
								<div class="section-top">
									<h2 class="section-title">
										Big Save
									</h2>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="product-flash-section">
									<div class="left">

									@foreach($bigsave_products as $prod)
											@include('includes.product.slider-product')
											@if($loop->index>=2 && (($loop->index+1)%3)==0)
											<div class="ad">
												<img src="{{asset('assets/images/ad.jpg')}}">
											</div>
											@endif
									@endforeach

									</div>
							</div>
						</div>
					</div>
				</section>


				<section  class="trending">
					<div class="container">
						<div class="row">
							<div class="col-lg-12 remove-padding">
								<div class="section-top">
									<h2 class="section-title">
										Best Seller
									</h2>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="product-flash-section">
								<div class="left">

									@foreach($bestsale_products as $prod)
											@include('includes.product.slider-product')
											@if($loop->index>=2 && (($loop->index+1)%3)==0)
											<div class="ad">
												<img src="{{asset('assets/images/ad.jpg')}}">
											</div>
											@endif
									@endforeach

								</div>
							</div>
						</div>
					</div>
				</section>

				<section  class="trending">
					<div class="container">
						<div class="row">
							<div class="col-lg-12 remove-padding">
								<div class="section-top">
									<h2 class="section-title">
										Flash Deal
									</h2>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="product-flash-section">
								<div class="left">

									@foreach($flashdeal_products as $prod)
											@include('includes.product.slider-product')
											@if($loop->index>=2 && (($loop->index+1)%3)==0)
											<div class="ad">
												<img src="{{asset('assets/images/ad.jpg')}}">
											</div>
											@endif
									@endforeach

								</div>
							</div>
						</div>
					</div>
				</section>

		<!-- Flash Sale Section End -->
		
	@if($ps->small_banner == 1)

	<!-- Banner Area One Start -->
	<center>
	<section class="banner-section">
		<div class="container">
			<div id="SliderName_2">
				@foreach($top_small_banners as $img)
						<a class="banner-effect" href="{{ $img->link }}" target="_blank">
							<img src="{{asset('assets/images/banners/'.$img->photo)}}" alt="">
						</a>
				@endforeach

				<div id="SliderNameNavigation_2"></div> 

			</div>
		</div>
	</section>
	</center>
	<!-- Banner Area One Start -->
	@endif




		<!-- Hot products sale section start -->
			@include('includes.hot-product-sale')
		<!-- Hot products sale section end -->
	<!-- New Sections Added end -->






@endsection

@section('scripts')
	<script>
        $(window).on('load',function() {

            setTimeout(function(){

                $('#extraData').load('{{route('front.extraIndex')}}');

            }, 500);
        });

	</script>
	
	<script>
		lazyload();
	</script>

	<script>
		var demoSlider_2 = Sliderman.slider({container: 'SliderName_2', width: 800, height: 200, effects: 'fade', display: {autoplay: 3000}});
		var demoSlider_3 = Sliderman.slider({container: 'SliderName_3', width: 800, height: 200, effects: 'fade', display: {autoplay: 2000}});
	</script>

	<script>

$(document).ready(function(){
    setInterval(function(){ 
		$('.owl-next').trigger('click');
	}, 3000);
});

	</script>

@endsection

