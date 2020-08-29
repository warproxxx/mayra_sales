		<a class="clear">{{ __('New Conversation(s).') }}</a>
		@if(count($datas) > 0)
		<a id="conv-notf-clear" data-href="{{ route('conv-notf-clear') }}" class="clear" href="javascript:;">
			{{ __('Clear All') }}
		</a>
		<ul>
		@foreach($datas as $data)

			@if(isset($data->conversation_id))
			<li>
					<a href="{{ route('admin-message-show',$data->conversation_id) }}"> <i class="fas fa-newspaper"></i> You have a new message.</a>
			</li>
			@else
			<li>
					<a href="{{ route('admin-ticket-show',$data->ticket_id) }}"> <i class="fas fa-newspaper"></i> You have a new message.</a>
			</li>
			@endif
		@endforeach

		</ul>

		@else 

		<a class="clear" href="javascript:;">
			{{ __('No New Notifications.') }}
		</a>

		@endif