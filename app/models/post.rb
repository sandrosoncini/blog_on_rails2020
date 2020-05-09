class Post < ApplicationRecord
    belongs_to :user
    has_many :comments, dependent: :destroy
    

    validates :title, presence: true, uniqueness: {case_sensitive: false}
    validates :body, presence: { message: "must exist" },length: { minimum: 50 }
end
