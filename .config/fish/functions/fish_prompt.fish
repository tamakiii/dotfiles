function fish_prompt --description 'Write out the prompt'
	set -l last_status $status
    echo

    if set -l git_branch (command git symbolic-ref HEAD 2>/dev/null | string replace refs/heads/ '')
        set git_branch (set_color -o blue)"$git_branch"
        set git_status (set_color green)
        set git_info "$git_status$git_branch"
    end

    # (set_color $fish_color_cwd)
    printf '%s%s' (set_color normal) (echo $PWD | sed -e "s|^$HOME|~|") (set_color white) " $git_info" (set_color white)

    if not test $last_status -eq 0
        set_color $fish_color_error
    end

    echo
    echo -n '$ '
    set_color normal
end
