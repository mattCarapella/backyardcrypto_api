# Genre.create!(name: "proof_of_work", displayname: "Proof of Work")
# Genre.create!(name: "proof_of_stake", displayname: "Proof of Stake")
# Genre.create!(name: "store_of_value", displayname: "Store of Value")
# Genre.create!(name: "platforms", displayname: "Platforms")  
# Genre.create!(name: "masternodes", displayname: "Masternodes") 
# Genre.create!(name: "privacy", displayname: "Privacy") 
# Genre.create!(name: "finance", displayname: "Finance") 
# Genre.create!(name: "exchanges", displayname: "Exchanges") 
# Genre.create!(name: "medical", displayname: "Medical") 
# Genre.create!(name: "iot_and_mesh_networks", displayname: "IOT & Mesh Networks") 
# Genre.create!(name: "gaming", displayname: "Gaming") 
# Genre.create!(name: "prediction_markets", displayname: "Prediction Markets")
# Genre.create!(name: "media_and_marketing", displayname: "Media & Marketing")
# Genre.create!(name: "identity", displayname: "Identity")
# Genre.create!(name: "energy_and_utilities", displayname: "Energy & Utilities")
# Genre.create!(name: "social", displayname: "Social")
# Genre.create!(name: "dividends", displayname: "Dividends")
# Genre.create!(name: "computing_and_data", displayname: "Computing & Data")

# User.create!({username: "AdminUser", id: 1, email: "admin@backyardcrypto.com", password: "password", password_confirmation: "password", terms_of_service: true, admin: true})
# #User.create!({username: "ModUser", email: "moderator@backyardcrypto.com", password: "password", password_confirmation: "password", terms_of_service: true, moderator: true})
# #User.create!({username: "User", email: "user@backyardcrypto.com", password: "password", password_confirmation: "password", terms_of_service: true})


# Coin.create!(currency_name: "Dogecoin", currency_abbrev: "DOGE", founder: "Jackson Palmer", mineable: true, 
# 						 website: "https://dogecoin.com/", reddit: "https://www.reddit.com/r/dogecoin/", 
# 						 facebook: "https://www.facebook.com/OfficialDogecoin/", twitter: "https://twitter.com/dogecoin?lang=en", 
# 						 discord: "https://discord.me/page/dogecoin", github: "https://github.com/dogecoin/dogecoin", 
# 						 coinmarketcap: "https://coinmarketcap.com/currencies/dogecoin/", slug: "dogecoin", 
# 						 accepted: true, pending: false, rejected: false, coinmarket_id: 74, user_id: 1)


# Coin.create!(currency_name: "Bitcoin", currency_abbrev: "BTC", founder: "Satoshi Nakamoto", mineable: true, 
# 						 website: "https://btc.com/", reddit: "https://www.reddit.com/r/bitcoin/", 
# 						 facebook: "https://www.facebook.com/bitcoin/", twitter: "https://twitter.com/bitcoin?lang=en", 
# 						 discord: "https://discord.me/page/bitcoin", github: "https://github.com/bitcoin", 
# 						 coinmarketcap: "https://coinmarketcap.com/currencies/bitcoin/", slug: "bitcoin", 
# 						 accepted: true, pending: false, rejected: false, coinmarket_id: 1, user_id: 1)


Coin.create!(currency_name: "FakeCoin", currency_abbrev: "FCK", founder: "Some Dude", mineable: true, 
						 website: "https://fc.com/", reddit: "https://www.reddit.com/r/fc/", 
						 facebook: "https://www.facebook.com/fc/", twitter: "https://twitter.com/fc?lang=en", 
						 discord: "https://discord.me/page/fc", github: "https://github.com/fc", 
						 coinmarketcap: "https://coinmarketcap.com/currencies/fc/", slug: "fc", 
						 accepted: true, pending: false, rejected: false, coinmarket_id: 2, user_id: 1)


# Question.create!(ques_num: 1, id: 1, content:  "<p>Overview sample DOGE. Overview sample DOGE. Overview sample DOGE. Overview sample DOGE. Overview sample DOGE. Overview sample DOGE. Overview sample DOGE. Overview sample DOGE. Overview sample DOGE. Overview sample DOGE. Overview sample DOGE. Overview sample DOGE. </p>\r\n", 
# 								 user_id: 1, coin_id: 1, accepted: true, pending: false, rejected: false)

# Question.create!(ques_num: 6, id: 2, content:  "<p>History sample. History sample. History sample. History sample. History sample. History sample. History sample. History sample. History sample. History sample. History sample. History sample. History sample. History sample. History sample. History sample. </p>\r\n", 
# 								 user_id: 1, coin_id: 1, accepted: true, pending: false, rejected: false)

# Question.create!(ques_num: 7, id: 3, content:  "<p>Goverence Model sample. Goverence Model sample. Goverence Model sample. Goverence Model sample. Goverence Model sample. Goverence Model sample. Goverence Model sample. Goverence Model sample. Goverence Model sample. Goverence Model sample. Goverence Model sample. Goverence Model sample. Goverence Model sample. Goverence Model sample. Goverence Model sample. </p>\r\n", 
# 								 user_id: 1, coin_id: 1, accepted: true, pending: false, rejected: false)

# Question.create!(ques_num: 8, id: 4, content:  "<p>Business Model sample. Business Model sample. Business Model sample. Business Model sample. Business Model sample. Business Model sample. Business Model sample. Business Model sample. Business Model sample. Business Model sample. Business Model sample. Business Model sample. Business Model sample. Business Model sample. Business Model sample. Business Model sample. Business Model sample. Business Model sample. </p>\r\n", 
# 								 user_id: 1, coin_id: 1, accepted: true, pending: false, rejected: false)

# Question.create!(ques_num: 9, id: 5, content:  "<p>Use Cases sample. Use Cases sample. Use Cases sample. Use Cases sample. Use Cases sample. Use Cases sample. Use Cases sample. Use Cases sample. Use Cases sample. Use Cases sample. Use Cases sample. Use Cases sample. Use Cases sample. Use Cases sample. Use Cases sample. </p>\r\n", 
# 								 user_id: 1, coin_id: 1, accepted: true, pending: false, rejected: false)


# Question.create!(ques_num: 5, id: 6, open_topic: "Sample Topic 1", content:  "<p>topic 1 topic 1 topic 1 topic 1 topic 1 topic 1 topic 1 topic 1 topic 1 topic 1 topic 1 </p>\r\n", 
# 								 user_id: 1, coin_id: 1, accepted: true, pending: false, rejected: false)


# Question.create!(ques_num: 5, id: 7, open_topic: "Sample Topic 2", content:  "<p>topic 2 topic 2 topic 2 topic 2 topic 2 topic 2 topic 2 topic 2 topic 2 topic 2 topic 2 </p>\r\n", 
# 								 user_id: 1, coin_id: 1, accepted: true, pending: false, rejected: false)

# Question.create!(ques_num: 1, id: 8, content:  "<p>Overview sample BTC. Overview sample BTC. Overview sample BTC. Overview sample BTC. Overview sample BTC. Overview sample BTC. Overview sample BTC. Overview sample BTC. Overview sample BTC. Overview sample BTC. Overview sample BTC. Overview sample BTC. </p>\r\n", 
#  								 user_id: 1, coin_id: 2, accepted: true, pending: false, rejected: false)



# Event.create!(content: "DogeCon XXX",  coin_id: 1, user_id: 1,link: "http://www.dogecon.com", 
# 							city: "New York", state: "NY", country: "United States", 
# 							description: "Commodo viverra maecenas accumsan lacus. Pellentesque massa placerat duis ultricies lacus sed turpis tincidunt. Cursus vitae congue mauris rhoncus aenean vel. Sed arcu non odio euismod. Faucibus purus in massa tempor nec feugiat nisl. Neque volutpat ac tincidunt vitae semper quis. Pharetra et ultrices neque ornare aenean euismod elementum nisi.",
# 							accepted: true, pending: false, rejected: false)

# Link.create!(
# 	url: "www.facebook.com",
# 	coin_id: 1,
# 	user_id: 1,
# 	accepted: true,
# 	websitename: "Facebook",
# 	tag: "website",
# 	rejected: false,
# 	pending: false,
# 	description: 'Faucibus purus in massa tempor nec feugiat nisl. Neque volutpat ac tincidunt vitae semper quis. Pharetra et ultrices neque ornare aenean euismod elementum nisi.',
# 	exchange: false
# )

# Link.create!(
# 	url: "www.testexchange.com",
# 	coin_id: 1,
# 	user_id: 1,
# 	accepted: true,
# 	websitename: "TestExchange",
# 	tag: "website",
# 	rejected: false,
# 	pending: false,
# 	description: 'Faucibus purus in massa tempor nec feugiat nisl. Neque volutpat ac tincidunt vitae semper quis. Pharetra et ultrices neque ornare aenean euismod elementum nisi.',
# 	exchange: true
# )

# Term.create!(
# 	title: 'Cryptography',
# 	caption: 'Cryptography involves creating written or generated codes that allow information to be kept secret. Cryptography converts data into a format that is unreadable for an unauthorized user, allowing it to be transmitted without unauthorized entities decoding it back into a readable format, thus compromising the data..',
# 	content: 'Cryptography involves creating written or generated codes that allow information to be kept secret. Cryptography converts data into a format that is unreadable for an unauthorized user, allowing it to be transmitted without unauthorized entities decoding it back into a readable format, thus compromising the data.',
# 	accepted: true,
# 	pending: false,
# 	rejected: false,
# 	coin_id: 1,
# 	user_id: 1
# )

# Term.create!(
# 	title: 'Mining',
# 	caption: 'Bitcoin mining is the processing of transactions in the digital currency system, in which the records of current Bitcoin transactions, known as a blocks, are added to the record of past transactions, known as the block chain..',
# 	content: 'Bitcoin mining is the processing of transactions in the digital currency system, in which the records of current Bitcoin transactions, known as a blocks, are added to the record of past transactions, known as the block chain.',
# 	accepted: true,
# 	pending: false,
# 	rejected: false,
# 	coin_id: 1,
# 	user_id: 1
# )

# Term.create!(
# 	title: 'Private Key',
# 	caption: 'A private key is a sophisticated form of cryptography that allows a user to access his or her cryptocurrency. A private key is an integral aspect of bitcoin and altcoins, and its security make up helps to protect a user from theft and unauthorized access to funds.',
# 	content: 'A private key is a sophisticated form of cryptography that allows a user to access his or her cryptocurrency. A private key is an integral aspect of bitcoin and altcoins, and its security make up helps to protect a user from theft and unauthorized access to funds.',
# 	accepted: true,
# 	pending: false,
# 	rejected: false,
# 	coin_id: 1,
# 	user_id: 1
# )

# Term.create!(
# 	title: 'Pending 1',
# 	caption: 'A private key is a sophisticated form of cryptography that allows a user to access his or her cryptocurrency. A private key is an integral aspect of bitcoin and altcoins, and its security make up helps to protect a user from theft and unauthorized access to funds.',
# 	content: 'A private key is a sophisticated form of cryptography that allows a user to access his or her cryptocurrency. A private key is an integral aspect of bitcoin and altcoins, and its security make up helps to protect a user from theft and unauthorized access to funds.',
# 	accepted: false,
# 	pending: true,
# 	rejected: false,
# 	coin_id: 1,
# 	user_id: 1
# )

# Term.create!(
# 	title: 'Pending 2',
# 	caption: 'A private key is a sophisticated form of cryptography that allows a user to access his or her cryptocurrency. A private key is an integral aspect of bitcoin and altcoins, and its security make up helps to protect a user from theft and unauthorized access to funds.',
# 	content: 'A private key is a sophisticated form of cryptography that allows a user to access his or her cryptocurrency. A private key is an integral aspect of bitcoin and altcoins, and its security make up helps to protect a user from theft and unauthorized access to funds.',
# 	accepted: false,
# 	pending: true,
# 	rejected: false,
# 	coin_id: 1,
# 	user_id: 1
# )

# KeyPlayer.create!(
# 	title: 'SomeDude',
# 	caption: 'Faucibus purus in massa tempor nec feugiat nisl.',
# 	content: 'Commodo viverra maecenas accumsan lacus. Pellentesque massa ',
# 	accepted: true,
# 	pending: false,
# 	rejected: false,
# 	coin_id: 1,
# 	user_id: 1
# )

# KeyPlayer.create!(
# 	title: 'Satoshi Nakamoto',
# 	caption: 'Founder of Bitcoin.',
# 	content: 'Commodo viverra maecenas accumsan lacus. Pellentesque massa ',
# 	accepted: true,
# 	pending: false,
# 	rejected: false,
# 	coin_id: 1,
# 	user_id: 1
# )

# KeyPlayer.create!(
# 	title: 'Gavin Anderson',
# 	caption: 'Lead of Bitcoins core developers and Chief Scientist of the Bitcoin Foundation.',
# 	content: 'Lead of Bitcoins core developers and Chief Scientist of the Bitcoin Foundation.',
# 	accepted: true,
# 	pending: false,
# 	rejected: false,
# 	coin_id: 1,
# 	user_id: 1
# )

# KeyPlayer.create!(
# 	title: 'Jeff Garzik',
# 	caption: 'Satoshi client core developer, GPU poold software and the founder of Bitcoin Watch..',
# 	content: 'Satoshi client core developer, GPU poold software and the founder of Bitcoin Watch.',
# 	accepted: true,
# 	pending: false,
# 	rejected: false,
# 	coin_id: 1,
# 	user_id: 1
# )

# KeyPlayer.create!(
# 	title: 'Pending 1',
# 	caption: 'Satoshi client core developer, GPU poold software and the founder of Bitcoin Watch..',
# 	content: 'Satoshi client core developer, GPU poold software and the founder of Bitcoin Watch.',
# 	accepted: false,
# 	pending: true,
# 	rejected: false,
# 	coin_id: 1,
# 	user_id: 1
# )

# KeyPlayer.create!(
# 	title: 'Pending 2',
# 	caption: 'Satoshi client core developer, GPU poold software and the founder of Bitcoin Watch..',
# 	content: 'Satoshi client core developer, GPU poold software and the founder of Bitcoin Watch.',
# 	accepted: false,
# 	pending: true,
# 	rejected: false,
# 	coin_id: 1,
# 	user_id: 1
# )

# Post.create!(id: 1, content:  "\r\nAn employee inspects machines for the production of bitcoins.\r\nAn employee inspects machines for the production of bitcoins. Photograph by Olga Maltseva/AFP/Getty Images\r\nText size\r\n\r\nA year ago, Bitcoin was practically a foreign language to me.\r\n\r\nThen I watched an episode of Grey’s Anatomy in which the hospital featured in the show was attacked by a group of hackers, who demanded 4932 Bitcoins in ransom (worth $20 million in the setting of the program). After doing some research and consulting with friends who had bought Bitcoin, I thought, well, maybe I should put some money on it, too. That was my first investment, made before I really understood anything about finance.", url: "https://www.barrons.com/articles/is-bitcoin-dead-and-other-questions-1543669201", coin_id: 1, user_id: 1, title: "I Bought Bitcoin When the Price Was Soaring. Here’s What I Learned")

# Post.create!(id: 2, content: "whole site post example 1. whole site post example 1. whole site post example 1. whole site post example 1. whole site post example 1. whole site post example 1. whole site post example 1. whole site post example 1.", url: "https://www.barrons.com/articles/is-bitcoin-dead-and-other-questions-1543669201", coin_id: nil, user_id: 1, title: "WHOLE SITE POST EXAMPLE 1")

# Post.create!(id: 3, content:  "whole site post example 2. whole site post example 2. whole site post example 2. whole site post example 2. whole site post example 2. whole site post example 2. whole site post example 2. whole site post example 2.", url: "https://www.barrons.com/articles/is-bitcoin-dead-and-other-questions-1543669201", coin_id: nil, user_id: 1, title: "WHOLE SITE POST EXAMPLE 2")



