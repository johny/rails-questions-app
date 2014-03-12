class Topic < ActiveRecord::Base

  acts_as_nested_set

  validates_presence_of :name, :message => "can't be blank"


  include Workflow
  workflow do

    # Model is new, fresh created and awaiting moderation
    state :pending do
      event :publish, transitions_to: :active
    end

    # Model offer is published and visible on site
    state :active do
      event :unpublish, transitions_to: :pending
      event :archive, transitions_to: :archived
    end

    # Old jobs, imported and archived
    state :archived
  end

end
