require 'bcrypt'

class User
	include DataMapper::Resource

	attr_reader :password
	attr_accessor :password_confirmation

	property :id, Serial
	property :name, String, required: true
	property :username, String, required: true
	property :email, String, required: true
	property :password_digest, Text
	validates_confirmation_of :password
	

	def password=(password)
		@password = password
		self.password_digest = BCrypt::Password.create(password)
	end


end