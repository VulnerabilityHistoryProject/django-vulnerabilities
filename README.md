# django-vulnerabilities
Historical vulnerability data for the Django web application framework

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
