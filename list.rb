class List
  attr_reader :first_name, :last_name, :scope_id, :mail

  def initialize(first_name, last_name, scope_id, mail)
    @first_name = first_name
    @last_name = last_name
    @scope_id = scope_id
    @mail = mail
  end
end
