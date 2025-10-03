#!/bin/bash

# PR Monitoring Script
PR_URL="https://github.com/gshubham55/terminal-ide/pull/1"
PR_NUMBER="1"
REPO="gshubham55/terminal-ide"

echo "🔄 Starting PR Comment Monitor for ${PR_URL}"
echo "Duration: 48 hours (1 hour intervals)"
echo "================================================"

for hour in {1..48}; do
    echo ""
    echo "⏰ Hour ${hour}/48 - $(date)"
    echo "------------------------------------------------"
    
    # Fetch PR comments
    echo "📥 Fetching PR comments..."
    gh pr view ${PR_NUMBER} --repo ${REPO} --json comments,reviews > /tmp/pr_data_${hour}.json 2>/dev/null
    
    if [ $? -eq 0 ]; then
        # Check for new comments
        COMMENT_COUNT=$(jq '.comments | length' /tmp/pr_data_${hour}.json 2>/dev/null || echo "0")
        REVIEW_COUNT=$(jq '.reviews | length' /tmp/pr_data_${hour}.json 2>/dev/null || echo "0")
        
        echo "💬 Found ${COMMENT_COUNT} general comments and ${REVIEW_COUNT} reviews"
        
        # Display any comments found
        if [ "${COMMENT_COUNT}" != "0" ]; then
            echo "Comments:"
            jq -r '.comments[] | "  - [\(.author.login)]: \(.body)"' /tmp/pr_data_${hour}.json 2>/dev/null
        fi
        
        if [ "${REVIEW_COUNT}" != "0" ]; then
            echo "Reviews:"
            jq -r '.reviews[] | "  - [\(.author.login)] \(.state): \(.body // "No comment")"' /tmp/pr_data_${hour}.json 2>/dev/null
        fi
    else
        echo "⚠️  Failed to fetch PR data"
    fi
    
    # Only sleep if not the last iteration
    if [ ${hour} -lt 48 ]; then
        echo "😴 Sleeping for 1 hour..."
        sleep 3600
    fi
done

echo ""
echo "✅ Monitoring complete: 48/48 hours"
echo "================================================"
