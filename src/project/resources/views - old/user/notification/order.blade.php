<div style="font-size:12px; font-family: Open Sans">
		<a class="clear">New Message(s)</a>
		@if(count($datas) > 0)
		<a id="order-notf-clear" data-href="{{ route('user-order-notf-clear',Auth::guard('web')->user()->id) }}" class="clear" href="javascript:;">
			{{ $langg->lang437 }}
		</a>
		<ul>
		@foreach($datas as $data)
			@if(isset($data->conversation_id))
			<li>
					<a href="{{ route('user-message',$data->conversation_id) }}"> <i class="fas fa-newspaper"></i> You have a new message.</a>
			</li>
			@else
			<li>
					<a href="{{ route('user-message-show',$data->ticket_id) }}"> <i class="fas fa-newspaper"></i> You have a new message.</a>
			</li>
			@endif

		@endforeach

		</ul>

		@else 

		<a class="clear" href="javascript:;">
			{{ $langg->lang439 }}
		</a>

		@endif

</div>