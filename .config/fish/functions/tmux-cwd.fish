function tmux-cwd
	tmux command-prompt "attach -c %1 $PWD"
end
