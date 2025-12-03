class Ticket < ApplicationRecord
  # The person who created the ticket
  belongs_to :user

  # The agent/admin assigned to handle the ticket (optional)
  belongs_to :assigned_to, class_name: "User", optional: true

  # A ticket can have many comments
  has_many :comments, dependent: :destroy

  # A ticket can have many attached files
  has_many_attached :attachments

  # Rails 8 enum syntax for status
  enum :status, { open: 0, in_progress: 1, resolved: 2 }

  # Rails 8 enum syntax for priority
  enum :priority, { low: 0, medium: 1, high: 2 }

  # Important fields must be present
  validates :title, :description, :status, :priority, presence: true
end
