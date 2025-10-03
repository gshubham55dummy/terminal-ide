#!/bin/bash

# PR Monitoring Script
PR_NUMBER="2"
REPO="gshubham55/terminal-ide"
start_time=$(date +%s)
end_time=$((start_time + 172800))  # 48 hours

echo "🚀 Starting 48-hour monitoring for PR #$PR_NUMBER"
echo "Current time: $(date)"
echo "End time: $(date -d @$end_time)"
echo "Branch: $(git branch --show-current)"
echo ""

# Get current comment baseline
current_review_comments=$(gh api "repos/$REPO/pulls/$PR_NUMBER/comments" --jq '. | length')
current_pr_comments=$(gh pr view "$PR_NUMBER" --repo "$REPO" --json comments --jq '.comments | length')
baseline_total=$((current_review_comments + current_pr_comments))

echo "📊 Current baseline:"
echo "   Review comments: $current_review_comments"
echo "   PR comments: $current_pr_comments"
echo "   Total comments: $baseline_total"
echo ""
echo "🎯 Monitoring for 48 hours"
echo ""

cycle_count=0
comments_processed=0

while [ $(date +%s) -lt $end_time ]; do
  current_time=$(date +%s)
  remaining=$((end_time - current_time))
  hours_remaining=$((remaining / 3600))
  minutes_remaining=$(((remaining % 3600) / 60))

  cycle_count=$((cycle_count + 1))

  # Show progress every 120 cycles (1 hour)
  if [ $((cycle_count % 120)) -eq 0 ]; then
    hour_mark=$((cycle_count / 120))
    echo "📊 Hour $hour_mark: ${hours_remaining}h ${minutes_remaining}m remaining | Comments processed: $comments_processed"
  else
    echo "Cycle $cycle_count... (${hours_remaining}h ${minutes_remaining}m remaining)"
  fi

  # Check current comment counts
  new_review_comments=$(gh api "repos/$REPO/pulls/$PR_NUMBER/comments" --jq '. | length')
  new_pr_comments=$(gh pr view "$PR_NUMBER" --repo "$REPO" --json comments --jq '.comments | length')
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
    echo "Exiting to allow processing of new comment(s)..."
    exit 0
  fi

  # No new comments, continue monitoring
  sleep 30
done

echo ""
echo "✅ Monitoring complete: 48/48 hours"
echo ""
echo "📊 Monitoring Report:"
echo "⏰ Duration: 48 hours (COMPLETE)"
echo "💬 Comments processed: $comments_processed"
echo "🔄 Total cycles: $cycle_count"
echo ""
exit 0