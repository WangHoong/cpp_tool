include Workflow
module ApproveWorkflow

def create_auditables(user,action,comment)
	write_audit(action: action,user_id: user.id,username: user.name, user_type: 'User', comment: comment)
end

def self.included(base)

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
