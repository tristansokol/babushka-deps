dep 'ssh' do
  requires 'public key',
  'github-ssh'
end

dep 'public key', :email, :passphrase do
  met? { '~/.ssh/id_rsa.pub'.p.grep(/^ssh-rsa/) }
  meet { log_shell 'Generating a new key', "ssh-keygen -t rsa -N #{passphrase} -C #{email} -f ~/.ssh/id_rsa" }
end

dep 'github-ssh' do
  log("NEEDS TO BE FINISHED")
  met?{'ssh -T git@github.com'}
end
