import Foundation
import Telegrammer

let token = Enviroment.get("TELEGRAM_BOT_TOKEN")!

/// Initializind Bot settings (token, debugmode)
var settings = Bot.Settings(token: token, debugMode: true)

let bot = try! Bot(settings: settings)

///Callback for handler, that sends Hello message
func grootHandler(_ update: Update, _ context: BotContext?) throws {
    guard let message = update.message else {
        return
    }

    let params = Bot.SendMessageParams(chatId: .chat(message.chat.id), text: "I AM GROOT")
    try bot.sendMessage(params: params)
}

do {
    let dispatcher = Dispatcher(bot: bot)

    let handler = MessageHandler(filters: .text, callback: grootHandler)
    dispatcher.add(handler: handler)

    ///Longpolling updates
    _ = try Updater(bot: bot, dispatcher: dispatcher).startLongpolling().wait()

} catch {
    print(error.localizedDescription)
}
