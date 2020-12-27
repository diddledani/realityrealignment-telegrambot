import { Airgram, Auth } from 'airgram'

const airgram = new Airgram({
    apiId:   parseInt(process.env.API_ID || ''),
    apiHash: process.env.API_HASH || '',
})

airgram.use(new Auth({
    token: process.env.BOT_TOKEN || '',
}))

airgram.on('updateDeleteMessages', async ({update}) => {
    airgram.api.sendMessage({
        chatId: update.chatId,
        options: {
            _: 'messageSendOptions',
            disableNotification: true,
        },
        inputMessageContent: {
            _: 'inputMessageText',
            text: {
                _: 'formattedText',
                text: `Timeline manipulation detected. Reality realignment in progress. You might experience an increase of deja vu and nausia...`,
            },
        },
    })
})
