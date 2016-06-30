Creating a local branch of the GitHub repository:

* Go to the HomeBankCode GitHub Repository:
  * https://github.com/HomeBankCode/lena-its-tools
* Launch Terminal
  * in the command line
    * navigate to the directory where you would like to create your local branch
      * e.g., cd ~/Desktop
    * clone the online directory
      * e.g., git clone https://github.com/HomeBankCode/lena-its-tools.git
  * You should see now this folder in your finder with all included files, identical to the online repository.


To add a new file or changes to an existing file:

* Launch Terminal
  * in the command line
    * navigate to the directory 
      * e.g., cd ~/Desktop/lena-its-tools
    * check the status of your local branch (i.e., are there differences between the local and online branches)
      * e.g. git status
      * This will allow you to see which files have been modified or added
  * Add the modified or new files 
    * to add a single file:
      * git add segments.pl
    * to add all files:
      * git add .
        * the . signifies all files in directory
  * commit changes
    * git commit -m "Your Message Here"
      * Create a message that lets you know what you are committing
        * e.g. git commit -m "Modified instructions for segments.pl"
  * push from local repository to your online branch
    * git push
      * enter your username
      * enter your password
    
    
To update your local branch with changes from online branch:

* Launch Terminal
  * in the command line
    * Navigate to the directory
      * e.g., cd ~/Desktop/lena-its-tools
    * check the status of your local branch (i.e., are there differences between the local and online branches)
      * e.g. git status
      * This will allow you to see which files have been modified or added
    * pull from online branch to your local repository
      * e.g., git pull


To merge changes in your online branch to the master branch:
* Go to your online branch of the lena-its-tools repository
* If your branch is ahead or behind the master branch in commits (i.e., there have been changes to either the master or your branch and you want to merge them together),
  * Click on "New pull request"
    * Click on "Create pull request"
      * Create a brief message explaining what you are trying to merge
        * e.g., "Adding modified segments.pl file"
        * Click on "Create pull request"
  * This will send a message to the owner of the master branch, who will have to approve any changes and merge the two branches.           
    
      
    
    
    
            	      