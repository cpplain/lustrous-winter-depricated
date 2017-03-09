class SubjectsController < ApplicationController
  def create
    subject = Subject.create(subject_params)
    return render_success(:created, subject) if subject.valid?
    render_error(:unprocessable_entity, subject.errors)
  end

  def update
    current_subject.update(subject_params)
    return render_success(:ok, current_subject) if current_subject.valid?
    render_error(:unprocessable_entity, current_subject.errors)
  end

  def destroy
    return render_error(:not_found) if current_subject.nil?
    current_subject.destroy
    render_success(:no_content)
  end

  private

  def subject_params
    params.require(:subject).permit(:name, :parent_id)
  end

  def current_subject
    @current_subject ||= Subject.find_by_id(params[:id])
  end
end
