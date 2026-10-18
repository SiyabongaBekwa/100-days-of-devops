# Day 29 — Git Pull Request and Code Review

## Overview

This challenge focused on implementing a collaborative Git workflow using Gitea pull requests, code reviews, and controlled merging.

The task was completed as part of the KodeKloud **100 Days of DevOps** challenge in the Nautilus infrastructure environment.

## Objective

The objective was to merge Max's story into the `master` branch through a pull request rather than allowing changes to be pushed directly to the final branch.

The workflow required:

1. Inspecting the cloned repository and its commit history.
2. Verifying the author and commit message for Max's story.
3. Creating a pull request from `story/fox-and-grapes` into `master`.
4. Assigning Tom as the reviewer.
5. Reviewing and approving the pull request using Tom's account.
6. Merging the approved changes into `master`.

## Environment

| Component | Details |
| --- | --- |
| Platform | KodeKloud |
| Environment | Nautilus / Stratos Datacenter |
| Server | Storage server (`ststor01`) |
| Repository | `story-blog` |
| Git hosting | Gitea |
| Source branch | `story/fox-and-grapes` |
| Target branch | `master` |
| Workflow | Pull request and code review |

## Repository Inspection

The repository was located in Max's home directory on the Storage server:

```text
~/story-blog
```

The repository contained the following story files:

- `fox-and-grapes.txt`
- `frogs-and-ox.txt`
- `lion-and-mouse.txt`

The commit history was inspected to confirm that Max's story had been pushed to the source branch but was not yet included in `master`.

### Relevant Commit

```text
2ceb2a9 Added fox-and-grapes story
```

The author information was verified using `git show`:

```text
Author: Max <max@stratos.xfusioncorp.com>
Commit: Max <max@stratos.xfusioncorp.com>

Added fox-and-grapes story
```

The existing `master` branch was at commit `c53e019` before the pull request was merged.

## Pull Request Implementation

The pull request was created through the Gitea web interface.

| Setting | Value |
| --- | --- |
| Pull request title | `Added fox-and-grapes story` |
| Source branch | `story/fox-and-grapes` |
| Target branch | `master` |
| Reviewer | `tom` |

The source branch contained Max's story, and the pull request provided a controlled way to review the proposed changes before merging them into the main branch.

## Code Review and Merge

After creating the pull request, Tom was assigned as the reviewer through the Gitea interface.

The workflow was completed by logging into the portal as Tom, reviewing the pull request, and merging the approved changes.

The merge created a merge commit using Tom's Git identity.

The KodeKloud challenge confirmed successful completion.

## Key Concepts

### Pull Requests

A pull request proposes changes from one branch to another. It provides a place to review code, discuss changes, and obtain approval before integration.

### Code Review

Code review allows another developer to examine proposed changes before they become part of the main codebase.

### Branch Protection and Controlled Integration

Restricting direct pushes to the main branch and requiring reviews helps ensure that changes are reviewed and approved before integration.

Actual enforcement of these rules depends on the repository's branch protection and access-control settings.

### Git Commit History

Commands such as `git log` and `git show` help verify commit messages, authors, and the history of changes.

### Gitea

Gitea provides a web interface for repository hosting, pull requests, reviewer assignment, and collaboration.

## DevOps Relevance

Pull requests and code reviews are important in professional software development and DevOps workflows.

They help teams:

- Maintain code quality.
- Review changes before deployment.
- Reduce the risk of unapproved changes reaching production.
- Improve collaboration and accountability.
- Support controlled integration into release branches.
- Establish approval steps before CI/CD pipelines deploy changes.

## What I Learned

- How to inspect Git repository history.
- How to verify commit author information.
- How to create a pull request in Gitea.
- How to assign a reviewer.
- How to review and merge changes using a separate user account.
- Why code review is important before integrating changes into `master`.
- How collaborative Git workflows support controlled software delivery.

## Security Considerations

Credentials used during the lab are intentionally excluded from this repository.

Passwords, private keys, access tokens, and other secrets should never be committed to source control.

## Result

Max's `story/fox-and-grapes` branch was submitted for review through a pull request targeting `master`.

Tom was assigned as reviewer, reviewed the changes, and merged the approved pull request.

**Challenge Status: Completed — Day 29/100** ✅


**Result Reference:** `680781b3399a2462b6cc6680`