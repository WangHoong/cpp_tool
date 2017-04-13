class Cp::Contract < ApplicationRecord
  self.table_name=:cp_contracts
  acts_as_paranoid :column => 'deleted', :column_type => 'boolean'
  audited
  has_many :audits, -> { order(version: :desc) }, as: :auditable, class_name: Audited::Audit.name # override default audits order
  has_many :authorizes,class_name: 'Cp::Authorize' :dependent => :destroy
  has_many :authorize_valids, -> {where('cp_authorizes.end_time >=?',Time.now)},class_name: 'Cp::Authorize'
  has_many :authorize_dues, -> {where('cp_authorizes.end_time <?',Time.now)},class_name: 'Cp::Authorize'

  has_many :assets, as: :target, :dependent => :destroy

  accepts_nested_attributes_for :assets ,   :allow_destroy => true
  accepts_nested_attributes_for :authorizes ,   :allow_destroy => true

  enum pay_type: [:default,:divide,:undivide]
  enum status: [:default,:agree,:disagree]

  validates_presence_of :authorizes

  scope :recent, -> { order('contracts.id DESC') }
  scope :date_between, lambda{ |status|
                             case status
                             when 'valid'   #有效
                               where("start_time < ? AND end_time > ?", Time.now,Time.now)
                             when 'near'   #快到期
                               where("end_time > ? AND end_time < ?", Time.now,Time.now.months_since(3))
                             when 'due'   #过期
                               where("end_time < ?", Time.now)
                             when 'unvalid' #未生效
                               where("start_time > ?", Time.now)
                             end
                           }

  scope :auth_between,  lambda{ |auth|
                             case auth
                             when 'valid'   #有效
                               where('cp_authorizes.end_time >=?',Time.now)
                             when 'due'   #过期
                               where('cp_authorizes.end_time <?',Time.now)
                             end
                           }

   #有效授权数量
   def authorize_valid_cnt
       authorize_valids.size
   end
   #过期授权数量
   def authorize_due_cnt
      authorize_dues.size
   end

   #cp合约授权状态
   def status
      if end_time <= Time.now.months_since(3)
        return 'near'
      elsif start_time <=Time.now && end_time >= Time.now
        return 'valid'
      elsif end_time <= Time.now
        return 'due'
      elsif start_time > Time.now
         return 'unvalid'
      end
   end


end
