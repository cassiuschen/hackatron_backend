class Sentence
  include Mongoid::Document
  field :content, type: String
  field :pinyin, type: String
  after_create do
    self.pinyin = PinYin.of_string(self.content, true)
    self.save
  end

  def diff(str)
    str = PinYin.of_string str, true
    dif = []

    (0..self.pinyin.size).each do |i|
      right = []
      str.size.times {right << 0}
      dif << [i].concat(right)
    end

    dif[0] = (0..str.size).to_a

    (1..self.pinyin.size).each do |i|
      (1..str.size).each do |j|
        tmp = self.pinyin[i - 1] == str[j - 1] ? 0 : 1
        leftTop = dif[i - 1][j - 1] + tmp
        top = dif[i][j - 1] + 1
        left = dif[i - 1][j] + 1
        dif[i][j] = [leftTop, left, top].min
      end
    end

    return (1.00000 - dif.last.last.to_f / [self.pinyin.length, str.length].max) * 100
  end
end
