module Gaku::Importers::Students::StudentIdentity
  def normalize_id_num(id_number)
    if id_number.to_i == 0 # ID is alphanumeric
      return id_number.to_s
    else # ID number is a number, defaulted to float from sheet data
      return id_number.to_i.to_s
    end
  end

  def find_student_by_student_ids(serial_id, foreign_id_code = nil)
    student =  Gaku::Student.where(serial_id: normalize_id_num(student_id_number)).first
    return student unless student.nil?
    Gaku::Student.where(foreign_id_code: normalize_id_num(foreign_id_code)).first
  end
end
