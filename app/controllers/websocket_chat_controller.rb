class WebsocketChatController < WebsocketRails::BaseController

  def message_recieve

    # クライアントからのメッセージを取得

    recieve_message = message()
    pp recieve_message
    pp "test"
    # websocket_chatイベントで接続しているクライアントにブロードキャスト

    broadcast_message(:websocket_chat, recieve_message)

  end

end