require 'net/http'
require 'open-uri'
class Token
  include Mongoid::Document
  field :content, type: String
  field :timeout, type: Time
  field :ticket, type: String
  field :ticket_timeout, type: Time

  WECHAT_TOKEN_API = 'https://api.weixin.qq.com/cgi-bin/token'

  WECHAT_APP_ID = "wx80262218f360ebe9"
  WECHAT_APP_SECRET = "11335f839481d7fcab49f597017cf542"
  #?grant_type=client_credential&appid=APPID&secret=APPSECRET

  def self.get_token
    if Token.all.size > 0
      if Time.now < Token.all.last.timeout
        @token = Token.all.last
      else
        @token = Token.get_new_token
      end
    else
      @token = Token.get_new_token
    end
    @token
  end

  def self.get_new_token
    puts 'opening...'
    open(Token.generate_api_url) do |http|
      @data = JSON.parse "#{http.read}"
      puts 'done open!'
    end
    puts @data
    Token.create_from_api @data
  end

  def jsTicket
    if Time.now >= self.ticket_timeout
      self.generate_js_token
    end
    self.ticket
  end

  def generate_js_token
    open "https://api.weixin.qq.com/cgi-bin/ticket/getticket?access_token=#{self.content}&type=jsapi" do |http|
      @data = JSON.parse http.read.to_s
    end
    self.ticket = @data["ticket"]
    self.ticket_timeout = Time.now + @data["expires_in"].to_i
    self.save
  end

  def self.create_from_api(data)
    Token.delete_all
    @token = Token.create(content: data["access_token"], timeout: Time.now + data["expires_in"].to_i)
    @token.generate_js_token
    @token
  end

  private
  def self.generate_api_url(appid = Token::WECHAT_APP_ID, appsec = Token::WECHAT_APP_SECRET, grant_type = 'client_credential')
    "#{Token::WECHAT_TOKEN_API}?grant_type=#{ grant_type }&appid=#{ appid }&secret=#{ appsec }"
  end

end
