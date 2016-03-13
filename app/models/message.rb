class Message < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged
    
  default_scope {order('created_at DESC')}  
  belongs_to :user      
  has_many :comments, dependent: :destroy
  validates :title, :body, presence: true   

  def normalize_friendly_id(input)
    input.to_s.to_slug.normalize.to_s
  end

  def should_generate_new_friendly_id?
    slug.blank? || title_changed?
  end  

  def resolve_friendly_id_conflict(candidates)
      same_slug = Message.where("slug like '#{title}-%'")
      max_sequence = 0
      same_slug.each do |s|
        if s.slug.split("-").last.to_i > max_sequence
          max_sequence = s.slug.split("-").last.to_i
        end
      end
      max_sequence += 1
      if candidates.first
        candidates.first + friendly_id_config.sequence_separator + max_sequence.to_s
      else
        # 只有在title空時會走到這裡, 接著進入controller在save時就會重新render :new, 不會真的存
        "error_path"
      end
  end  
end
