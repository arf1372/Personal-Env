# .bash_profile

# This one is used to replace ssh-agent by gpg-agent and use gpg
# keys for ssh login and authentication.
if [ -f "${HOME}/.gpg-agent-info" ]; then
     source "${HOME}/.gpg-agent-info"
       export GPG_AGENT_INFO
       export SSH_AUTH_SOCK
       export SSH_AGENT_PID
else
    eval $( gpg-agent --daemon --write-env-file ~/.gpg-agent-info )
fi

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs
