class Gaku::Exams::ReportsController < Gaku::GakuController

    before_action :set_exam
    before_action :set_template_names

    def index
      @reports = @exam.reports
    end

    def new
      @report = Gaku::Report.new
    end

    def create
      @report = @exam.reports.build(report_params)
      @report.save!
    end

    def destroy
      @report = Gaku::Report.find(params[:id])
      @report.destroy!
      set_count

      respond_with @report
    end

    private

    def set_exam
      @exam = Gaku::Exam.find(params[:exam_id])
    end

    def set_count
      @count = @exam.reload.reports.count
    end

    def report_params
      params.require(:report).permit(:name)
    end


    def set_template_names
      @template_names = Gaku::Exporters::Exams::Templates.template_names
    end

end
