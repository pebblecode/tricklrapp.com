module ApplicationHelper

  def time_ago_in_words_with_word(date, word = "ago")
    "#{time_ago_in_words(date)} #{word}"
  end

  def parse_tweet(tweet)
    # to do 
    tweet
  end
end
