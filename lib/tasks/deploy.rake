# Rake tasks to help with deployment
#
# Usage:
#    rake shipit[some-branch]
#
# Prerequisites:
#   * branches are set up on local machine
#

require 'fileutils'

DEPLOYMENT_BRANCHES = ["staging"]
DEPLOY_ONLY_BRANCHES = []

desc "Merge master to branch, and push to origin server."
task "merge_master_and_push_to", [:branch] do |t, args|
  checkout_merge_cmd = "git checkout #{args.branch}; git merge master"
  sh(checkout_merge_cmd) do |ok, res|
    if ok
      push_cmd = "git push origin #{args.branch}:#{args.branch}"
      sh push_cmd
      sh %{ git checkout master }
    else
      puts res
    end
  end
end

desc "Deploy branch to server."
task :deploy, [:branch] do |t, args|
  deploy_cmd = "bundle exec cap #{args.branch} deploy"
  sh deploy_cmd
end

desc "Ship it! Merge and push branch to origin (if not in `DEPLOY_ONLY_BRANCHES`), then deploy to the server."
task "shipit", [:branch] do |t, args|
  if DEPLOYMENT_BRANCHES.include? args.branch
    unless DEPLOY_ONLY_BRANCHES.include? args.branch
      Rake::Task["merge_master_and_push_to"].invoke(args.branch)
    end

    Rake::Task["deploy"].invoke(args.branch)
  else
    puts "Invalid deployment branch: #{args.branch}"
    puts "Available deployment branches are: #{DEPLOYMENT_BRANCHES.to_sentence}"
  end
end

