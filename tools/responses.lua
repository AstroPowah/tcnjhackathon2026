local responses = {
    greeting = {
        Happy = {"Hi there!", "Hello!", "Hey!", "Hi friend!", "Hello there!"},
        Angry = {"Hey nerd", "What's good Bub"},
        Neutral = {"Hi.", "Hello.", "Hey."},
    },
    question = {
        Happy = {"I'm fine and you?","What do you need help with?", "What are you looking for friend?"},
        Angry = {"I don't need you asking me questions","What are you doing?", "What do you want?"},
        Neutral = {"I'm fine","What?", "I don't understand.", "Can you say that again?"},
    },
    statement = {
        Happy = {"I love you too!", "I like you! too"},
        Angry = {"I hate you!", "I don't like you!"},
        Neutral = {"Okay.", "I see.", "Interesting."},
    },
    neutral = {
        Happy = {"How are you?", "What's Good?"},
        Angry = {"Leave me alone?", "What do you want?"},
        Neutral = {"What?", "Ahh okay", "Can you say that again?"},
    },
}

return responses