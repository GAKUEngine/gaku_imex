class Gaku::Exams::ExamSessions::ReportsController < Gaku::GakuController

  before_action :set_exam_session
  before_action :set_exam

  def generate
    @report = reporter_class.generate students: @exam_session.students, exam_session: @exam_session, exam: @exam
    send_data @report, filename: report_filename, type: 'application/pdf'
  end

  private

  def reporter_class
    "Gaku::Exporters::Exams::#{params[:template].gsub(' ', '')}".constantize
  end

  def report_filename
    "#{params[:template].parameterize.underscore}_#{@exam.id}.pdf"
  end

  def set_exam_session
    @exam_session = Gaku::ExamSession.find(params[:id])
  end

  def set_exam
    @exam = @exam_session.exam
  end
end
