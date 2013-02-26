require "date"

# http://jurakudai.blog92.fc2.com/blog-entry-2.html
class Date
  # 第n週目
  def mweek
    (self.day + 6 + (self - self.day + 1).wday) / 7
  end

  # 第n曜日
  def mwday
    mw = mweek
    d = self - ((mw - 1) * 7)
    if self.month == d.month then
      mw
    else
      mw - 1
    end
  end
end
