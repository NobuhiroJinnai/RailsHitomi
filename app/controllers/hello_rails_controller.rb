class HelloRailsController < ApplicationController
  def index
    @postParam = Input.new
    @userInput = Input.new
    @userInput[:input] = "　"
    @output = Output.new(output: "お話ししましょう！");
    bot_api("こんにちわ")#最初の発話
  end
  def setting
    @user = User.new
  end
  def new_user
    user_params = params.require(:user).permit(:name)
    @user = User.new(user_params)
    puts @user[:name]
    user_name_api
    redirect_to :action=> :index
  end
  def create
  end
  def update
    user_params = params.require(:input).permit(:input)
    @postParam = Input.new(user_params)
    @userInput = Input.new(user_params)
    @postParam = Input.new
    bot_api(@userInput[:input]) #チャットボット用APIへPOST
  end
  
  def bot_api(user_input)
    require 'net/http'
    require 'uri'
 
    uri = URI.parse("https://hitomisaya.silett.com/bot-studio-advanced/bot-studio/Saya/bots/botAPI.php")
    https = Net::HTTP.new(uri.host, uri.port)
 
    https.use_ssl = true #HTTPS通信
    req = Net::HTTP::Post.new(uri.request_uri)
    req["Content-Type"] = "application/json"
    
    payload = {
      'input'=>user_input,
      'user_id'=>"aaa",
      'account_id'=>"bbb",
      'bot_id'=>"ccc",
      'bot_token'=>"ddd",
      'command'=>"Normal",
      'type'=>"talk",
      'os'=>"robot",
    }.to_json
    
    req.body = payload
    res = https.request(req)
    result = ActiveSupport::JSON.decode(res.body) #結果をデコード
    puts result["result"]
    #返答情報から応答文本体のみ抽出
    outputArray = result["result"].split("|")
    #@output = Output.new(output: result["result"])
    @output = Output.new(output: outputArray[0])    
    render :action => :index
  end
  
  def user_name_api
    require 'net/http'
    require 'uri'
 
    uri = URI.parse("https://hitomisaya.silett.com/bot-studio-advanced/bot-studio/Saya/settings/access_me.php")
    https = Net::HTTP.new(uri.host, uri.port)
 
    https.use_ssl = true #HTTPS通信
    req = Net::HTTP::Post.new(uri.request_uri)
    req["Content-Type"] = "application/json"
    
    payload = {
      'user_id'=>"aaa",
      'account_id'=>"bbb",
      'bot_id'=>"ccc",
      'bot_token'=>"ddd",
      'command'=>"Normal",
      'type'=>"talk",
      'os'=>"robot",
      'setting_type'=>'set_name',
      'name'=>@user[:name],
      'token'=>'token'
    }.to_json
    
    req.body = payload
    res = https.request(req)
    result = ActiveSupport::JSON.decode(res.body) #結果をデコード
    puts result["result"]
  end
end
