require_relative 'list_repository'

csv_file = File.join(__dir__, 'input.csv')
path = File.join(__dir__, 'output.csv')
errors_file = File.join(__dir__, 'error.csv')
list_repository = ListRepository.new(csv_file, path, errors_file)
list_repository.load_csv
list_repository.store_csv
list_repository.store_errors
