class Gaku::Courses::Exams::ReportsController < Gaku::GakuController

  before_action :set_exam
  before_action :set_course

  def generate
    @report = reporter_class.generate students: @course.students
    send_data @report, filename: report_filename, type: 'application/pdf'
  end

  private

  def reporter_class
    "Gaku::Exporters::Exams::#{params[:template].gsub(' ', '')}".constantize
  end

  def report_filename
    "#{params[:template].parameterize.underscore}_#{@exam.id}.pdf"
  end

  def set_exam
    @exam = Gaku::Exam.find(params[:id])
  end

  def set_course
    @course = Gaku::Course.find(params[:course_id])
  end
end
