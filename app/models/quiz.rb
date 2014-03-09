class Quiz < ActiveRecord::Base

  has_and_belongs_to_many :questions

  include Workflow
  workflow do

    # Model is new, fresh created and awaiting moderation
    state :pending do
      event :publish, transitions_to: :active
    end

    # Model offer is published and visible on site
    state :active do
      event :unpublish, transitions_to: :new
      event :expire, transitions_to: :expired
    end

    # Model offer expired after 30 days, visible in archive
    state :expired

    # Old jobs, imported and archived
    state :archived
  end

end
