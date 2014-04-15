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

    pipeline = []

    pipeline[0] = {"$project" => properties}
    pipeline[1] = {"$match" => {:office =>
        {operator => operator_value}
        }
      }
    pipeline[2] = {"$limit" => params[:number_of_results].to_i} if (params[:number_of_results].to_i > 0)

    results = MongoConnection.instance.users_collection.aggregate(pipeline)

    render :partial => "show_result", :locals => {:results => results}, :layout => false
  end

end
