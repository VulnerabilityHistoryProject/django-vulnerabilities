# django-vulnerabilities
Historical vulnerability data for the Django web application framework

# The Build ![YML & Editorial Checkers](https://github.com/VulnerabilityHistoryProject/django-vulnerabilities/workflows/YML%20&%20Editorial%20Checkers/badge.svg)

Every push and pull request is run against our integrity checkers on GitHub actions. Click on the above tag to see the status of the build.

# For SWEN 331 students

Please see your course website for instructions. This README is more for people managing this data.

# Testing project locally

1. You'll need Ruby 2.4+
2. Run `gem install bundler` (if you don't already have bundler)
3. `cd` to the root of this repo, run `bundle install`
4. Run `bundle exec rake`

If the output has no *failures*, then it checks out!


# Cloning the source repo

To clone the repo into this folder, use this command:

```
git clone git@github.com:django/django.git tmp/src
```

# Populating New CVEs

We get CVEs from their security list in `tmp/src/docs/releases/security.txt`.

If you run `rake new_cves`, then our script will go through that text file and look for CVEs mentioned. If a YML file exists for that already, it will skip it. If a YML file does not exist, it'll copy the `skeletons/cve.yml` to `cves` and populate it with the CVE information.

All other information after that is collected manually.


# Merge Student CVE assignment

Here's how you merge in student data once the assignment is finished.

1. Make sure the current `dev` branch is updated and works with the build
2. Switch `vulnerability-history` locally to pull from `dev` instead of `master`.
3. Squash and merge the student pull req into `dev`
4. Run `rails data:django` locally. When it says "Loading data version " and then a git hash, make sure that matches up with the latest merge you just made (so you know you are pulling the latest chromium-vulnerabilities data). Alternatively, you can do `rails data:clear data:django:load_only` which goes quicker.
5. If all is well, then do any spot-checks of their data to make sure everything got tagged just fine.
6. If all is not well:
  * You may need to merge their changes with any of your changes. This might be on GitHub itself, or locally.
  * You may need to correct their YML structure to make it compatible with the loader. Make the change locally and push back to `dev` to fix it and re-run.
  * If things fail on an exception, you can always put in this snippet somewhere to figure out what file failed and use byebug to figure out the problem:
  ```
  begin
    # code where things when wrong
  rescue
    byebug
  end
  ```
  * You can always do `rails data:django:nogit` to reload things without hitting GitHub - helpful for quicker debugging.

# After Merging in New CVEs

After we merge in a bunch of PRs, here's a checklist of what needs updating, and in what order:

  * Add mentioned commits (default options should be good enough)
  * Generate weeklies (skip existing)
