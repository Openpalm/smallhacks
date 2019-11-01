#!/bin/bash

 git add . --all

 git status
 git commit -a -m "$1"
 git push

