
# Neovim Configuration with LazyVim

This repository contains my custom Neovim configuration, leveraging LazyVim to provide a modern and efficient editing experience. The configuration is designed to be modular and allows for seamless plugin management. The setup uses an `init.lua` that automatically adds any new plugin configurations present in the `plugins` folder.

## Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Requirements](#requirements)
- [Installation](#installation)
- [Managing Neovim Versions](#managing-neovim-versions)
- [Customization](#customization)
- [Usage](#usage)
- [Acknowledgements](#acknowledgements)

## Overview

This Neovim configuration aims to provide a powerful yet flexible editing experience with a variety of plugins and settings. It includes:

- **Lazy-loaded Plugins:** Leveraging LazyVim ensures that plugins are only loaded when needed, improving startup time and overall responsiveness.
- **Automatic Loading:** Automatically detects and loads plugin configurations placed in the `plugins` folder.
- Designed to work seamlessly with the **Alacritty** terminal emulator.

## Features

- **LazyVim Integration:** This configuration uses [LazyVim](https://github.com/folke/lazy.nvim) to manage plugins efficiently.
- **Automatic Plugin Loading:** Any `.lua` file placed in the `plugins` directory will be automatically detected and loaded.
- **Modular Structure:** Easily extend the setup by adding or modifying plugin configurations in the `plugins` folder.
- **Version Management:** Uses [bob](https://github.com/MordechaiHadad/bob) to manage Neovim versions.
- **Terminal Compatibility:** Optimized for use with the Alacritty terminal emulator.

## Requirements

- **Neovim**: v0.8.0 or higher (managed via `bob`)
- **Alacritty**: A lightweight terminal emulator ([download here](https://github.com/alacritty/alacritty))
- **Git**: Ensure Git is installed to clone the repository and manage plugins.

## Installation

1. **Clone the Repository**

   ```bash
   git clone https://github.com/Grep-Juub/nvim-lua.git ~/.config/nvim
   ```

   This will clone the configuration into the appropriate directory for Neovim.

2. **Install Dependencies**

   - Ensure you have `git` and `curl` installed on your system.
   - Install `bob`, the Neovim version manager, as detailed below.

3. **Run Neovim**

   Launch Neovim, and LazyVim will automatically handle the plugin installation for you:

   ```bash
   nvim
   ```

   On the first startup, it may take a little while as it installs and configures all the required plugins.

## Managing Neovim Versions with `bob`

To manage your Neovim versions, I use [`bob`](https://github.com/MordechaiHadad/bob), which is a version manager specifically designed for Neovim.

### Installing `bob`

1. **Download and Install**

   ```bash
   curl -sL https://raw.githubusercontent.com/MordechaiHadad/bob/master/install | bash
   ```

2. **Set up `bob` in your PATH**

   Ensure that `bob` is added to your PATH by appending the following line to your shell configuration (`.bashrc` or `.zshrc`):

   ```bash
   export PATH="$HOME/.local/bin:$PATH"
   ```

3. **Use `bob` to Install Neovim**

   With `bob`, you can install the latest version of Neovim:

   ```bash
   bob install latest
   ```

   You can specify a specific version if needed:

   ```bash
   bob install v0.9.0
   ```

   You can also switch between versions using:

   ```bash
   bob use v0.9.0
   ```

## Customization

### Adding New Plugins

1. Create a new file in the `plugins` folder for each plugin you want to add. For example:

   ```bash
   ~/.config/nvim/lua/plugins/myplugin.lua
   ```

2. Define the plugin and its configuration using Lua. The configuration uses a mechanism that scans and loads all `.lua` files from the `plugins` directory using the `collect_plugins` function defined in `init.lua`.

### Editing Configurations

You can customize the general settings by modifying the `init.lua` file or any existing files in the `plugins` directory.

## Usage

- Open Neovim with the configuration:

  ```bash
  nvim
  ```

- LazyVim will handle plugin management automatically. You can update all plugins using the command:

  ```
  :Lazy sync
  ```

## Acknowledgements

- [LazyVim](https://github.com/folke/lazy.nvim) for providing an efficient plugin management system.
- [bob](https://github.com/MordechaiHadad/bob) for Neovim version management.
- [Alacritty](https://github.com/alacritty/alacritty) for being a great terminal emulator.

---

By following this guide, you should have a seamless and powerful Neovim setup that can be easily expanded and customized to suit your workflow. Enjoy coding with Neovim and LazyVim! 🎉

