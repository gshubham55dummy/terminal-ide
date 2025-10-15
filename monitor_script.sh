#!/bin/bash

# 48-hour PR monitoring script
PR_NUMBER="${1:-1}"  # Default to PR #1, or use argument
REPO_OWNER="gshubham55dummy"
REPO_NAME="terminal-ide"

start_time=$(date +%s)
end_time=$((start_time + 172800))  # 48 hours in seconds

echo "🚀 Starting 48-hour monitoring for PR #$PR_NUMBER"
echo "Repository: $REPO_OWNER/$REPO_NAME"
echo "Current time: $(date)"
echo "End time: $(date -d @$end_time 2>/dev/null || date -r $end_time)"
echo "Branch: $(git branch --show-current)"
echo ""

# Get initial comment baseline
current_review_comments=$(gh api "repos/$REPO_OWNER/$REPO_NAME/pulls/$PR_NUMBER/comments" --jq '. | length' 2>/dev/null || echo "0")
current_pr_comments=$(gh pr view "$PR_NUMBER" --json comments --jq '.comments | length' 2>/dev/null || echo "0")
baseline_total=$((current_review_comments + current_pr_comments))

echo "📊 Initial baseline:"
echo "   Review comments: $current_review_comments"
echo "   PR comments: $current_pr_comments"
echo "   Total comments: $baseline_total"
echo ""

hour_count=0
check_count=0
comments_processed=0

while [ $(date +%s) -lt $end_time ]; do
  current_time=$(date +%s)
  remaining=$((end_time - current_time))
  hours_remaining=$((remaining / 3600))
  minutes_remaining=$(((remaining % 3600) / 60))

  # Increment check counter
  check_count=$((check_count + 1))

  # Show hour progress every 120 checks (1 hour)
  if [ $((check_count % 120)) -eq 0 ]; then
    hour_count=$((check_count / 120))
    echo "📊 Hour $hour_count/48: ${hours_remaining}h ${minutes_remaining}m remaining | Comments processed: $comments_processed"
  fi

  # Check current comment counts
  new_review_comments=$(gh api "repos/$REPO_OWNER/$REPO_NAME/pulls/$PR_NUMBER/comments" --jq '. | length' 2>/dev/null || echo "$current_review_comments")
  new_pr_comments=$(gh pr view "$PR_NUMBER" --json comments --jq '.comments | length' 2>/dev/null || echo "$current_pr_comments")
  new_total=$((new_review_comments + new_pr_comments))

  # Check if comment count increased
  if [ $new_total -gt $baseline_total ]; then
    added_comments=$((new_total - baseline_total))
    comments_processed=$((comments_processed + added_comments))
    echo ""
    echo "🚨 NEW COMMENT(S) DETECTED!"
    echo "   Previous total: $baseline_total"
    echo "   Current total: $new_total"
    echo "   New comments: $added_comments"
    echo "   Total processed: $comments_processed"
    echo "   Remaining time: ${hours_remaining}h ${minutes_remaining}m"
    echo ""
    echo "Exiting to allow Claude to process new comment(s)..."
    exit 0
  fi

  # No new comments, sleep for 30 seconds
  sleep 30
done

echo ""
echo "🎉 48-HOUR MONITORING COMPLETED!"
echo ""
echo "📊 Final Report:"
echo "⏰ Monitoring duration: 48 hours (COMPLETE)"
echo "💬 Total comments processed: $comments_processed"
echo "⏱️  Total hours monitored: $hour_count/48"
echo "✅ Monitoring mission accomplished!"
echo ""
exit 0