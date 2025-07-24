Gem.paths = { 'GEM_HOME' => Dir.pwd + '/.gemnew' }
require 'bundler/inline'
gemfile true do
  source 'https://rubygems.org'
  gem 'markaby', '0.9.4'
end

mab = Markaby::Builder.new
mab.table.blog_entries! do
  tbody :align => "center" do
    tr {
      td "29/02"
      td {
        a "A new method", :href => 'foo.html'
      }
    }
  end
end
p mab.to_s
