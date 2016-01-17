class Gaku::Report < ActiveRecord::Base
  belongs_to :reportable
  
  def to_s
    name
  end

end
