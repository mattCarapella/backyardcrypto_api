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

#User.create!({username: "AdminUser", id: 1, email: "admin@backyardcrypto.com", password: "password", password_confirmation: "password", terms_of_service: true, admin: true})
#User.create!({username: "ModUser", email: "moderator@backyardcrypto.com", password: "password", password_confirmation: "password", terms_of_service: true, moderator: true})
#User.create!({username: "User", email: "user@backyardcrypto.com", password: "password", password_confirmation: "password", terms_of_service: true})

Coin.create!(currency_name: "Bitcoin", currency_abbrev: "BTC", founder: "Satoshi Nakamoto", mineable: true, website: "https://btc.com/", reddit: "https://www.reddit.com/r/bitcoin/", facebook: "https://www.facebook.com/bitcoin/", twitter: "https://twitter.com/bitcoin?lang=en", discord: "https://discord.me/page/bitcoin", github: "https://github.com/bitcoin", coinmarketcap: "https://coinmarketcap.com/currencies/bitcoin/", slug: "bitcoin", accepted: true, pending: false, rejected: false, coinmarket_id: 1, user_id: 1)

Coin.create!(currency_name: "Dogecoin", currency_abbrev: "DOGE", founder: "Jackson Palmer", mineable: true,website: "https://dogecoin.com/", reddit: "https://www.reddit.com/r/dogecoin/", facebook: "https://www.facebook.com/OfficialDogecoin/", twitter: "https://twitter.com/dogecoin?lang=en", discord: "https://discord.me/page/dogecoin", github: "https://github.com/dogecoin/dogecoin", coinmarketcap: "https://coinmarketcap.com/currencies/dogecoin/", slug: "dogecoin", accepted: true, pending: false, rejected: false, coinmarket_id: 74, user_id: 1)

Coin.create!(currency_name: "FakeCoin", currency_abbrev: "FCK", founder: "Some Dude", mineable: true, website: "https://fc.com/", reddit: "https://www.reddit.com/r/fc/", facebook: "https://www.facebook.com/fc/", twitter: "https://twitter.com/fc?lang=en", discord: "https://discord.me/page/fc", github: "https://github.com/fc", coinmarketcap: "https://coinmarketcap.com/currencies/fc/", slug: "fc", accepted: true, pending: false, rejected: false, coinmarket_id: 2, user_id: 1)


Coin.create!(currency_name: "pendingCoin", currency_abbrev: "PND", founder: "Some Dude", mineable: true, website: "https://fc.com/", reddit: "https://www.reddit.com/r/fc/", facebook: "https://www.facebook.com/fc/", twitter: "https://twitter.com/fc?lang=en", discord: "https://discord.me/page/fc", github: "https://github.com/fc", coinmarketcap: "https://coinmarketcap.com/currencies/fc/", slug: "pc", accepted: false, pending: true, rejected: false, coinmarket_id: 3, user_id: 1)

#########################################################################################################

Question.create!(ques_num: 1, id: 1, content:  "<p>Overview sample DOGE. Overview sample DOGE. Overview sample DOGE. Overview sample DOGE. Overview sample DOGE. Overview sample DOGE. Overview sample DOGE. Overview sample DOGE. Overview sample DOGE. Overview sample DOGE. Overview sample DOGE. Overview sample DOGE. </p>\r\n", user_id: 1, coin_id: 2, accepted: true, pending: false, rejected: false)

Question.create!(ques_num: 6, id: 2, content:  "<p>History sample DOGE. History sample DOGE. History sample DOGE. History sample DOGE. History sample DOGE. History sample DOGE. History sample DOGE. History sample DOGE. History sample DOGE. History sample DOGE. History sample DOGE. History sample DOGE. History sample DOGE. History sample DOGE. History sample DOGE. History sample DOGE. </p>\r\n", user_id: 1, coin_id: 2, accepted: true, pending: false, rejected: false)

Question.create!(ques_num: 7, id: 3, content:  "<p>Goverence Model sample DOGE. Goverence Model sample DOGE. Goverence Model sample DOGE. Goverence Model sample DOGE. Goverence Model sample DOGE. Goverence Model sample DOGE. Goverence Model sample DOGE. Goverence Model sample DOGE. Goverence Model sample DOGE. Goverence Model sample DOGE. Goverence Model sample DOGE. Goverence Model sample DOGE. Goverence Model sample DOGE. Goverence Model sample DOGE. Goverence Model sample DOGE. </p>\r\n", user_id: 1, coin_id: 2, accepted: true, pending: false, rejected: false)

Question.create!(ques_num: 8, id: 4, content:  "<p>Business Model sample DOGE. Business Model sample DOGE. Business Model sample DOGE. Business Model sample DOGE. Business Model sample DOGE. Business Model sample DOGE. Business Model sample DOGE. Business Model sample DOGE. Business Model sample DOGE. Business Model sample DOGE. Business Model sample DOGE. Business Model sample DOGE. Business Model sample DOGE. Business Model sample DOGE. Business Model sample DOGE. Business Model sample DOGE. Business Model sample DOGE. Business Model sample DOGE. </p>\r\n", user_id: 1, coin_id: 2, accepted: true, pending: false, rejected: false)

Question.create!(ques_num: 9, id: 5, content:  "<p>Use Cases sample DOGE. Use Cases sample DOGE. Use Cases sample DOGE. Use Cases sample DOGE. Use Cases sample DOGE. Use Cases sample DOGE. Use Cases sample DOGE. Use Cases sample DOGE. Use Cases sample DOGE. Use Cases sample DOGE. Use Cases sample DOGE. Use Cases sample DOGE. Use Cases sample DOGE. Use Cases sample DOGE. Use Cases sample DOGE. </p>\r\n", user_id: 1, coin_id: 2, accepted: true, pending: false, rejected: false)


Question.create!(ques_num: 5, id: 6, open_topic: "Sample Topic 1 DOGE", content:  "<p>topic 1 topic 1 topic 1 topic 1 topic 1 topic 1 topic 1 topic 1 topic 1 topic 1 topic 1 </p>\r\n", user_id: 1, coin_id: 2, accepted: true, pending: false, rejected: false)


Question.create!(ques_num: 5, id: 7, open_topic: "Sample Topic 2 DOGE", content:  "<p>topic 2 topic 2 topic 2 topic 2 topic 2 topic 2 topic 2 topic 2 topic 2 topic 2 topic 2 </p>\r\n", 
								 user_id: 1, coin_id: 2, accepted: true, pending: false, rejected: false)

Question.create!(ques_num: 1, id: 8, content:  "<p>Overview sample DOGE. Overview sample DOGE. Overview sample DOGE. Overview sample DOGE. Overview sample DOGE. Overview sample DOGE. Overview sample DOGE. Overview sample DOGE. Overview sample DOGE. Overview sample DOGE. Overview sample DOGE. Overview sample DOGE. </p>\r\n", user_id: 1, coin_id: 2, accepted: true, pending: false, rejected: false)

(1..30).to_a.each do |index|
  event = Event.create(content: "DOGE Event #{index}",  coin_id: 2, user_id: 1, link: Faker::Internet.url, city: Faker::Address.city, state: Faker::Address.state_abbr, country: "United States", description: Faker::Lorem.sentence(12), accepted: true, pending: false, rejected: false) 
end

(1..30).to_a.each do |index|
  event = Event.create(content: "DOGE PendingEvent #{index}",  coin_id: 2, user_id: 1,link: Faker::Internet.url,city: Faker::Address.city, state: Faker::Address.state_abbr, country: "United States", description: Faker::Lorem.sentence(12), accepted: false, pending: true, rejected: false) 
end

(1..30).to_a.each do |index|
  link = Link.create(url: Faker::Internet.url, websitename: "TestExchange #{index}", tag: "website", description: Faker::Lorem.sentence(12), exchange: false, accepted: true, pending: false, rejected: false, coin_id: 2, user_id: 1) 
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
  term = Term.create(title: "DOGE AcceptedTerm #{index}", caption: Faker::Lorem.sentence(4), content: Faker::Lorem.sentence(12), accepted: true, pending: false, rejected: false, coin_id: 2, user_id: 1) 
end

(1..25).to_a.each do |index|
  term = Term.create(title: "DOGE PendingTerm #{index}", caption: Faker::Lorem.sentence(4), content: Faker::Lorem.sentence(12), accepted: false, pending: true, rejected: false, coin_id: 2, user_id: 1) 
end

(1..25).to_a.each do |index|
  term = Term.create(title: "DOGE RejectedTerm #{index}", caption: Faker::Lorem.sentence(4), content: Faker::Lorem.sentence(12), accepted: false, pending: false, rejected: true, coin_id: 2, user_id: 1) 
end

(1..25).to_a.each do |index|
  kp = KeyPlayer.create(title: "DOGE AcceptedKP #{index}", caption: Faker::Lorem.sentence(4), content: Faker::Lorem.sentence(12), accepted: true, pending: false, rejected: false, coin_id: 2, user_id: 1) 
end

(1..25).to_a.each do |index|
  kp = KeyPlayer.create(title: "DOGE PendingKP #{index}", caption: Faker::Lorem.sentence(4), content: Faker::Lorem.sentence(12), accepted: false, pending: true, rejected: false, coin_id: 2, user_id: 1) 
end

(1..25).to_a.each do |index|
  term = Term.create(title: "DOGE RejectedKP #{index}", caption: Faker::Lorem.sentence(4), content: Faker::Lorem.sentence(12), accepted: false, pending: false, rejected: true, coin_id: 2, user_id: 1) 
end

(1..25).to_a.each do |index|
  post = Post.create(title: "Coin Post #{index}", content: Faker::Lorem.sentence(12), url: Faker::Internet.url, coin_id: 2, user_id: 1) 
end

#########################################################################################################

Question.create!(ques_num: 6, id: 9, content:  "<p>History sample BTC. History sample BTC. History sample BTC. History sample BTC. History sample BTC. History sample BTC. History sample BTC. History sample BTC. History sample BTC. History sample BTC. History sample BTC. History sample BTC. History sample BTC. History sample BTC. History sample BTC. History sample BTC. </p>\r\n", user_id: 1, coin_id: 1, accepted: true, pending: false, rejected: false)

Question.create!(ques_num: 7, id:10, content:  "<p>Goverence Model sample BTC. Goverence Model sample BTC. Goverence Model sample BTC. Goverence Model sample BTC. Goverence Model sample BTC. Goverence Model sample BTC. Goverence Model sample BTC. Goverence Model sample BTC. Goverence Model sample BTC. Goverence Model sample BTC. Goverence Model sample BTC. Goverence Model sample BTC. Goverence Model sample BTC. Goverence Model sample BTC. Goverence Model sample BTC. </p>\r\n", user_id: 1, coin_id: 1, accepted: true, pending: false, rejected: false)

Question.create!(ques_num: 8, id: 11, content:  "<p>Business Model sample BTC. Business Model sample BTC. Business Model sample BTC. Business Model sample BTC. Business Model sample BTC. Business Model sample BTC. Business Model sample BTC. Business Model sample BTC. Business Model sample BTC. Business Model sample BTC. Business Model sample BTC. Business Model sample BTC. Business Model sample BTC. Business Model sample BTC. Business Model sample BTC. Business Model sample BTC. Business Model sample BTC. Business Model sample BTC. </p>\r\n", user_id: 1, coin_id: 1, accepted: true, pending: false, rejected: false)

Question.create!(ques_num: 9, id: 12, content:  "<p>Use Cases sample BTC. Use Cases sample BTC. Use Cases sample BTC. Use Cases sample BTC. Use Cases sample BTC. Use Cases sample BTC. Use Cases sample BTC. Use Cases sample BTC. Use Cases sample BTC. Use Cases sample BTC. Use Cases sample BTC. Use Cases sample BTC. Use Cases sample BTC. Use Cases sample BTC. Use Cases sample BTC. </p>\r\n", user_id: 1, coin_id: 1, accepted: true, pending: false, rejected: false)


Question.create!(ques_num: 5, id: 13, open_topic: "Sample Topic 1 BTC", content:  "<p>topic 1 topic 1 topic 1 topic 1 topic 1 topic 1 topic 1 topic 1 topic 1 topic 1 topic 1 </p>\r\n", user_id: 1, coin_id: 1, accepted: true, pending: false, rejected: false)


Question.create!(ques_num: 5, id: 14, open_topic: "Sample Topic 2 BTC", content:  "<p>topic 2 topic 2 topic 2 topic 2 topic 2 topic 2 topic 2 topic 2 topic 2 topic 2 topic 2 </p>\r\n", 
								 user_id: 1, coin_id: 1, accepted: true, pending: false, rejected: false)

Question.create!(ques_num: 1, id: 15, content:  "<p>Overview sample BTC. Overview sample BTC. Overview sample BTC. Overview sample BTC. Overview sample BTC. Overview sample BTC. Overview sample BTC. Overview sample BTC. Overview sample BTC. Overview sample BTC. Overview sample BTC. Overview sample BTC. </p>\r\n", user_id: 1, coin_id: 1, accepted: true, pending: false, rejected: false)

(1..30).to_a.each do |index|
  event = Event.create(content: "BTC Event #{index}",  coin_id: 1, user_id: 1, link: Faker::Internet.url, city: Faker::Address.city, state: Faker::Address.state_abbr, country: "United States", description: Faker::Lorem.sentence(12), accepted: true, pending: false, rejected: false) 
end

(1..30).to_a.each do |index|
  event = Event.create(content: "BTC PendingEvent #{index}",  coin_id: 1, user_id: 1,link: Faker::Internet.url,city: Faker::Address.city, state: Faker::Address.state_abbr, country: "United States", description: Faker::Lorem.sentence(12), accepted: false, pending: true, rejected: false) 
end

(1..30).to_a.each do |index|
  link = Link.create(url: Faker::Internet.url, websitename: "TestExchange #{index}", tag: "website", description: Faker::Lorem.sentence(12), exchange: true, accepted: true, pending: false, rejected: false, coin_id: 1, user_id: 1) 
end

(1..30).to_a.each do |index|
  link = Link.create(url: Faker::Internet.url, websitename: "TestLink #{index}", tag: "exchange", description: Faker::Lorem.sentence(12), exchange: false, accepted: true, pending: false, rejected: false, coin_id: 1, user_id: 1) 
end

(1..30).to_a.each do |index|
  link = Link.create(url: Faker::Internet.url, websitename: "PendingLink #{index}", tag: "exchange", description: Faker::Lorem.sentence(12), exchange: false, accepted: false, pending: false, rejected: true, coin_id: 1, user_id: 1) 
end

(1..30).to_a.each do |index|
  link = Link.create(url: Faker::Internet.url, websitename: "RejectedLink #{index}", tag: "exchange", description: Faker::Lorem.sentence(12), exchange: false, accepted: false, pending: true, rejected: false, coin_id: 1, user_id: 1) 
end

(1..25).to_a.each do |index|
  term = Term.create(title: "BTC AcceptedTerm #{index}", caption: Faker::Lorem.sentence(4), content: Faker::Lorem.sentence(12), accepted: true, pending: false, rejected: false, coin_id: 1, user_id: 1) 
end

(1..25).to_a.each do |index|
  term = Term.create(title: "BTC PendingTerm #{index}", caption: Faker::Lorem.sentence(4), content: Faker::Lorem.sentence(12), accepted: false, pending: true, rejected: false, coin_id: 1, user_id: 1) 
end

(1..25).to_a.each do |index|
  term = Term.create(title: "BTC RejectedTerm #{index}", caption: Faker::Lorem.sentence(4), content: Faker::Lorem.sentence(12), accepted: false, pending: false, rejected: true, coin_id: 1, user_id: 1) 
end

(1..25).to_a.each do |index|
  kp = KeyPlayer.create(title: "BTC AcceptedKP #{index}", caption: Faker::Lorem.sentence(4), content: Faker::Lorem.sentence(12), accepted: true, pending: false, rejected: false, coin_id: 1, user_id: 1) 
end

(1..25).to_a.each do |index|
  kp = KeyPlayer.create(title: "BTC PendingKP #{index}", caption: Faker::Lorem.sentence(4), content: Faker::Lorem.sentence(12), accepted: false, pending: true, rejected: false, coin_id: 1, user_id: 1) 
end

(1..25).to_a.each do |index|
  term = Term.create(title: "BTC RejectedKP #{index}", caption: Faker::Lorem.sentence(4), content: Faker::Lorem.sentence(12), accepted: false, pending: false, rejected: true, coin_id: 1, user_id: 1) 
end

(1..25).to_a.each do |index|
  post = Post.create(title: "Coin Post #{index}", content: Faker::Lorem.sentence(12), url: Faker::Internet.url, coin_id: 1, user_id: 1) 
end

#########################################################################################################

(1..25).to_a.each do |index|
  post = Post.create(title: "Whole Site Post #{index}", content: Faker::Lorem.sentence(12), url: Faker::Internet.url, coin_id: nil, user_id: 1) 
end



