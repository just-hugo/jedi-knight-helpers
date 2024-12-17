Released in 1997, Dark Forces 2: Jedi Knight used a custom game engine known as the Sith engine, and was designed for early Windows systems such as Windows 95 and Windows 98. 

Playing the game on modern machines is still possible, primarily due to an open-source re-implementation of the game known as OpenJKDF2. The OpenJKDF2 project re-implements the original game engine and files for modern computers. It is cross-platform, and even works on Macs.

However, the project is code-only, which means that it needs game assets from a legally-purchased copy of the game. The game copy can come from a variety of sources, but this guide will show how to use Steam to download the Windows-only game files to a Mac.

Once the Steam game has downloaded and OpenJKDF2 has been installed, the game can be played in its original, vanilla state. 

OpenJKDF2 can be modded with legacy mods from when the game was first released. It can also be updated with AI-upscaled textures and other graphics packs.

# Installing the game with a bash script

**Prerequisites**: The Steam app must be installed on your Macbook,  you must be logged into your Steam account in the app, and you must have purchased a copy of Dark Forces 2: Jedi Knight from Steam. Yes, even though Steam says it’s a Windows-only game.

The installation process is a little tedious, because you have to trick Steam into downloading the game files. For this reason, I’ve created a bash script to automate the installation process. 

The manual installation process is reproduced below, for anyone who can’t or doesn’t want to run the bash script.

To use the bash script, first download the file `installGame.sh`. Run `chmod 755 installGame.sh`  to make the bash script executable. Then, you need to run the script with by using the command `./installGame.sh` . 

The script will automatically open Steam, and then close it after the game files are done downloading. It can take anywhere from several seconds to several minutes depending on your connection. It will then automatically download OpenJKDF2 and extract it to the Steam game directory. 

Once the script has finished running, the game will be playable in a mostly-vanilla state.

# Installing the game manually
## Step 1: download the game files from Steam

Make sure Steam is installed, but **not** currently open, and make sure you have purchased the game through Steam.

Open a Finder window and navigate to

 `MacIntosh HD/Users/(yourUserName)/Library/Application Support /Steam/steamapps`

Create a new file called `appmanifest_32380.acf`

Open the file in a text editor and copy and paste the following:

```jsx
"AppState"
{
        "AppID" "32380"
        "Universe" "1"
        "StateFlags" "1026"
        "installdir" "Star Wars Jedi Knight"
}
```

Open Steam.

Navigate back to your Finder window. There should be a folder called `common` . Click into it. You should see a folder named `Star Wars Jedi Knight` . Click into it and verify that the game files are downloading into the folder.

You can close out Steam as soon as the game files finish downloading.

## Step 2: download OpenJKDF2

Most current release: https://github.com/shinyquagsire23/OpenJKDF2/releases/tag/v0.9.1

Previous release: https://github.com/shinyquagsire23/OpenJKDF2/releases/tag/v0.9.0

The most current OpenJKDF2 release has a bug which broke multiplayer, but the previous release does not have this issue.

Pick which release you want and download the release file. You can find the file for download at the bottom of the release notes, inside the “Assets” caret.

Keep your current Finder window in the Jedi Knight Steam folder. Open a new window to view the downloaded file, which is compressed.

Unzip the compressed file. The unzipped file will be called `OpenJKDF2_universal.app` 

Drag and drop it into the Jedi Knight folder in the other finder window.

Double click `OpenJKDF2_universal.app` and you’ll receive a Mac system warning. Open Mac Settings and navigate to Privacy and Security, where you can select allow the app to run.

Try double clicking the file again, and it should launch the game.

It is fully playable at this point, in its (mostly) original glory.

# Using Levels & Mods

Against all odds, [Massassi.net](http://Massassi.net) is still alive and contains every mod and level we used to play:

https://www.massassi.net/levels/

There are also some mods on other sites (primarily graphics updates) that I have discovered, which I’ll reference below. 

Here’s where Spork is hosted:

https://www.jkdf2.net/download/spork-1-2/

https://www.jkdf2.net/download/spork-level-pack/

## 1. Installing levels

Download the compressed file, expand it, and you’ll find a `.gob` or `.goo` file. These are the file extensions used by the game engine for Jedi Knight and Mysteries of the Sith respectively.

Add `.gob` or `.goo` files to `\Jedi Knight\Episode`  to install the level.

## 2. Installing mods

Spork, Saber Battle X, Ninja Kage, etc. will require a different installation procedure than a level, because they affect the gameplay.

OpenJKDF2’s game implementation included support for mods, so you’ll see an empty `mods`  subfolder in the game directory.

- when you want to play a mod, add the mod’s  `.gob` file to the `/mods`  folder
- when you don’t want that mod to be active, move it out of the `/mods`  folder
- I made another folder called `/modManager`  to hold all the various inactive `.gob`  files
- this is a great place for a helper script in bash to automate adding and removing mods to the `/mods`  folder

Be sure to also check the mod’s Readme file. They often contain useful information, and may contain specific installation instructions.
