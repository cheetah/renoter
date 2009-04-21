require 'net/http'
require 'rubygems'
require 'json'

# This is a small wrapper for http://renoter.com API
# Author::    cheetah  (mailto:thcheetah@gmail.com)

class Renoter
  
  # Authentication, used in some other methods.
  # Returns true if success, else returns false.
  def login(user, pass)
    api_url = 'http://renoter.com/account/verify_credentials.json'
    url = URI.parse(api_url)
    request = Net::HTTP::Get.new(api_url)
    request.basic_auth(user, pass)
    response = Net::HTTP.new(url.host, url.port).start {|http| http.request(request) }
    if response.class == Net::HTTPOK
      @username = user
      @password = pass
      return true 
    end
    false
  end
  
  # Logout.
  # Returns true.
  def logout
    @username = nil
    @password = nil
    true
  end
  
  # Retrieves public timeline, the last 20 statuses.
  # Returns JSON-decoded object, which contains statuses or errors.
  def public_timeline()
    api_url = 'http://renoter.com/statuses/public_timeline.json'
    url = URI.parse(api_url)
    request = Net::HTTP::Get.new(api_url)
    response = Net::HTTP.new(url.host, url.port).start {|http| http.request(request) }
    JSON.parse response.body
  end
  
  # Retrieves friends timeline, specified for authorized user.
  # Returns JSON-decoded object, which contains statuses or errors.
  # Requires authentication.
  def friends_timeline(count = 20)
    return 'at first you must been logged in' if !@username and !@password
    
    api_url = 'http://renoter.com/statuses/friends_timeline.json?count=' + count.to_s
    url = URI.parse(api_url)
    request = Net::HTTP::Get.new(api_url)
    request.basic_auth(@username, @password)
    response = Net::HTTP.new(url.host, url.port).start {|http| http.request(request) }
    JSON.parse response.body
  end
  
  # Retrieves timeline, for passed in params user.
  # Returns JSON-decoded object, which contains statuses or errors.
  def user_timeline(login, count = 20)
    api_url = 'http://renoter.com/statuses/user_timeline.json?login=' + login.to_s + '&count=' + count.to_s
    url = URI.parse(api_url)
    request = Net::HTTP::Get.new(api_url)
    request.basic_auth(@username, @password) if @username and @password
    response = Net::HTTP.new(url.host, url.port).start {|http| http.request(request) }
    JSON.parse response.body
  end
  
  # Retrieves status with passed in params id.
  # Returns JSON-decoded object, which contains status or errors.
  def show_status(id)
    return 'id must be not nil.' if id.nil?
    
    api_url = 'http://renoter.com/statuses/show/' + id.to_s + '.json'
    url = URI.parse(api_url)
    request = Net::HTTP::Get.new(api_url)
    request.basic_auth(@username, @password) if @username and @password
    response = Net::HTTP.new(url.host, url.port).start {|http| http.request(request) }
    JSON.parse response.body
  end
  
  # Post a new status.
  # Returns JSON-decoded object, which contains new status or errors.
  # Requires authentication.
  def update_status(status, reply_id = nil)
    return 'status must been less than 140 characters.' if status.length > 140
    return 'status must have at least one character.' if status.length < 1
    return 'at first you must been logged in' if !@username and !@password
    
    api_url = 'http://renoter.com/statuses/update.json'
    url = URI.parse(api_url)
    request = Net::HTTP::Post.new(url.path)
    request.basic_auth(@username, @password)
    request.set_form_data({'status'=> status, 'in_reply_to_status_id' => reply_id})
    response = Net::HTTP.new(url.host, url.port).start {|http| http.request(request) }
    JSON.parse response.body
  end
  
  # Removes status with passed in params id.
  # Returns JSON-decoded object, which contains removed status or errors.
  # Requires authentication.
  def delete_status(id)
    return 'id must be not nil.' if id.nil?
    return 'at first you must been logged in' if !@username and !@password
    
    api_url = 'http://renoter.com/statuses/destroy/' + id.to_s + '.json'
    url = URI.parse(api_url)
    request = Net::HTTP::Post.new(url.path)
    request.basic_auth(@username, @password) if @username and @password
    request.set_form_data({ 'id'=> id }, ';')
    response = Net::HTTP.new(url.host, url.port).start {|http| http.request(request) }
    JSON.parse response.body
  end
  
end