import json
import sqlite3

# Create bd
con = sqlite3.connect('twits.db')
cursor = con.cursor


# # Create table
# cursor.execute("""CREATE TABLE IF NOT EXISTS twits(
#     name text,
#     tweet_text text,
#     country_code text,
#     lang text,
#     created_at text,
#     location text,
#     sentiment text);
# """)
# con.commit()


# list with twit costs
scores = {}
sent_file = open('AFINN-111.txt')
for i in sent_file:
    word, score = i.split("\t")
    scores[word] = int(score)


# BD join
tweet_file = open("three_minutes_tweets.json")


# prepare JSON
list_of_tweets = []
for line in tweet_file:
    list_of_tweets.append(json.loads(line))


for i in list_of_tweets:
    cost = 0
    # skip deleted
    if "delete" in list(i.keys()):
        pass
    else:
        # check for tweet in AFINN
        if 'text' in i:
            tweet_text = i["text"]
            word_list = tweet_text.split()
            for word in word_list:
                if word in scores:
                    cost = cost + scores[word]
    # Sometimes no country_code
        try:
            country = i['place']['country_code']
        except:
            country = i['place']


        #insert into bd
        con.execute("INSERT INTO twits (name, tweet_text, country_code, lang, created_at, location, sentiment) \
                    VALUES (?,?,?,?,?,?,COALESCE(?, 0))",\
                  [i['user']['name'], i['text'], country, i['lang'], i['created_at'], i['user']['location'], cost])
        con.commit()




