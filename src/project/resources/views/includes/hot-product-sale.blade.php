<style>
	.hot-and-new-item-slider .item-list li{
		background-color: #f0f0f0;
		border-radius: 7px;
	}
	.hot-and-new-item-slider .item-list .single-box li .right-area{
		display: flex;
		flex-direction: column;
	}
	.hot-and-new-item .categori .item-list li .single-box .right-area p.text{
		margin-top: 12px;
		font-weight: bolder;
	}
	.hot-and-new-item-slider .item-list li img{
		width: 100%;
		height: 100%;
		object-fit: cover;
		object-position: center;
	}
</style>
<section class="hot-and-new-item">
   <div class="container">
      <div class="row">
         <div class="col-lg-12">
            <div class="accessories-slider">
              <div class="row">
                <div class="col-lg-3 col-sm-6">
                    <div class="categori">
                       <div class="section-top">
                          <h2 class="section-title">
                             Hot
                          </h2>
                       </div>
                       <div class="hot-and-new-item-slider">
                           @foreach($hot_products as $prod)
                            @if($loop->index%3==0)
                              <div class="item-slide">
                                <ul class="item-list">
                            @endif
                              <li>
                                 <div class="single-box">
                                    <div class="left-area">
                                       <img src="{{ $prod->photo ? asset('assets/images/thumbnails/'.$prod->thumbnail):asset('assets/images/noimage.png') }}" alt="not found">
                                    </div>
                                    <div class="right-area">
                                       <p class="text"><a href="https://mayrasales.com/item/{{$prod->slug}}">{{$prod->name}}</a></p>
                                       <h4 class="price">Rs.{{$prod->price}} <del>Rs.{{$prod->price}}</del> </h4>
                                    </div>
                                 </div>
                              </li>
                            @if(($loop->index+1)%3==0)
                                </ul>
                              </div>
                            @endif
                           @endforeach
                           @if(count($hot_products)/3!=0)
                              </ul>
                            </div>
                          @endif
                       </div>
                    </div>
                 </div>
                 <div class="col-lg-3 col-sm-6">
                    <div class="categori">
                       <div class="section-top">
                          <h2 class="section-title">
                             New
                          </h2>
                       </div>
                       <div class="hot-and-new-item-slider">
                           @foreach($latest_products as $prod)
                            @if($loop->index%3==0)
                              <div class="item-slide">
                                <ul class="item-list">
                            @endif
                              <li>
                                 <div class="single-box">
                                    <div class="left-area">
                                       <img src="{{ $prod->photo ? asset('assets/images/thumbnails/'.$prod->thumbnail):asset('assets/images/noimage.png') }}" alt="not found">
                                    </div>
                                    <div class="right-area">
                                       <p class="text"><a href="https://mayrasales.com/item/{{$prod->slug}}">{{$prod->name}}</a></p>
                                       <h4 class="price">Rs.{{$prod->price}} <del>Rs.{{$prod->price}}</del> </h4>
                                    </div>
                                 </div>
                              </li>
                            @if(($loop->index+1)%3==0)
                                </ul>
                              </div>
                            @endif
                           @endforeach
                           @if(count($latest_products)/3!=0)
                              </ul>
                            </div>
                          @endif
                       </div>
                    </div>
                 </div>
                 <div class="col-lg-3 col-sm-6">
                    <div class="categori">
                       <div class="section-top">
                          <h2 class="section-title">
                             Trending
                          </h2>
                       </div>
                       <div class="hot-and-new-item-slider">
                         @foreach($trending_products as $prod)
                            @if($loop->index%3==0)
                              <div class="item-slide">
                                <ul class="item-list">
                            @endif
                              <li>
                                 <div class="single-box">
                                    <div class="left-area">
                                       <img src="{{ $prod->photo ? asset('assets/images/thumbnails/'.$prod->thumbnail):asset('assets/images/noimage.png') }}" alt="not found">
                                    </div>
                                    <div class="right-area">
                                       <p class="text"><a href="https://mayrasales.com/item/{{$prod->slug}}">{{$prod->name}}</a></p>
                                       <h4 class="price">Rs.{{$prod->price}} <del>Rs.{{$prod->price}}</del> </h4>
                                    </div>
                                 </div>
                              </li>
                            @if(($loop->index+1)%3==0)
                                </ul>
                              </div>
                            @endif
                           @endforeach
                           @if(count($trending_products)/3!=0)
                              </ul>
                            </div>
                          @endif

                          <!-- @foreach($trending_products as $prod)
                            @if($loop->index%3==0)
                              div,ul
                            @endif
                              {{$prod->name}}
                            @if(($loop->index+1)%3==0)
                               /ul,/div
                            @endif
                           @endforeach
                           @if(count($trending_products)/3!=0)
                              /ul,/div
                          @endif
 -->
                       </div>
                    </div>
                 </div>
                 <div class="col-lg-3 col-sm-6">
                    <div class="categori">
                       <div class="section-top">
                          <h2 class="section-title">
                             Sale
                          </h2>
                       </div>
                       <div class="hot-and-new-item-slider">
                         @foreach($sale_products as $prod)
                            @if($loop->index%3==0)
                              <div class="item-slide">
                                <ul class="item-list">
                            @endif
                              <li>
                                 <div class="single-box">
                                    <div class="left-area">
                                       <img src="{{ $prod->photo ? asset('assets/images/thumbnails/'.$prod->thumbnail):asset('assets/images/noimage.png') }}" alt="not found">
                                    </div>
                                    <div class="right-area">
                                       <p class="text"><a href="https://mayrasales.com/item/{{$prod->slug}}">{{$prod->name}}</a></p>
                                       <h4 class="price">Rs.{{$prod->price}} <del>Rs.{{$prod->price}}</del> </h4>
                                    </div>
                                 </div>
                              </li>
                            @if(($loop->index+1)%3==0)
                                </ul>
                              </div>
                            @endif
                           @endforeach
                           @if(count($sale_products)/3!=0)
                              </ul>
                            </div>
                          @endif
                       </div>
                    </div>
                 </div>
              </div>
            </div>
         </div>
      </div>
   </div>
</section>