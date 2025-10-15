---
argument-hint: [pr-url] (optional)
description: Monitor and resolve PR comments automatically
---

# 🔄 PR Comment Monitor

Monitor and resolve PR comments automatically.

**Your Mission:**
1. **Identify PR**: Determine the pull request to monitor. Use $1 if provided, otherwise infer from conversation history above. If no PR can be identified, inform me.

2. **Continuous Monitoring**: Monitor for exactly 48 hours (checking every 30 seconds):
   - Initialize check counter
   - For each check iteration:

     **Step A: Read and Process Comments**
     - Use 'gh' commands to fetch PR comments and review comments
     - Parse and identify unresolved comments
     - For each unresolved comment:
       - Analyze the request and read relevant code files
       - Implement requested changes
       - Run tests if possible
       - Reply to comment when resolved

     **Step B: Sleep and Wait**
     - Sleep for exactly 30 seconds using `sleep 30` in foreground

     **Step C: Update Counter and Display Progress**
     - Increase counter by 1
     - Print current progress every hour (e.g., "Hour 15/48")
     - Continue to next iteration

   - **IMPORTANT**: Only exit after completing all 48 hours of monitoring
   - Track and display final progress: "Monitoring complete: 48/48 hours" before exit

3. **Smart Resolution**:
   - Read relevant code files for context
   - **Think critically**: Analyze each comment deeply before acting. Push back if comments don't make sense, contradict best practices, or would introduce bugs
   - Make targeted, thoughtful changes only when comments are valid
   - Run available tests before committing
   - Write clear commit messages
   - Handle multiple comments efficiently

## Sample GitHub Comment Fetch Commands

```bash
# Get all PR comments (general comments)
gh pr view [PR_NUMBER] --json comments

# Get review comments (line-specific)
gh api repos/OWNER/REPO/pulls/[PR_NUMBER]/comments

# Get both comments and reviews
gh pr view [PR_NUMBER] --json comments,reviews

# Filter unresolved comments by date
gh api repos/OWNER/REPO/pulls/[PR_NUMBER]/comments | jq '.[] | select(.created_at > "2025-01-01T00:00:00Z")'
```

Please start now by identifying the PR and checking for existing comments that need resolution. Do not write any code, instead use monitor_script.sh to monitor, run this in FOREGROUND and with 48h timelimit always.

Please first update monitor_script.sh to the right version and then run it.