# Initial Setup

1. Create SSH key (see [GitHub docs](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account)):
    1. Create keypair locally:
        ```sh
        ssh-keygen -t ed25519 -N '' -f "${HOME}/.ssh/id_ed25519-github-com"
        ```
    1. Edit the SSH config (e.g. `vi "$HOME/.ssh/config"`).
        Add the following block:
        ```
        Host github.com
          AddKeysToAgent yes
          UseKeychain yes
          IdentityFile ~/.ssh/id_ed25519-github-com
          IdentitiesOnly yes
        ```
    1. Copy the public key:
        ```sh
        < "${HOME}/.ssh/id_ed25519-github-com.pub" pbcopy
        ```
    1. [Add the public key to your GitHub account](https://github.com/settings/ssh/new).
1. Clone this repo and enter the directory:
    ```sh
    git clone git@github.com:jscheytt/dotfiles.git "${HOME}/Documents/dotfiles"
    cd "${HOME}/Documents/dotfiles"
    ```
1. Run these Make targets:
    ```sh
    make install build
    ```
