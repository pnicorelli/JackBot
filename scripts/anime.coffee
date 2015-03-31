# Description:
#   Allows hubot to run commands from slack

NODE_TLS_REJECT_UNAUTHORIZED = 0;
userAgent=process.env.USER_AGENT
baseUrl=process.env.BASE_URL
accessToken=process.env.ACCESS_TOKEN

module.exports  = (robot) ->
    robot.hear /ultime ((0?[1-9])|([1-4][0-9])|(50)) anime/i, (msg) ->
        howmany = msg.match[1]
        url = "#{baseUrl}v1/admin/animae?sorting=-creationTime&per_page=#{howmany}"
        console.log "#{url}"
        msg.http("#{url}", {rejectUnauthorized: false})
        .header("user-agent", "#{userAgent}")
        .header("Content-Type", "application/json")
        .header("Authorization", "#{accessToken}")
        .get() (err, res, body) ->
            if err
                msg.send "wops :( #{err}"
                return
            try
                json = JSON.parse(body)
                msg.send "#{msg.message.user.name} le ultime #{howmany} anime sono:\n"
                for item in json.data
                    msg.send " - #{item.title}"
            
            catch error
                msg.send "uhm.... mi sono incasinato: #{error}"

