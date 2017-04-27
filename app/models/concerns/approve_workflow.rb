module ApproveWorkflow

def self.included(base)
  def base.approve(params, obj)
    case params['status']
    when 'accept'
      obj.accept!
    when 'reject'
      obj.reject!(params['not_through_reason'])
    else
      raise Workflow::NoTransitionAllowed, "There is no the #{params['status']} state"
    end
  end

  def base.batchApprove(objs)
    objs && objs.update(status: :accepted, not_through_reason: nil)
  end
   base.workflow_column :status
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
         self.update(status: to, not_through_reason: event_args[0])
       else
         self.update(status: to, not_through_reason: nil)
       end
     end
   end
 end
end
