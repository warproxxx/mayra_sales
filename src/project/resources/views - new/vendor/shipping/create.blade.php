@extends('layouts.load')

@section('content')

            <div class="content-area">

              <div class="add-product-content">
                <div class="row">
                  <div class="col-lg-12">
                    <div class="product-description">
                      <div class="body-area">
                        @include('includes.admin.form-error')  
                      <form id="geniusformdata" action="{{route('vendor-shipping-create')}}" method="POST" enctype="multipart/form-data">
                        {{csrf_field()}}

                        <div class="row">
                          <div class="col-lg-4">
                            <div class="left-area">
                                <h4 class="heading">{{ $langg->lang735 }}} *</h4>
                                <p class="sub-heading">{{ $langg->lang517 }}</p>
                            </div>
                          </div>
                          <div class="col-lg-7">
                            <input type="text" class="input-field" name="title" placeholder="{{ $langg->lang735 }}" required="" value="">
                          </div>
                        </div>

                        <<div class="row">
                          <div class="col-lg-4">
                            <div class="left-area">
                                <h4 class="heading">{{ __('Subtitle') }} *</h4>
                                <p class="sub-heading">{{ __('(In Any Language)') }}</p>
                            </div>
                          </div>
                          <div class="col-lg-7">
                            <input type="text" class="input-field" name="subtitle" placeholder="{{ __('Subtitle') }}" value="">
                          </div>
                        </div>

                        <div class="row">
                          <div class="col-lg-4">
                            <div class="left-area">
                                <h4 class="heading">{{ __('Short Distance Price') }} *</h4>
                                <p class="sub-heading">({{ __('In') }} {{ $sign->name }})</p>
                            </div>
                          </div>

                          <div class="col-lg-7">
                            <input type="number" class="input-field" name="price" placeholder="{{ __('Short Distance Price') }}" required="" value="" min="0" step="0.1">
                          </div>
                        </div>

                        <div class="row">
                          <div class="col-lg-4">
                            <div class="left-area">
                                <h4 class="heading">{{ __('Long Distance Price') }} *</h4>
                                <p class="sub-heading">({{ __('In') }} {{ $sign->name }})</p>
                            </div>
                          </div>

                          <div class="col-lg-7">
                            <input type="number" class="input-field" name="long_price" placeholder="{{ __('Long Distance Price') }}" required="" value="" min="0" step="0.1">
                          </div>
                        </div>

                        <div class="row">
                          <div class="col-lg-4">
                            <div class="left-area">
                                <h4 class="heading">{{ __('Short Long Threshold') }} *</h4>
                                <p class="sub-heading">({{ __('In KM') }})</p>
                            </div>
                          </div>

                          <div class="col-lg-7">
                            <input type="number" class="input-field" name="threshold" placeholder="{{ __('Short Long Threshold') }}" required="" value="" min="0" step="0.1">
                          </div>
                        </div>

                        <div class="row">
                          <div class="col-lg-4">
                            <div class="left-area">
                                <h4 class="heading">{{ __('Free Shipping Threshold') }} *</h4>
                                <p class="sub-heading">({{ __('In') }} {{ $sign->name }})</p>
                            </div>
                          </div>

                          <div class="col-lg-7">
                            <input type="number" class="input-field" name="free_threshold" placeholder="{{ __('Free Shipping Threshold') }}" required="" value="" min="0" step="0.1">
                          </div>
                        </div>


                        <div class="row">
                          <div class="col-lg-4">
                            <div class="left-area">
                              
                            </div>
                          </div>
                          <div class="col-lg-7">
                            <button class="addProductSubmit-btn" type="submit">{{ $langg->lang739 }}</button>
                          </div>
                        </div>
                      </form>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>

@endsection