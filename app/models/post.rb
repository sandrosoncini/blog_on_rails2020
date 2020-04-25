class Post < ApplicationRecord
    validates :title, presence: true, uniqueness: {case_sensitive: false}
    validates :body, presence: { message: "must exist" },length: { minimum: 50 }
end
