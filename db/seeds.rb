Genre.create!(name: "proof_of_work", displayname: "Proof of Work")
Genre.create!(name: "proof_of_stake", displayname: "Proof of Stake")
Genre.create!(name: "store_of_value", displayname: "Store of Value")
Genre.create!(name: "platforms", displayname: "Platforms")  
Genre.create!(name: "masternodes", displayname: "Masternodes") 
Genre.create!(name: "privacy", displayname: "Privacy") 
Genre.create!(name: "finance", displayname: "Finance") 
Genre.create!(name: "exchanges", displayname: "Exchanges") 
Genre.create!(name: "medical", displayname: "Medical") 
Genre.create!(name: "iot_and_mesh_networks", displayname: "IOT & Mesh Networks") 
Genre.create!(name: "gaming", displayname: "Gaming") 
Genre.create!(name: "prediction_markets", displayname: "Prediction Markets")
Genre.create!(name: "media_and_marketing", displayname: "Media & Marketing")
Genre.create!(name: "identity", displayname: "Identity")
Genre.create!(name: "energy_and_utilities", displayname: "Energy & Utilities")
Genre.create!(name: "social", displayname: "Social")
Genre.create!(name: "dividends", displayname: "Dividends")
Genre.create!(name: "computing_and_data", displayname: "Computing & Data")

User.create!({username: "AdminUser", id: 1, email: "admin@backyardcrypto.com", password: "password", password_confirmation: "password", terms_of_service: true, admin: true})
#User.create!({username: "ModUser", email: "moderator@backyardcrypto.com", password: "password", password_confirmation: "password", terms_of_service: true, moderator: true})
#User.create!({username: "User", email: "user@backyardcrypto.com", password: "password", password_confirmation: "password", terms_of_service: true})

Coin.create!(currency_name: "Bitcoin", currency_abbrev: "BTC", founder: "Satoshi Nakamoto", mineable: true, 
						 website: "https://btc.com/", reddit: "https://www.reddit.com/r/bitcoin/", 
						 facebook: "https://www.facebook.com/bitcoin/", twitter: "https://twitter.com/bitcoin?lang=en", 
						 discord: "https://discord.me/page/bitcoin", github: "https://github.com/bitcoin", 
						 coinmarketcap: "https://coinmarketcap.com/currencies/bitcoin/", slug: "bitcoin", 
						 accepted: true, pending: false, rejected: false, coinmarket_id: 1, user_id: 1)

Coin.create!(currency_name: "Dogecoin", currency_abbrev: "DOGE", founder: "Jackson Palmer", mineable: true, 
						 website: "https://dogecoin.com/", reddit: "https://www.reddit.com/r/dogecoin/", 
						 facebook: "https://www.facebook.com/OfficialDogecoin/", twitter: "https://twitter.com/dogecoin?lang=en", 
						 discord: "https://discord.me/page/dogecoin", github: "https://github.com/dogecoin/dogecoin", 
						 coinmarketcap: "https://coinmarketcap.com/currencies/dogecoin/", slug: "dogecoin", 
						 accepted: true, pending: false, rejected: false, coinmarket_id: 74, user_id: 1)


Coin.create!(currency_name: "FakeCoin", currency_abbrev: "FCK", founder: "Some Dude", mineable: true, 
						 website: "https://fc.com/", reddit: "https://www.reddit.com/r/fc/", 
						 facebook: "https://www.facebook.com/fc/", twitter: "https://twitter.com/fc?lang=en", 
						 discord: "https://discord.me/page/fc", github: "https://github.com/fc", 
						 coinmarketcap: "https://coinmarketcap.com/currencies/fc/", slug: "fc", 
						 accepted: true, pending: false, rejected: false, coinmarket_id: 2, user_id: 1)


Coin.create!(currency_name: "pendingCoin", currency_abbrev: "PND", founder: "Some Dude", mineable: true, 
						 website: "https://fc.com/", reddit: "https://www.reddit.com/r/fc/", 
						 facebook: "https://www.facebook.com/fc/", twitter: "https://twitter.com/fc?lang=en", 
						 discord: "https://discord.me/page/fc", github: "https://github.com/fc", 
						 coinmarketcap: "https://coinmarketcap.com/currencies/fc/", slug: "fc", 
						 accepted: false, pending: true, rejected: false, coinmarket_id: 3, user_id: 1)


Question.create!(ques_num: 1, id: 1, content:  "<p>Overview sample DOGE. Overview sample DOGE. Overview sample DOGE. Overview sample DOGE. Overview sample DOGE. Overview sample DOGE. Overview sample DOGE. Overview sample DOGE. Overview sample DOGE. Overview sample DOGE. Overview sample DOGE. Overview sample DOGE. </p>\r\n", user_id: 1, coin_id: 2, accepted: true, pending: false, rejected: false)

Question.create!(ques_num: 6, id: 2, content:  "<p>History sample. History sample. History sample. History sample. History sample. History sample. History sample. History sample. History sample. History sample. History sample. History sample. History sample. History sample. History sample. History sample. </p>\r\n", user_id: 1, coin_id: 2, accepted: true, pending: false, rejected: false)

Question.create!(ques_num: 7, id: 3, content:  "<p>Goverence Model sample. Goverence Model sample. Goverence Model sample. Goverence Model sample. Goverence Model sample. Goverence Model sample. Goverence Model sample. Goverence Model sample. Goverence Model sample. Goverence Model sample. Goverence Model sample. Goverence Model sample. Goverence Model sample. Goverence Model sample. Goverence Model sample. </p>\r\n", user_id: 1, coin_id: 2, accepted: true, pending: false, rejected: false)

Question.create!(ques_num: 8, id: 4, content:  "<p>Business Model sample. Business Model sample. Business Model sample. Business Model sample. Business Model sample. Business Model sample. Business Model sample. Business Model sample. Business Model sample. Business Model sample. Business Model sample. Business Model sample. Business Model sample. Business Model sample. Business Model sample. Business Model sample. Business Model sample. Business Model sample. </p>\r\n", user_id: 1, coin_id: 2, accepted: true, pending: false, rejected: false)

Question.create!(ques_num: 9, id: 5, content:  "<p>Use Cases sample. Use Cases sample. Use Cases sample. Use Cases sample. Use Cases sample. Use Cases sample. Use Cases sample. Use Cases sample. Use Cases sample. Use Cases sample. Use Cases sample. Use Cases sample. Use Cases sample. Use Cases sample. Use Cases sample. </p>\r\n", user_id: 1, coin_id: 2, accepted: true, pending: false, rejected: false)


Question.create!(ques_num: 5, id: 6, open_topic: "Sample Topic 1", content:  "<p>topic 1 topic 1 topic 1 topic 1 topic 1 topic 1 topic 1 topic 1 topic 1 topic 1 topic 1 </p>\r\n", user_id: 1, coin_id: 2, accepted: true, pending: false, rejected: false)


Question.create!(ques_num: 5, id: 7, open_topic: "Sample Topic 2", content:  "<p>topic 2 topic 2 topic 2 topic 2 topic 2 topic 2 topic 2 topic 2 topic 2 topic 2 topic 2 </p>\r\n", 
								 user_id: 1, coin_id: 2, accepted: true, pending: false, rejected: false)

Question.create!(ques_num: 1, id: 8, content:  "<p>Overview sample BTC. Overview sample BTC. Overview sample BTC. Overview sample BTC. Overview sample BTC. Overview sample BTC. Overview sample BTC. Overview sample BTC. Overview sample BTC. Overview sample BTC. Overview sample BTC. Overview sample BTC. </p>\r\n", user_id: 1, coin_id: 2, accepted: true, pending: false, rejected: false)


# Event.create!(content: "Coinvention",  coin_id: 2, user_id: 1,link: "http://www.coinvention.io", 
# 							city: "Philadephia", state: "PA", country: "United States", 
# 							description: "Commodo viverra maecenas accumsan lacus. Pellentesque massa placerat duis ultricies lacus sed turpis tincidunt. Cursus vitae congue mauris rhoncus aenean vel. Sed arcu non odio euismod. Faucibus purus in massa tempor nec feugiat nisl. Neque volutpat ac tincidunt vitae semper quis. Pharetra et ultrices neque ornare aenean euismod elementum nisi.",
# 							accepted: true, pending: false, rejected: false)

(1..30).to_a.each do |index|
  event = Event.create(content: "Event #{index}",  coin_id: 2, user_id: 1, link: Faker::Internet.url, city: Faker::Address.city, state: Faker::Address.state_abbr, country: "United States", description: Faker::Lorem.sentence(12), accepted: true, pending: false, rejected: false) 
end

(1..30).to_a.each do |index|
  event = Event.create(content: "PendingEvent #{index}",  coin_id: 2, user_id: 1,link: Faker::Internet.url,city: Faker::Address.city, state: Faker::Address.state_abbr, country: "United States", description: Faker::Lorem.sentence(12), accepted: false, pending: true, rejected: false) 
end

(1..30).to_a.each do |index|
  link = Link.create(url: Faker::Internet.url, websitename: "TestExchange #{index}", tag: "website", description: Faker::Lorem.sentence(12), exchange: true, accepted: true, pending: false, rejected: false, coin_id: 2, user_id: 1) 
end

(1..30).to_a.each do |index|
  link = Link.create(url: Faker::Internet.url, websitename: "TestLink #{index}", tag: "exchange", description: Faker::Lorem.sentence(12), exchange: false, accepted: true, pending: false, rejected: false, coin_id: 2, user_id: 1) 
end

(1..30).to_a.each do |index|
  link = Link.create(url: Faker::Internet.url, websitename: "PendingLink #{index}", tag: "exchange", description: Faker::Lorem.sentence(12), exchange: false, accepted: false, pending: false, rejected: true, coin_id: 2, user_id: 1) 
end

(1..30).to_a.each do |index|
  link = Link.create(url: Faker::Internet.url, websitename: "RejectedLink #{index}", tag: "exchange", description: Faker::Lorem.sentence(12), exchange: false, accepted: false, pending: true, rejected: false, coin_id: 2, user_id: 1) 
end

(1..25).to_a.each do |index|
  term = Term.create(title: "AcceptedTerm #{index}", caption: Faker::Lorem.sentence(4), content: Faker::Lorem.sentence(12), accepted: true, pending: false, rejected: false, coin_id: 2, user_id: 1) 
end

(1..25).to_a.each do |index|
  term = Term.create(title: "PendingTerm #{index}", caption: Faker::Lorem.sentence(4), content: Faker::Lorem.sentence(12), accepted: false, pending: true, rejected: false, coin_id: 2, user_id: 1) 
end

(1..25).to_a.each do |index|
  term = Term.create(title: "RejectedTerm #{index}", caption: Faker::Lorem.sentence(4), content: Faker::Lorem.sentence(12), accepted: false, pending: false, rejected: true, coin_id: 2, user_id: 1) 
end

(1..25).to_a.each do |index|
  kp = KeyPlayer.create(title: "AcceptedKP #{index}", caption: Faker::Lorem.sentence(4), content: Faker::Lorem.sentence(12), accepted: true, pending: false, rejected: false, coin_id: 2, user_id: 1) 
end

(1..25).to_a.each do |index|
  kp = KeyPlayer.create(title: "PendingKP #{index}", caption: Faker::Lorem.sentence(4), content: Faker::Lorem.sentence(12), accepted: false, pending: true, rejected: false, coin_id: 2, user_id: 1) 
end

(1..25).to_a.each do |index|
  term = Term.create(title: "RejectedKP #{index}", caption: Faker::Lorem.sentence(4), content: Faker::Lorem.sentence(12), accepted: false, pending: false, rejected: true, coin_id: 2, user_id: 1) 
end

(1..25).to_a.each do |index|
  post = Post.create(title: "Coin Post #{index}", content: Faker::Lorem.sentence(12), url: Faker::Internet.url, coin_id: 2, user_id: 1) 
end

(1..25).to_a.each do |index|
  post = Post.create(title: "Whole Site Post #{index}", content: Faker::Lorem.sentence(12), url: Faker::Internet.url, coin_id: nil, user_id: 1) 
end


# Post.create!(id: 1, content: Faker::Lorem.sentence(15), url: Faker::Internet.url, coin_id: 1, user_id: 1, title: "I Bought Bitcoin When the Price Was Soaring. Here’s What I Learned")

# Post.create!(id: 2, content: "whole site post example 1. whole site post example 1. whole site post example 1. whole site post example 1. whole site post example 1. whole site post example 1. whole site post example 1. whole site post example 1.", url: "https://www.barrons.com/articles/is-bitcoin-dead-and-other-questions-1543669201", coin_id: nil, user_id: 1, title: "WHOLE SITE POST EXAMPLE 1")

# Post.create!(id: 3, content:  "whole site post example 2. whole site post example 2. whole site post example 2. whole site post example 2. whole site post example 2. whole site post example 2. whole site post example 2. whole site post example 2.", url: "https://www.barrons.com/articles/is-bitcoin-dead-and-other-questions-1543669201", coin_id: nil, user_id: 1, title: "WHOLE SITE POST EXAMPLE 2")



