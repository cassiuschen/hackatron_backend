# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


sentences = %w(坡上立着一只鹅，坡下就是一条河。宽宽的河，肥肥的鹅，鹅要过河，河要渡鹅不知是鹅过河，还是河渡鹅？ 扁担长，板凳宽，扁担没有板凳宽，板凳没有扁担长。扁担绑在板凳上，板凳不让扁担绑在板凳上。 出南门，走六步，见着六叔和六舅，叫声六叔和六舅，借我六斗六升好绿豆；过了秋，打了豆，还我六叔六舅六十六斗六升好绿豆。 八百标兵奔北坡，北坡炮兵并排跑，炮兵怕把标兵碰，标兵怕碰炮兵炮。 你会炖炖冻豆腐，你来炖我的炖冻豆腐；你不会炖炖冻豆腐，别胡炖乱炖炖坏了我的炖冻豆腐。 一班有个黄贺，二班有个王克，黄贺、王克二人搞创作，黄贺搞木刻，王克写诗歌。黄贺帮助王克写诗歌，王克帮助黄贺搞木刻。由于二人搞协作，黄贺完成了木刻，王克写好了诗歌。)
sentences.each do |s|
	Sentence.create(content: s)
end