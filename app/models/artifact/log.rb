class Artifact::Log < ActiveRecord::Base
  belongs_to :task

  def append(chars)
    self.class.update_all(["message = COALESCE(message, '') || ?", chars], ["id = ?", id])
  end

  def to_s
    message || ""
  end
end
