class HelloRailsController < ApplicationController
  def index
    @postParam = Input.new
    @userInput = Input.new
    @output = Output.new(output: "お話ししましょう！");
  end
  def create
  end
  def update
    user_params = params.require(:input).permit(:input)
    @postParam = Input.new(user_params)
    @userInput = Input.new(user_params)
    @postParam = Input.new
    bot_api #チャットボット用APIへPOST
  end
  
  def bot_api
    require 'net/http'
    require 'uri'
 
    uri = URI.parse("https://hitomisaya.silett.com/bot-studio-advanced/bot-studio/Saya/bots/botAPI.php")
    https = Net::HTTP.new(uri.host, uri.port)
 
    https.use_ssl = true #HTTPS通信
    req = Net::HTTP::Post.new(uri.request_uri)
    req["Content-Type"] = "application/json"
    
    payload = {
      'input'=>@userInput[:input],
      'user_id'=>"owneruser_57e525c94b749",
      'account_id'=>"user_57e525c94b749",
      'bot_id'=>"bot57f0ca9fde8c5",
      'bot_token'=>"e5354932c5a9349dc6cca478dbb67a3e",
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
end
