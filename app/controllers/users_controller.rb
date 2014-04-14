class UsersController < ApplicationController

  def index
    config=YAML.load_file('lib/items_for_select.yml')
    @items = config["items"].split(" ")
  end

  def generate_query
    properties = Hash[params[:selected_items].map{|sym| [sym.to_sym, 1]}]
    properties[:_id] = 0
    results = MongoConnection.instance.users_collection.aggregate([{"$project" => properties}, {"$limit" => 10}])
    render :partial => "show_result", :locals => {:results => results}, :layout => false
  end

end
