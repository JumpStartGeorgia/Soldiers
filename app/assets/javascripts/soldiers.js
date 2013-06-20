$(document).ready(function(){

  if (gon.edit_soldier){

		$('#soldier_born_at').datepicker({
				dateFormat: 'yy-dd-mm'
		});

		if (gon.born_at !== undefined &&
				gon.born_at.length > 0)
		{
			$('#soldier_born_at').datepicker("setDate", new Date(gon.born_at));
		}

		$('#soldier_died_at').datepicker({
				dateFormat: 'yy-dd-mm'
		});

		if (gon.died_at !== undefined &&
				gon.died_at.length > 0)
		{
			$('#soldier_died_at').datepicker("setDate", new Date(gon.died_at));
		}

  }

});
