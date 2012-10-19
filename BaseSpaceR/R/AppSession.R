.AppSession <- setRefClass("AppSession",
                           fields = list(session_id = "character"),
                           contains = "AppAuth"
                           )
