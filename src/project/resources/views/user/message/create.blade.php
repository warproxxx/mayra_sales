@extends('layouts.front')
@section('content')


<section class="user-dashbord">
    <div class="container">
      <div class="row">
        @include('includes.user-dashboard-sidebar')
        <div class="col-lg-8">
					<div class="user-profile-details">
						<div class="order-history">
							<div class="header-area">
                            <div style="display: flex;">
                            <div style="flex-grow: 1;">
                                
								<h4 class="title">

                                    @if($conv->is_dispute == 0)
                                    <a href="{{ route('user-message-dispute',$conv->id) }}" class="accordion-toggle wave-effect waves-effect waves-button" data-toggle="collapse" aria-expanded="false">
									<i class="fa fa-gavel"></i>
                                    @else
                                    <a href="{{ route('user-message-dispute',$conv->id) }}" class="accordion-toggle wave-effect waves-effect waves-button" data-toggle="collapse" aria-expanded="false">
									<i class="fa fa-gavel"></i>
                                    @endif 

                                    
                                </a>
                                

									{{ $conv->subject }}
                            
                            <a  class="mybtn1" href="{{ route('user-orders') }}"> <i class="fas fa-arrow-left"></i> {{ $langg->lang373 }}</a></div>
                                <div>

                                    @if($conv->closed == 0)
                                        <a class="mybtn2" href="{{ route('user-message-close',$conv->id) }}">Confirm Received</a>
                                    @endif 

                                    
                                    
                                   
                                    
                                </div>
                            </div>


								</h4>
							</div>

                            @if(is_null($other_covs))

                            @else
                                <b>Other Coversations:</b><br/>

                                <ul>
                                @foreach($other_covs as $past)
                                    <li><a href="{{ route('user-message',$past->id) }}" target="_blank">{{$past->created_at}}</li></a>
                                @endforeach
                                </ul><br/>


                            @endif


<div class="support-ticket-wrapper ">
                <div class="panel panel-primary">
                      <div class="gocover" style="background: url({{ asset('assets/images/'.$gs->loader) }}) no-repeat scroll center center rgba(45, 45, 45, 0.5);"></div>                  
                    <div class="panel-body" id="messages">
                      @foreach($conv->messages as $message)
                        @if($message->sent_user != null)

                        <div class="single-reply-area admin">
                            <div class="row">
                                <div class="col-lg-12">
                                    <div class="reply-area">
                                        <div class="left">
                                            
                                            @if($message->conversation->sent->is_provider == 1 )
                                            <img class="img-circle" src="{{ $message->conversation->sent->photo != null ? $message->conversation->sent->photo : asset('assets/images/noimage.png') }}" alt="">
                                            @else 
                                            <img class="img-circle" src="{{ $message->conversation->sent->photo != null ? asset('assets/images/users/'.$message->conversation->sent->photo) : asset('assets/images/noimage.png') }}" alt="">
                                            @endif
                                            <p class="ticket-date">{{ $message->conversation->sent->name }}</p>
                                        </div>
                                        <div class="right">
                                            @if (is_null($message->file))
                                                <p>{{ $message->message }}</p>
                                            @else
                                                <p><a href="/assets/images/users/{{ $message->file }}" target="_blank">{{ $message->file }}</a></p>
                                            @endif
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>


                        <br>
                        @else

                        <div class="single-reply-area user">
                            <div class="row">
                                <div class="col-lg-12">
                                    <div class="reply-area">
                                        <div class="left">
                                            <p>{{ $message->message }}</p>
                                        </div>
                                        <div class="right">

                                        @if($message->conversation->recieved->is_provider == 1 )
                                        <img class="img-circle" src="{{ $message->conversation->recieved->photo != null ? $message->conversation->recieved->photo : asset('assets/images/noimage.png') }}" alt="">
                                        @else 
                                        <img class="img-circle" src="{{ $message->conversation->recieved->photo != null ? asset('assets/images/users/'.$message->conversation->recieved->photo) : asset('assets/images/noimage.png') }}" alt="">
                                        @endif


                                            <p class="ticket-date">{{$message->conversation->recieved->name}}</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>



                        <br>
                        @endif
                        @endforeach

                    </div>
                    <div class="panel-footer">
                        <form id="messageform" data-href="{{ route('user-vendor-message-load',$conv->id) }}" action="{{route('user-message-post')}}" method="POST" enctype="multipart/form-data">
                            {{csrf_field()}}
                            <div class="form-group">
                                              <input type="hidden" name="conversation_id" value="{{$conv->id}}">
                              @if($user->id == $conv->sent_user)
                                  <input type="hidden" name="sent_user" value="{{$conv->sent->id}}">
                                  <input type="hidden" name="reciever" value="{{$conv->recieved->id}}">
                                @else
                                  <input type="hidden" name="reciever" value="{{$conv->sent->id}}">
                                  <input type="hidden" name="recieved_user" value="{{$conv->recieved->id}}">
                              @endif
                             
                        </div>

                        <input type="file" name="file" onchange="form.submit()"/><br/><br/>

                                <textarea class="form-control" name="message" id="wrong-invoice" rows="5" style="resize: vertical;" required="" placeholder="{{ $langg->lang374 }}"></textarea>
                            </div>
                            <br/>
                            <div class="form-group">
                                <button class="mybtn1">
                                    {{ $langg->lang375 }}
                                </button>
                            </div>

                        </form>
                    </div>
                </div>
					</div>
				</div>
			</div>
		</div>
	</section>

@endsection