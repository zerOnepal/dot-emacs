install:
	@[[ -f ~/.emacs ]] && mv -vf ~/.emacs ~/.emacs$(date +%s).bak || echo "no file to move :P"
	@[[ ! -h ~/.emacs.d ]] && ln -sv ${PWD} ~/.emacs.d || echo "same file sir, nothing_todo_here..Good day Sir. :)"
