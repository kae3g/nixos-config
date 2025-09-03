#!/usr/bin/env bash

# Setup GitHub repository for configuration sync
# Run this script to push your configuration to GitHub

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "🐙 Setting up GitHub repository..."

# Check if remote already exists
if git remote get-url origin >/dev/null 2>&1; then
    echo "📡 Remote origin already exists:"
    git remote get-url origin
    echo ""
    read -p "Do you want to update it? (y/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        read -p "Enter GitHub repository URL: " REPO_URL
        git remote set-url origin "$REPO_URL"
    fi
else
    echo "📡 No remote repository configured."
    echo "Please create a new repository on GitHub first, then:"
    echo "1. Copy the repository URL (e.g., https://github.com/username/nixos-config.git)"
    echo "2. Run: git remote add origin <repository-url>"
    echo "3. Run: git push -u origin master"
    echo ""
    read -p "Enter GitHub repository URL (or press Enter to skip): " REPO_URL
    if [ -n "$REPO_URL" ]; then
        git remote add origin "$REPO_URL"
        echo "✅ Remote added: $REPO_URL"
    fi
fi

# Push to GitHub if remote exists
if git remote get-url origin >/dev/null 2>&1; then
    echo "🚀 Pushing to GitHub..."
    git push -u origin master
    echo "✅ Configuration pushed to GitHub!"
    echo ""
    echo "🔗 Your configuration is now available at:"
    git remote get-url origin | sed 's/\.git$//'
else
    echo "⚠️  No remote repository configured. Run this script again after setting up GitHub repo."
fi

echo ""
echo "📋 To sync changes in the future:"
echo "1. Edit files in: $SCRIPT_DIR"
echo "2. Run: git add ."
echo "3. Run: git commit -m 'Update configuration'"
echo "4. Run: git push"
