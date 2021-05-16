# == Schema Information
#
# Table name: tasks
#
#  id          :bigint           not null, primary key
#  content     :text
#  deadline    :date
#  description :text
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  board_id    :bigint           not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_tasks_on_board_id  (board_id)
#  index_tasks_on_user_id   (user_id)
#
class Task < ApplicationRecord
    belongs_to :board
    belongs_to :user
    has_many :comments, dependent: :destroy
    has_one_attached :eyecatch

    validates :title, presence: true
    validates :content, presence: true

    def display_created_at
        I18n.l(self.created_at,format: :default)
    end

    def display_updated_at
        I18n.l(self.updated_at,format: :default)
    end

    def author_name
        user.display_name
    end

    def comment_count
        comments.count
    end
end
