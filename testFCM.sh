
curl -X POST --header "Authorization: key=$api_key" --header "Content-Type: application/json" https://fcm.googleapis.com/fcm/send -d '{
      "to" : "fcFhHl-d1EwyngWsVh4Dzr:APA91bEBeAltImzm6oTz42LBNTS-DpFV3dIjjfBpFoR37ZPZmCd6NKfwzVSzYxkP0jWGRfAArUthvfEpDbHaREXvOiMZu2RihBYtlZDup69sefUiFWsG-gZz6WDUfhWG_Ab-vkhFMKyY",
      "priority" : "high",
      "notification" : {
       "body" : "Background Message",
          "title" : "BG Title"
          },
       "data" : {
           "title" : "FG Title",
           "message" : "Foreground Message"
       }
    }'

#curl -X POST -H "Authorization: Bearer AIzaSyDxJmiTrQgNneePMNd4M8RLkKLGz5ox0qs" -H "Content-Type: application/json" -d '{
#  "message":{
#    "token":"fUofM_74z0KznC05zsamqv:APA91bEiuPn7YmMkRlGFMKDkQ30G4n3Z0caZnTtj3cJLeo2QrDjxRRpPsYwv4vZHY0rj6RgHIq_d4ce1f6QYapxHpKu_nEAuD-sPjN7Z2AsZOELWmcYMp5cfOkTbtiYszT7gpy5LmWUP",
#    "notification":{
#      "title":"Hello",
#      "body":"This is a text message!"
#    }
#  }
#}' https://fcm.googleapis.com/v1/projects/testflutterfire/messages:send

