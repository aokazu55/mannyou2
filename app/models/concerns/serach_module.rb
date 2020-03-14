module SearchModule
  extend ActiveSupport::Concern
  included do
    scope :desc_sort_create_at, -> {order(created_at: :desc)}
    scope :desc_deadline, -> {order(deadline: :desc)}
    scope :asc_priority, -> {order(priority: :asc)}
    scope :sort_title, -> (title){where('title LIKE ?', "%#{ title }%")}
    scope :sort_status, -> (status){where('status LIKE ?', "%#{ status }%")}
    scope :sort_label, -> (label_id){where(labels: {id: label_id})}
    scope :sort_title_and_status, -> (title,status){sort_title(title).sort_status(status)}
    scope :sort_title_and_label, -> (title,label_id){sort_title(title).sort_label(label_id)}
    scope :sort_status_and_label, -> (status,label_id){sort_status(status).sort_label(label_id)}
    scope :sort_all, -> (title,status,label_id){sort_title(title).sort_status(status).sort_label(label_id)}

    def self.set_sort(params)
      if params[:sort_deadline_desc]
        desc_deadline
      elsif params[:sort_priority_asc]
        asc_priority
      elsif params[:task].present?
        if params[:task][:title].present? && params[:task][:status].present? && params[:task][:label_id].present?
          sort_all(params[:task][:title],params[:task][:status],params[:task][:label_id])
        elsif params[:task][:title].present? && params[:task][:status].present?
          sort_title_and_status(params[:task][:title],params[:task][:status])
        elsif params[:task][:title].present? && params[:task][:label_id].present?
          sort_title_and_label(params[:task][:title],params[:task][:label_id])
        elsif params[:task][:status].present? && params[:task][:label_id].present?
          sort_status_and_label(params[:task][:status],params[:task][:label_id])
        elsif params[:task][:status].present?
          sort_status(params[:task][:status])
        elsif params[:task][:title].present?
          sort_title(params[:task][:title])
        elsif params[:task][:label_id].present?
          sort_label(params[:task][:label_id])
        else
          desc_sort_create_at
        end
      else
        desc_sort_create_at
      end
    end
  end
end
