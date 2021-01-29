class Note < ActiveRecord::Base

  belongs_to :notable, polymorphic: true
  belongs_to :contact
end
