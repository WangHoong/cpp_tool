module ApproveWorkflow

def self.included(base)
  base.has_one :approve, :as => :target
  base.after_create do
    Approve.create(target_id: self.id,
                   target_type: base,
                   status: self.current_state,
                   creator: 'wyg'
    )
  end
  def base.approve(params, obj)
    case params['approve_status']
    when 'accept'
      obj.accept!
    when 'reject'
      obj.reject!(params['not_through_reason'])
    else
      raise Workflow::NoTransitionAllowed, "There is no the #{params['approve_status']} state"
    end
  end

  def base.batchApprove(objs)
    objs.update(approve_status: :accepted).map do |i|
      i.approve.update(approve_at: Time.now, approver: 'wyg1', status: 'accepted', not_through_reason: nil)
    end
  end
   base.workflow_column :approve_status
   base.workflow do
     state :pending do
       event :accept, :transitions_to => :accepted
       event :reject, :transitions_to => :rejected
     end
     state :accepted do
       event :reject, :transitions_to => :rejected
     end
     state :rejected do
       event :accept, :transitions_to => :accepted
     end
     on_transition do |from, to, triggering_event, *event_args|
       case to.to_s
       when 'rejected'
         self.approve.update(approve_at: Time.now, approver: 'wyg1', status: to, not_through_reason: event_args[0])
       else
         self.approve.update(approve_at: Time.now, approver: 'wyg1', status: to, not_through_reason: nil)
       end
     end
   end
 end
end
