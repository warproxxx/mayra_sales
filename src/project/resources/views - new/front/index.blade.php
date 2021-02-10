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
			<div class="row category-list" style="display:flex;">
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
							margin: 12px;
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
							font-size: 0.85em
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

	@if($ps->featured == 1)
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
						</div>
					</div>

				</div>
			</div>
		</section>
		<!-- Tranding Item Area End -->
	@endif

	@if($ps->small_banner == 1)

		<!-- Banner Area One Start -->
		<center>
		<section class="banner-section">
			<div class="container">
				<div id="SliderName_3">
					@foreach($top_small_banners as $img)
							<a class="banner-effect" href="{{ $img->link }}" target="_blank">
								<img src="{{asset('assets/images/banners/'.$img->photo)}}" alt="">
							</a>
					@endforeach

					<div id="SliderNameNavigation_3"></div> 

				</div>
			</div>
		</section>
		</center>
		<!-- Banner Area One Start -->
	@endif

	<style>
		.item{
			border-radius: 12px;
		}
		.item .item-img img{
			width: 160px;
			min-height: 160px;
			margin: auto;
		}
		.trending-item-slider .owl-item{
			width: 260px !important;
			margin: auto 25px;
			border-radius: 12px;
			border: 2px solid #fff0;
			box-shadow: 0 0 5px 3.5px #aaa;
		}
		.trending-item-slider .owl-item:hover{
			box-shadow: 0 0 5px 3.5px #888;
			border: 2px solid pink;
		}
		.item .info .price{
			font-size: 14px;
			line-height: 16px;
			align-items: center;
		}
		.item .info .name{
			/*line-height: 12px;*/
			padding: 4px;
			display: flex;
			align-items: center;
			justify-content: center;
		}
		.item .name.sell-btn{
			background-color: orange;
			border-radius: 20px;
			color: #fff;
			height: auto;
			padding: 4px;
			font-size: 11px
		}
	</style>
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
						<!-- </div> -->
					</div>

				</div>
			</div>
		</section>


	

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
<!-- 
	<section id="extraData">
		<div class="text-center">
			<img src="{{asset('assets/images/'.$gs->loader)}}">
		</div>
	</section> -->
<h1>HELLO WORLD</h1>
	<!-- New Sections Added Start-->
	<section>
		<div class="ads">
			<div class="left"><img src="{{asset('assets/images/ad-placeholder.jpg)}}"></div>

			<div class="right"><img src="{{asset('assets/images/ad-placeholder.jpg)}}"></div>
		</div>
	</section>
	<!-- New Sections Added End -->


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

