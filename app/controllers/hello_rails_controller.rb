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
      'user_id'=>"111",
      'account_id'=>"222",
      'bot_id'=>"333",
      'bot_token'=>"444",
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
