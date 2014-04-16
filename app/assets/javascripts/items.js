$(function() {

	$( ".generate_query" ).click(function(select) {
		var params  = {}
		var selected_items = [];
		$("input:checked").each(function(){
			selected_items.push($(this).val());
		});
		params["selected_items"] = selected_items;
		params["operator"] = $("#operator").val();
		params["number_of_results"] = $("#number_of_results").val();
		params["operator_value"] = $("#operator_value").val();
		console.log(params);
		$.ajax({
			url: "/generate_query",
			data: params,
			type: "GET",
			dataType: "html",
			success: function(html_content) {
			// console.log("hello");
				$(".result").append(html_content)
				$(".result").show();
			}
		});
	});

	$( "#office" ).click(function() {
      if (this.checked) {
            $("#choose_operator").show();
        } else {
            $("#choose_operator").hide();
            $("#operator_value").val("");
        }
	});

});