# Web Dev Bookmarks

The goal of this project is to build a site/app that hosts a socially-curated 
collection of links to web development articles, videos, and other resources.

## Deployment on OpenShift

1. Check out a local copy of this project from GitHub:
  
        git clone https://github.com/whastings/web_dev_bookmarks.git bookmarks
        cd bookmarks
  
2. Create a new hosted Linux environment on OpenShift:
  
        rhc app create bookmarks ruby-1.9 postgresql-9.2 --no-git

3. Add your remote OpenShift repository to your list of Git remotes:

        git add remote openshift ssh://53249c18e0b8cde4340000ae@bookmarks-example.rhcloud.com/~/git/bookmarks.git/

4. Force push over the top of OpenShift's default "Hello World" sample ruby application source:

        git push -f openshift master
