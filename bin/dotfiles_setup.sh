#!/bin/zsh

nvim --headless "+Lazy! sync" +qa
nvim --headless +'helptags ALL' +':TSUpdateSync ruby c lua rust python markdown make go cpp bash' +qa
