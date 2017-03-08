class SubjectsController < ApplicationController
  def create
    parent = Subject.find_by_id(subject_params[:parent])
    subject = Subject.create(name: subject_params[:name], parent: parent)
    return render json: subject, status: :created if subject.valid?
    render json: render_errors(subject), status: :unprocessable_entity
  end

  private

  def subject_params
    params.require(:subject).permit(:name, :parent)
  end

  def render_errors(subject)
    { errors: subject.errors }
  end
end
