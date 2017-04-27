class Sp::Contract < ApplicationRecord
  self.table_name=:sp_contracts
  audited
  has_many :audits, -> { order(version: :desc) }, as: :auditable, class_name: Audited::Audit.name # override default audits order
  belongs_to :dsp
  belongs_to :department
  has_many :assets, as: :target, :dependent => :destroy
  has_many :authorizes, :dependent => :destroy
  has_many :authorize_valids, -> {where('sp_authorizes.end_time >=?',Time.now)},class_name: 'Sp::Authorize'
  has_many :authorize_dues, -> {where('sp_authorizes.end_time <?',Time.now)},class_name: 'Sp::Authorize'
  accepts_nested_attributes_for :assets ,   :allow_destroy => true
  accepts_nested_attributes_for :authorizes ,   :allow_destroy => true

  enum pay_type: [:default,:divide,:undivide]

  validates_presence_of :authorizes
  #validates :dsp_id, presence: true
  scope :recent, -> { order('sp_contracts.id DESC') }
  scope :date_between, lambda{ |status|
                             case status
                             when 'valid'   #有效
                               where("contract_start_time < ? AND contract_end_time > ?", Time.now,Time.now)
                             when 'near'   #快到期
                               where("contract_end_time > ? AND contract_end_time < ?", Time.now,Time.now.months_since(3))
                             when 'due'   #过期
                               where("contract_end_time < ?", Time.now)
                             when 'unvalid' #未生效
                               where("contract_start_time > ?", Time.now)
                             end
                           }

 scope :auth_between,  lambda{ |auth|
                            case auth
                            when 'valid'   #有效
                              where('sp_authorizes.end_time > ?',Time.now)
                            when 'due'   #过期
                              where('sp_authorizes.end_time < ?',Time.now)
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

 


end
