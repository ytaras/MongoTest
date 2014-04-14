require 'rubygems'  # not necessary for Ruby 1.9
require 'mongo'
require 'singleton'

class MongoConnection
	include Mongo
	include Singleton
	def users_collection
		@connection = MongoClient.new("localhost", 27017)
		@data = @connection.db("mongo_test_db")
		@users = @data.collection("users")
	end
end