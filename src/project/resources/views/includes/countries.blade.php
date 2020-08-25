<option value="">{{ $langg->lang157 }}</option>

@foreach (DB::table('countries')->get() as $data)
	<option value="{{ $data->country_name }}" {{ $data->country_name == "Nepal" ? 'selected' : '' }}>{{ $data->country_name }}</option>		
@endforeach