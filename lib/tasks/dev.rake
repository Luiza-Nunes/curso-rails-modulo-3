namespace :dev do
  desc "Configura o ambiente de desenvolvimento"
  task setup: :environment do

    if Rails.env.development?
      puts %x(rails db:drop db:create db:migrate dev:add_mining_types dev:add_coins)
    else
      puts "Você não está em ambiente de desenvolvimento!"
    end
  end

  desc "Cadastra as moedas"
  task add_coins: :environment do

    coins = [
      {
      description: "Bitcoin",
      acronym: "BTC",
      url_image: "https://toppng.com/uploads/preview/bitcoin-png-bitcoin-logo-transparent-background-11562933997uxok6gcqjp.png",
      mining_type: MiningType.find_by(acronym: 'Pow')
      },
  
      {
      description: "Dash",
      acronym: "DASH",
      url_image: "https://logowik.com/content/uploads/images/dash9065.jpg",
      mining_type: MiningType.all.sample
      }
    ]
  
    coins.each do |coin|
      Coin.find_or_create_by!(coin)
    end
  end

  desc "Cadastra os tipos de mineração"
  task add_mining_types: :environment do
    
    mining_types = [
      {description: "Proof of Work", acronym: "PoW"},
      {description: "Proof of Stake", acronym: "PoS"},
      {description: "Proof of Capacity", acronym: "PoC"}
    ]

    mining_types.each do |mining_type|
      MiningType.find_or_create_by!(mining_type)
    end
  end

end
