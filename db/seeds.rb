# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

if User.count.zero?
  #----- User for development -----
  user = User.create({
    provider: 'twitter',
    uid: '12345',
    nickname: 'developer',
    name: 'Developer',
    image_url: 'http://www.gravatar.com/avatar'
  })

  #----- Category for development user -----
  %w[食費 住宅費 光熱費 交際費 自己投資].each do |name|
    user.categories.create({ name: name })
  end

  #----- Trade for development user -----
  def add_trade(user, amount, datetime, memo, category_name, tags)
    trade = user.trades.create({
      amount: amount,
      trade_at: datetime,
      memo: memo,
      category_id: user.categories.find_by(name: category_name).id
    })
    tag_list = trade.tag_list
    tag_list.add(tags)
    user.tag(trade, with: tag_list, on: 'tag') # set tag owner
    trade.save
  end
  add_trade(user,   3000, '2015-01-01 00:00:00', '1週間分の食材', '食費', ['買い出し'])
  add_trade(user, 100000, '2015-01-02 00:00:00', '1月分の家賃', '住宅費', ['固定費'])
  add_trade(user,   2880, '2015-01-03 00:00:00', 'パーフェクトRuby on Rails', '自己投資', ['書籍'])
end
