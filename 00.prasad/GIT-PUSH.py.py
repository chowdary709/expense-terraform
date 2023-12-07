import subprocess
import os
import platform

COUNT_FILE = os.path.expanduser('~/.count')

def initialize_count_file():
    with open(COUNT_FILE, 'w') as f:
        f.write("0")

def git_push():
    with open(COUNT_FILE, 'r') as f:
        variable_count = int(f.read().strip())

    subprocess.run(['git', 'add', '.'])
    variable_count += 1
    with open(COUNT_FILE, 'w') as f:
        f.write(str(variable_count))

    commit_message = f"automated commit #{variable_count}"
    subprocess.run(['git', 'commit', '-m', commit_message])
    subprocess.run(['git', 'push'])

if not os.path.exists(COUNT_FILE):
    initialize_count_file()

git_push()


