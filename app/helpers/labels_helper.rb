module LabelsHelper
  def label_list
    Label.where("user_id is null or user_id = ?", current_user.id)
  end
end
