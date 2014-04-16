class Item
	@items = @data.collection("items")
	puts "*"*30
    puts @items.inspect
    puts "*"*30
end