class UsersController < ApplicationController

  def index
    config=YAML.load_file('lib/items_for_select.yml')
    @items = config["items"].split(" ")
  end

  def generate_query
    properties = Hash[params[:selected_items].map{|sym| [sym.to_sym, 1]}]
    properties[:_id] = 0

    operator = params[:operator]
    operator_value = params[:operator_value].to_i

    pipeline = [{"$project" => properties},
                {"$match" => {:office =>
                {operator => operator_value}}}
    ]

    pipeline << {"$limit" => params[:number_of_results].to_i} unless params[:number_of_results].empty?

    results = MongoConnection.instance.users_collection.aggregate(pipeline)

    render :partial => "show_result", :locals => {:results => results}, :layout => false
  end

end
