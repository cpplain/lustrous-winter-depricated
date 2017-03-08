class SubjectsController < ApplicationController
  def create
    parent = Subject.find_by_id(subject_params[:parent])
    subject = Subject.create(name: subject_params[:name], parent: parent)
    return render json: subject, status: :created if subject.valid?
    render_errors(subject)
  end

  def update
    subject = Subject.find(params[:id])
    parent = Subject.find_by_id(subject_params[:parent]) if subject_params[:parent]
    subject.update(name: subject_params[:name], parent: parent)
    return render json: subject, status: :ok if subject.valid?
    render_errors(subject)
  end

  private

  def subject_params
    params.require(:subject).permit(:name, :parent)
  end

  def render_errors(subject)
    render json: { errors: subject.errors }, status: :unprocessable_entity
  end
end
