<h1 align="center">
  <img src="timeline-icon.png" alt="Reality Realignment Bot" width="128px" height="128px">
  <br />
  Reality Realignment Bot
</h1>

Are you fed up with Telegram messages disappearing because users are meddling with Wibbly Wobbly Timey Wimey delete buttons? This bot will monitor the universe timescape and notify the channel. When it detects ripples in the timeline causing reality to fold in upon us, the bot will announce that the course of historical events has been altered.

## Running

### Hosted by me

I'm running an instance of this bot called [RealityRealignmentBot](https://t.me/RealityRealignmentBot), which you can invite to your public channels. Note that this is hosted on a home Internet connection and so the bot may be offline from time to time.

### Hosted by you

Choose between running a source-code checkout from this git repository or using the Docker image. You will need an `API_ID`, `API_HASH`, and `BOT_TOKEN` whichever option you choose.

In the instructions for your choice below, replace `$API_ID` and `$API_HASH` with your app id and hash from https://my.telegram.org/apps.

Create a new bot via [The BotFather](https://t.me/BotFather) on Telegram. In the instructions for your choice below replace `$BOT_TOKEN` with the token you receive from BotFather when you complete the new bot setup. To set up a new bot type `/newbot` to BotFather.

#### Docker

```shell
docker run -e API_ID=$API_ID -e API_HASH=$API_HASH -e BOT_TOKEN=$BOT_TOKEN diddledan/realityrealignment-telegrambot:latest
```

#### Source-code checkout

```shell
git clone https://github.com/diddledan/realityrealignment-telegrambot.git
cd realityrealignment-telegrambot
npm install
npm run build
export API_ID=$API_ID
export API_HASH=$API_HASH
export BOT_TOKEN=$BOT_TOKEN
npm run start
```

## Credits

This bot is created by Daniel Llewellyn (diddledan).

The icon is timeline by shashank sing from [the Noun Project](https://thenounproject.com/).