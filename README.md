# GitMover
A Python + Bash script to migrate milestones, collaborators, commonts, labels, issues, pull requests, and releases between repositories.

There was once no easy way to migrate your team's collaborative work (Milestones, Labels, Issues) to another repository. This was especially thorny for teams moving a project into GitHub Enterprise, or open sourcing an existing project by moving it out of GitHub Enterprise. This is a tool to help that process.

## Dependencies
This fork of GitMover is just a Bash script wrapped around a Python script. You'll need `requests`, `argparse` and a few
other Python modules installed. Install them with `pip`:

```
pip install -r requirements.txt
```

## Usage
First make the script executable
```bash
$ chmod +x main.sh
```
Then run it as follows. All flags are required.
```bash
$ ./main.sh [-u  | --username [GITHUB_USERNAME]]
            [-t  | --token [GITHUB_PERSONAL_ACCESS_TOKEN]]
            [-so | --source-org [SOURCE_ORGANIZATION]]
            [-sr | --source-repo [SOURCE_REPOSITORY]]
            [-do | --dest-org [DESTINATION_ORGANIZATION]]
            [-dr | --dest-repo [DESTINATION_REPOSITORY]]
```
If you want to run the python script alone you may use the following.
Note: The python script will only copy github artifacts like PRs, comments, etc... and it will not copy the core git elements like all the code, commit history, etc...
```bash
$ git-mover.py [-h] [--destinationToken [DESTINATIONTOKEN]]
                    [--destinationUserName [DESTINATIONUSERNAME]]
                    [--sourceRoot [SOURCEROOT]]
                    [--destinationRoot [DESTINATIONROOT]] [--milestones]
                    [--labels] [--issues]
                    user_name token source_repo destination_repo
```

For authentication, GitMover uses a personal access token, which can be generated in your GitHub Profile settings.

### Positional Arguments for Python Script
  `user_name`: Your GitHub (public or enterprise) username: name@email.com
  
  `token`: Your GitHub (public or enterprise) personal access token
  
  `source_repo`: the team and repo to migrate from: `<team_name>/<repo_name>`
  
  `destination_repo`: the team and repo to migrate to: `<team_name>/<repo_name>`
  
### Optional Arguments for Python Script
  `-h, --help`: show this help message and exit
  
  `--sourceRoot [SOURCEROOT], -sr [SOURCEROOT]`: The GitHub domain to migrate from. Defaults to https://www.github.com. For GitHub enterprise customers, enter the domain for your GitHub installation.
  
  `--destinationRoot [DESTINATIONROOT], -dr [DESTINATIONROOT]`: The GitHub domain to migrate to. Defaults to https://www.github.com. For GitHub enterprise customers, enter the domain for your GitHub installation.
  
  `--destinationToken [DESTINATIONTOKEN], -dt [DESTINATIONTOKEN]`: Your personal access token for the destination account, if you are migrating between different GitHub installations.
  
  `--destinationUserName [DESTINATIONUSERNAME], -dun [DESTINATIONUSERNAME]`: Username (email address) for destination account, if you are migrating between different GitHub installations.
  
  `--milestones, -m`: Toggle on Milestone migration.
  
  `--labels, -l`: Toggle on Label migration.
  
  `--issues, -i`: Toggle on Issue migration.

  `--releases, -r`: Toggle on Release migration.
