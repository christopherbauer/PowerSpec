### Guide for contributions

	Contributions should be straightforward, simple commands that take the guesswork out of determining the status of a particular Windows configuration or feature. It can be as simple as checking if an environment variable exists or as complex as checking to see if a particular windows feature is installed, or if a file contains some text.
	
	The only "guide" I can give is that the feature should be something that is necessary to the health of a server deploy or environmental configuration. The script should be able to be run independent of any other spec and should be self-contained. 
	
	If you need to verify that something exists prior to running the actual spec command, use an if statement that returns immediately if the feature does not exist. Provide an explanation of the error in the info object so that the person using it doesn't have to dig too far before determining why the command failed. The early-return error should always fail the build, so just return $false in these situations.
	
	Always check the commands on a machine that has the feature before submitting them. I'll try to check commands prior to merging pull requests.