# Release Instructions

## Release Checklist

Assuming that current release number is of the form `3.N.a-dev` in the `dev` branch.

* [ ] Resolve as many [merge requests](-/merge_requests) and [issues](-/issues) as feasible

* [ ] Merge 'master' back into 'dev' branch, just in case any changes were made to 'master'

* [ ] Comparing to the prior [release](-/releases), update the root [README.md](-/README.md) with release notes, if they haven't already been added
   - [ ] Grab the tag of the latest release, `v3.(N-1)`
   - [ ] Using "Compare Revisions" under "Code", compare Source:`dev` to Target:`v3.(N-1)`

* [ ] Freeze the `dev` branch, update the version number, release date, and help database (see checklist below)
  
* [ ] Merge the branch into the master

* [ ] Create a release using "New Tag" option
   - [ ] Tag with the new version number (v3.N) on MASTER branch.
   - [ ] In Message: Tensor Toolbox Version 3.X (R202YX) DD-MMM-YYYY
   - [ ] Put changes into Release Notes (copy from README.md)
   - [ ] Create a release
   
* [ ] *IMPORTANT* Merge 'master' back into 'dev' branch!

* [ ] Before any new into the `dev` branch, change release number to `3.(N+1).a-dev` in all the places listed below and remove dates


## Files that need to be updated with the version and/or release date

* [ ] `doc/html/index.html`
   - [ ] First H1 header
   - [ ] Downloading version
   - [ ] Under "How to Cite" (**includes exact release date**)
* [ ] `README.md` 
   - [ ] First two lines (**includes exact release date**)
* [ ] `doc/html/helptoc.xml`
   - Change toc version
* [ ] `maintenance/create_topcontents.m`
* [ ] `Contents.m` - autogenerated by `maintenance/create_topcontents.m`
   - [ ] Verify that 'ver' gets the date, which must be formatted as DD-MMM-YYYY (see "Create a Contents.m File" in MATLAB help for more)
   - [ ] Verify that 'ver' gets the Release, which should be formmated as RYYYYz where YYYY is the year and z is the release letter, starting with 'a'

* [ ] Run `maintenance/clean_html_pngs` to remove any unneeded png image files from old releases.

* [ ] Rebuild help index: cd doc/html; builddocsearchdb(pwd)
