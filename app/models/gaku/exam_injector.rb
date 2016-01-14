module Gaku
  Exam.class_eval do
    has_many :reports, as: :reportable

  end
end
