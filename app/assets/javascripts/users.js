$(function() {

	$( ".generate_query" ).click(function(select) {
		var params  = {}
		var selected_items = [];
		$("input:checked").each(function(){
			selected_items.push($(this).val());
		});
		params["selected_items"] = selected_items
		// console.log(selected_items);
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
});