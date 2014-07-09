class Gaku::Students::ReportsController < Gaku::GakuController
    respond_to :pdf


    def index
      @student = Gaku::Student.find(params[:student_id])
      @school  = Gaku::School.primary
      @guardian = @student.guardians.first

      respond_to do |format|
      format.pdf do
        send_data render_to_string, filename: "student_#{@student.id}.pdf",
                                    type: 'application/pdf',
                                    disposition: 'inline'
      end
    end
    end

end
