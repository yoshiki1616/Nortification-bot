require 'discordrb'

TOKEN = 'TESTTOKEN'
CLIENT_ID = 'testid'

# 通知用のチャンネルID
inform_channel = 123456

# bot
bot = Discordrb::Commands::CommandBot.new token: TOKEN, client_id: CLIENT_ID, prefix:'/'

# 誰かが出入りしたら動作する
bot.voice_state_update do |event|
    # ユーザー名を取得
    user = event.user.name

    # 抜けていったチャンネル名を取得
    if event.channel == nil then
        # チャンネル名を取得
        channel_name = event.old_channel.name

        # 退出したことをjoin_channelに通知
        bot.send_message(join_channel, "@everyone #{user} が #{channel_name}から退出")
    else
        # チャンネル名を取得
        channel_name = event.channel.name

        # 入室したことをjoin_channelに通知
        bot.send_message(join_channel, "@everyone #{user} が #{channel_name}に入室")
    end
end

# botを起動
bot.run
