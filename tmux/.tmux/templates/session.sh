# Set a custom session root path. Default is `$HOME`.
# Must be called before `initialize_session`.
session_root "~/Projects/{{SESSION_NAME}}"

# Create session with specified name if it does not already exist. If no
# argument is given, session name will be based on layout file name.
if initialize_session "{{SESSION_NAME}}"; then

    new_window "emacs"
    run_cmd "emacs ."
    new_window "lazygit"
    run_cmd "lazygit"
    new_window "zsh"
    select_window 1

fi

# Finalize session creation and switch/attach to it.
finalize_and_go_to_session
