@extends('layouts.vendor')
@section('content')


<section class="content-area">
    <div class="mr-breadcrumb">
      <div class="row">
        <div class="col-lg-12">
					<div class="user-profile-details">
						<div class="order-history">
							<div class="header-area">
								<h4 class="title">
									{{ $langg->lang372 }}
                            @if($user->id == $conv->sent->id)
                            {{$conv->recieved->name}}    
                            @else
                            {{$conv->sent->name}}
                            @endif <a  class="mybtn1" href="{{ route('vendor-order-index') }}"> <i class="fas fa-arrow-left"></i> {{ $langg->lang373 }}</a>
								</h4>
							</div>


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
                                        @if (is_null($message->file))
                                                <p>{{ $message->message }}</p>
                                            @else
                                                <p><a href="/assets/images/users/{{ $message->file }}" target="_blank">{{ $message->file }}</a></p>
                                            @endif
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
                        <form id="messageform" data-href="{{ route('user-vendor-message-load',$conv->id) }}" action="{{route('vendor-message-post')}}" method="POST" enctype="multipart/form-data">
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
                              <input type="file" name="file" onchange="form.submit()"/><br/><br/>
                                <textarea class="form-control" name="message" id="wrong-invoice" rows="5" style="resize: vertical;" required="" placeholder="{{ $langg->lang374 }}"></textarea>
                            </div>
                            <div class="form-group">
                                <button class="mybtn1">
                                    {{ $langg->lang375 }}
                                </button>

                            </div>
                                

                            </div>
                        </form>
                    </div
                </div>


						</div>
					</div>
				</div>
			</div>
		</div>
	</section>

    <div class="modal fade" id="confirm-delete2" tabindex="-1" role="dialog" aria-labelledby="modal1" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
    <div class="submit-loader">
        <img  src="http://opnmarket.local/assets/images/1564224329loading3.gif" alt="">
    </div>
    <div class="modal-header d-block text-center">
        <h4 class="modal-title d-inline-block">Update Status</h4>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
        </button>
    </div>

      <!-- Modal body -->
      <div class="modal-body">
        <p class="text-center">You are about to update the Order&#039;s Status.</p>
        <p class="text-center">Do you want to proceed?</p>
      </div>

      <!-- Modal footer -->
      <div class="modal-footer justify-content-center">
            <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
            <a class="btn btn-success btn-ok order-btn">Proceed</a>
      </div>

    </div>
  </div>
</div>
<script src="http://opnmarket.local/assets/vendor/js/vendors/jquery-1.12.4.min.js"></script>
    <script type="text/javascript">


$('.vendor-btn').on('change',function(){
          $('#confirm-delete2').modal('show');
          $('#confirm-delete2').find('.btn-ok').attr('href', $(this).val());

});
</script>
@endsection