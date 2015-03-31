# Description:
#   Allows hubot to run commands from slack

NODE_TLS_REJECT_UNAUTHORIZED = 0;
userAgent=process.env.USER_AGENT
baseUrl=process.env.BASE_URL
accessToken=process.env.ACCESS_TOKEN

module.exports  = (robot) ->

    robot.hear /usersStats|userstats|userstat/i, (msg) ->
        url = "#{baseUrl}v1/admin/stats/users"
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
                msg.send "In questo momento ne conto #{json.registered} registrati\n"
                msg.send "con una frequenza di accesso di #{json.access_frequency}\n"
            catch error
                msg.send "uhm.... mi sono incasinato: #{error}"

    robot.hear /animaeStats|animestats|animestat/i, (msg) ->
        url = "#{baseUrl}v1/admin/stats/animae"
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
                msg.send "In questo momento ne conto #{json.animae} in tutto...\n spalmate su \n"
                printAnimaeInCategories( msg, json.by_category)
            catch error
                msg.send "uhm.... mi sono incasinato: #{error}"


printAnimaeInCategories = (msg, data) ->
    url = "#{baseUrl}/v1/categories"
    msg.http("#{url}", {rejectUnauthorized: false})
        .header("user-agent", "#{userAgent}")
        .header("Content-Type", "application/json")
        .header("Authorization", "#{accessToken}")
        .get() (err, res, body) ->
            json = JSON.parse(body)
            map = []
            for item in json["categories"]
                map[ item._id ] = item.title
            for item in data
                catName = map[ item.categoryId ]
                msg.send "#{item.count} in *#{catName}*\n"
            

