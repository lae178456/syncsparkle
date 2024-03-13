class RemoveHasTicketAndPaymentOptionsFromEvents < ActiveRecord::Migration[7.1]
  def change
    def change
      remove_column :events, :has_ticket, :boolean
      remove_column :events, :payment_options, :jsonb
    end
  end
end
