require 'csv'
require_relative 'list'

class ListRepository
  def initialize(csv_file, path, errors_file)
    @lists = []
    @errors = []
    @csv_file = csv_file
    @path = path
    @error_file = errors_file
    @scope_id = 14
  end

  def load_csv
    csv_options = { col_sep: ',', quote_char: '"', headers: :first_row }
    email_pattern = /([a-zA-Z]+)\.([a-zA-Z]+)@([a-zA-Z]+)\.([a-zA-Z]+)/
    CSV.foreach(@csv_file, csv_options) do |row|
      groups = row['email'].match(email_pattern)
      if !groups
        @errors << row['email']
      else
        @lists << List.new(groups[1], groups[2], @scope_id, groups[0])
      end
    end
  end

  def store_csv
    options = { col_sep: ',', force_quotes: true, quote_char: '"' }
    CSV.open(@path, 'a', options) do |csv|
      @lists.each do |list|
        csv << [list.first_name.downcase, list.last_name.downcase, list.scope_id, list.mail.downcase]
      end
    end
  end

  def store_errors
    options = { col_sep: ',', force_quotes: true, quote_char: '"' }
    CSV.open(@error_file, 'a', options) do |csv|
      csv << @errors
    end
  end
end
