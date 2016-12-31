require 'rubygems'
require 'puppetlabs_spec_helper/rake_tasks'
require 'puppet_blacksmith/rake_tasks'
require 'puppet-strings/tasks'
require 'httparty'
require 'json'
require 'yaml'
require 'git'

# Use a custom pattern with git tag. %s is replaced with the version number.
Blacksmith::RakeTask.new do |t|
  t.tag_pattern = '%s'
end

desc '[CI Only] Run beaker, but only for pull requests or for release branches.'
task :acceptance do
  skip = true
  travis_branch = ENV['TRAVIS_BRANCH']
  travis_event_type = ENV['TRAVIS_EVENT_TYPE']

  if travis_event_type == 'pull_request'
    skip = false
  elsif travis_event_type == 'push'
    skip = false if travis_branch =~ /^release-/ || travis_branch =~ /^hotfix-/
  end

  if skip
    puts 'Skipping acceptance tests.'
    exit(0)
  else
    Rake::Task['beaker'].invoke
  end
end

desc '[CI Only] Tag, build and push the module to PuppetForge.'
task :deploy do
  abort('Only deploy from master.') unless ENV['CIRCLE_BRANCH'] == 'master'

  # Find out what the local version of the module is.
  file = File.read('metadata.json')
  data_hash = JSON.parse(file)
  local_version = data_hash['version']
  abort('Unable to find local module version.') unless local_version
  puts "Module version (local): #{local_version}"

  Rake::Task['deploy:tag'].invoke(local_version)
  Rake::Task['deploy:forge'].invoke(local_version)
end

namespace :deploy do
  desc 'Deploy module to Puppet Forge if required.'
  task :forge, [:version] do |_t, args|
    local_version = args[:version]

    # Find out what the forge version of the module is.
<<<<<<< HEAD
    response = HTTParty.get('https://forgeapi.puppetlabs.com/v3/modules/locp-odoo')
=======
    response = HTTParty.get('https://forgeapi.puppetlabs.com/v3/modules/locp-cassandra')
>>>>>>> origin/develop
    data_hash = JSON.parse(response.body)
    forge_version = data_hash['current_release']['version']
    abort('Unable to find out the forge version.') unless forge_version
    puts "Module version (forge): #{forge_version}"
    exit 0 unless local_version != forge_version

    # Build the module.
    puts "Build and deploy version #{local_version}."
    Rake::Task['module:clean'].invoke
    Rake::Task['build'].invoke

    # Now see if we can push this baby to the forge.
<<<<<<< HEAD
=======
    PUPPET_FORGE_CREDENTIALS_FILE = ENV['HOME'] + '/' + '.puppetforge.yml'
    username = ENV['CIRCLE_PROJECT_USERNAME']
    password = ENV['PUPPET_FORGE_PASSWORD']
    abort("Not enough data to populate #{PUPPET_FORGE_CREDENTIALS_FILE}") unless username && password
    puts "Populating #{PUPPET_FORGE_CREDENTIALS_FILE}"
    credentials = { 'username' => username, 'password' => password }
    File.open(PUPPET_FORGE_CREDENTIALS_FILE, 'w') { |f| f.write credentials.to_yaml }
>>>>>>> origin/develop
    Rake::Task['module:push'].invoke
  end
end

namespace :deploy do
  desc 'Deploy tag for the module'
  task :tag, [:version] do |_t, args|
    tagname = args[:version]
    # Find out if a tag is available for this version.
    log = Logger.new(STDOUT)
    log.level = Logger::WARN
    git = Git.open('.', log: log)

    begin
      git.tag(tagname)
    rescue Git::GitTagNameDoesNotExist
      puts "Creating tag: #{tagname}"
      git.add_tag(tagname, 'master', message: 'tagged by RubyAutoDeployTest', f: true)
      git.push('origin', "refs/tags/#{tagname}", f: true)
    else
      puts "Tag: #{tagname} already exists."
    end
  end
end
<<<<<<< HEAD

desc 'Run metadata_lint, rubocop, lint, validate and spec.'
task test: [
  :metadata_lint,
  :rubocop,
  :lint,
  :validate,
  :spec
]
=======
>>>>>>> origin/develop
