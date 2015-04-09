# Description:
#   Allows hubot to run commands from slack

NODE_TLS_REJECT_UNAUTHORIZED = 0;
userAgent=process.env.USER_AGENT
baseUrl=process.env.BASE_URL
accessToken=process.env.ACCESS_TOKEN

module.exports  = (robot) ->
    robot.hear /memo per categoria/i, (msg) ->
        url = "#{baseUrl}v1/admin/stats/memos/categories"
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
                #console.log "#{body}"
                json = JSON.parse(body)
                msg.send "#{msg.message.user.name} conto #{json.memos} memos spalmati su:\n"
                for item in json.byCategory
                    msg.send "> #{item.memos} in #{item.category}"
            
            catch error
                msg.send "uhm.... mi sono incasinato: #{error}"

    robot.hear /memo per tipo/i, (msg) ->
        url = "#{baseUrl}v1/admin/stats/memos/slotsType"
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
                #console.log "#{body}"
                json = JSON.parse(body)
                msg.send "#{msg.message.user.name} conto #{json.memos} memos spalmati su:\n"
                for item in json.bySlotTypeId
                    msg.send "> #{item.memos} in #{item.type}"

            catch error
                msg.send "uhm.... mi sono incasinato: #{error}"

