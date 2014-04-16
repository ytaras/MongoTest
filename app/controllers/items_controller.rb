class ItemsController < ApplicationController

  def index
    config=YAML.load_file('lib/items_for_select.yml')
    @items = config["items"].split(" ")
  end

  def generate_query
    properties = Hash[params[:selected_items].map{|sym| [sym.to_sym, 1]}]
    properties[:_id] = 0

    pipeline = [{"$project" => properties}]
    pipeline << {"$match" => {:office => {params[:operator] => params[:operator_value].to_i} } } unless params[:operator_value].empty?
    pipeline << {"$limit" => params[:number_of_results].to_i} unless params[:number_of_results].empty?

    results = MongoConnection.instance.items_collection.aggregate(pipeline)

    render :partial => "show_result", :locals => {:results => results}, :layout => false
  end

end
