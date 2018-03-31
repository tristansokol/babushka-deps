dep 'jq' do
  requires 'jq.install'
end

dep 'jq.install' do
  met? {
    shell?('brew list jq &> /dev/null')
  }
  meet do
    log_shell('Installing jq', 'brew install jq')
  end
end
