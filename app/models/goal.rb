class Goal < ActiveRecord::Base
  STATUSES = %w(INCOMPLETE COMPLETE)
  
  validates :title, :status, presence: true
  validates :private, inclusion: { in: [true, false] }
  validates :status, inclusion: { in: STATUSES }
  
  belongs_to :user
end