require 'json'

module Contactable
  def contact_details
    "#{email} | #{mobile}"
  end
end

class Person
  attr_accessor :name
  
  def initialize(name)
    @name = name
  end
  
  def valid_name?
    !(@name =~ /\A[a-zA-Z]+\z/).nil?
  end
end

class User < Person
  include Contactable
  
  attr_accessor :email, :mobile
  
  def initialize(name, email, mobile)
    super(name)
    @email = email
    @mobile = mobile
  end
  
  def self.valid_mobile?(mobile)
    !!(mobile =~ /\A0\d{10}\z/)
  end
  
  def create
    if valid_name? && self.class.valid_mobile?(mobile)
      users = load_users
      users << self
      save_users(users)
      true
    else
      false
    end
  end
  
  def list(n = nil)
    users = load_users
    if n.nil?
      users.each do |user|
        puts "#{user.name} - #{user.contact_details}"
      end
    else
      users.first(n).each do |user|
        puts "#{user.name} - #{user.contact_details}"
      end
    end
  end
  
  def to_h
    { name: name, email: email, mobile: mobile }
  end
  
  private
  
  def load_users
    if File.exist?("users.json")
      JSON.parse(File.read("users.json"), symbolize_names: true).map do |user_data|
        User.new(user_data[:name], user_data[:email], user_data[:mobile])
      end
    else
      []
    end
  end
  
  def save_users(users)
    File.write("users.json", JSON.pretty_generate(users.map(&:to_h)))
  end
end

puts "Name:"
name = gets.chomp

puts "Email:"
email = gets.chomp

puts "Mobile:"
mobile = gets.chomp

user = User.new(name, email, mobile)

if user.create
  puts "Success registration"
  puts "Welcome, #{user.name}"
else
  puts "Invalid registration"
end
# # List all users
# user.list
user.list(2)