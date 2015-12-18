module Spina
  class User < ActiveRecord::Base
    has_secure_password

    has_and_belongs_to_many :accounts, dependent: :destroy

    validates_presence_of :name, :email
    validates_presence_of :password, on: :create
    validate :uniqueness_of_email
    validates :email, format: { with:/\A[^@]+@[^@]+\z/ }

    def admin?
      admin
    end

    def to_s
      name
    end

    def account_active?
      accounts.present?
    end

    def update_last_logged_in!
      # self.last_logged_in = Time.now
      # self.save!
      # this Time.now is not avaliable at production it will always the server start time
      # at least use Time.zone.now
      touch(:last_logged_in)
    end

    private

    # I think validates :eamil, uniqueness: true  can replace this method
    def uniqueness_of_email
      if email_changed? && User.where(email: email).exists?
        errors.add(:email, I18n.t('errors.messages.taken'))
      end
    end
  end
end
