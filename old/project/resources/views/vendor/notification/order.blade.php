		<a class="clear">New Message(s)</a>
		@if(count($datas) > 0)
		<a id="order-notf-clear" data-href="{{ route('vendor-order-notf-clear',Auth::guard('web')->user()->id) }}" class="clear" href="javascript:;">
			{{ $langg->lang437 }}
		</a>
		<ul>
		@foreach($datas as $data)
			@if(isset($data->conversation_id))
			<li>
					<a href="{{ route('vendor-message-show',$data->conversation_id) }}"> <i class="fas fa-newspaper"></i> You have a new message.</a>
			</li>
			@endif
		@endforeach

		</ul>

		@else 

		<a class="clear" href="javascript:;">
			{{ $langg->lang439 }}
		</a>

		@endif