desc 'load contact information test data'
task :load_contacts_test_data => :environment do
  c = Contact.new(:title => "Mr.", :first_name => "Contact1", :middle => "m", :last_name => "lastname1",
                  :suffix => "suffix", :job_title => "CEO", :company => "Company").save
end