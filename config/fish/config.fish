# Uses the first conda installation found in the following list
set -x CONDA_PATH /data/miniconda3/bin/conda $HOME/miniconda3/bin/conda /opt/homebrew/anaconda3/bin/conda

function conda
    echo "Lazy loading conda upon first invocation..."
    functions --erase conda
    for conda_path in $CONDA_PATH
        if test -f $conda_path
            echo "Using Conda installation found in $conda_path"
            eval $conda_path "shell.fish" "hook" | source
            conda $argv
            return
        end
    end
    echo "No conda installation found in $CONDA_PATH"
end 
