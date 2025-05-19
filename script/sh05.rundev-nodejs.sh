#!/bin/bash
current_dir=$(pwd)
export current_dir=$current_dir
echo "Current directory: $current_dir"
npm install
npm run dev