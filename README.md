# Local Dev #

This set of scripts should get your local development environment up to a shared baseline.

Once complete, you are free to install additional dev tools in WSL2 (or in Windows without admin rights).

[TOC]

## Instructions ##

### Step 1: Clone the repository ###

First, either clone or download this repository to a directory on your machine.

#### Option 1: Clone ####

    git clone https://github.com/erubino1977/local-dev.git

Using the clone method, you can update to the latest scripts anytime by running "git pull".

#### Option 2: Download ####

If you do not have Git on your machine, click "..." at the top right of this repository's page on BitBucket and 
choose "Download repository". Then, simply extract it to a location on your hard drive.

### Step 2 (Optional): Reset existing WSL Ubuntu distro ###

This step will completely erase your existing "Ubuntu" WSL2 install if present. It's only needed if you run into issues 
or want to start from a clean slate.

WARNING: Make sure you back up all files you wish to keep within your WSL distro before you do this.

Run the "00-reset.bat" file from the local-dev folder.

### Step 3: Install Ubuntu ###

Now we're going to set up WSL2 and install Ubuntu. This step can also update an existing Ubuntu install to WSL2 if needed.

Run "01-wsl.bat" from the local-dev folder.

When prompted, enter a username and password. Once you get to a Linux prompt, simply press Ctrl+D to exit.

Note: It does not have to be the same as your Windows login.

### Step 4: Basic dev setup ###

Next, we'll update the system and install some dev tools that will be needed.

Run "02-basic.bat", then grab a coffee and enjoy a couple quiet minutes.

Ensure there were no errors before moving on.

![If you got errors, you're gonna have a bad time](https://i.imgflip.com/6vmiiy.jpg)

### Step 5: Extra tooling ###

Next, you can install your preferred local dev tools, or skip this step and install your own instead.
You can install any combination of these tools together if you'd like.

#### Lando ####

Run "03-lando.bat" and wait a few minutes.

Once complete, you should have the "lando" command available in your WSL terminal.

#### DDEV ####

Run "03-ddev.bat" and wait for it to install.

Once complete, you should have the "ddev" command available in your WSL terminal.

#### Docksal ####

Run "03-docksal.bat" and wait for it to install.

Once complete, you should be able to use docksal through the WSL terminal.

#### Your own tooling ####

If you want to install other tools on the Linux command line, feel free to do so at this time.

### Step 6: VS Code ###

Installing VS Code on your Windows box makes for the smoothest local dev experience possible.

#### Install VS Code ####

Simply [download VS Code](https://code.visualstudio.com/docs/?dv=win) and then run the installer on your Windows machine.

#### Install WSL extension ####

Open VS Code, and then hit Ctrl+P to bring up the quick command window.

Type "ext install ms-vscode-remote.remote-wsl" and then press Enter to install the extension.

#### Open a WSL window ####

In the bottom left, click the green icon and choose "New WSL Window" to connect to your WSL instance.

VS Code is now connected to WSL!

### Step 7: Develop! ###

You can check out your projects and run your local dev tools within the terminal.

Tip: Do not store your site files in a folder that is shared with Windows, or file access will slow down 
immensely. VS Code has access to all files within WSL2, so choose a location such as /home/[your name]/dev 
to store your projects in.
