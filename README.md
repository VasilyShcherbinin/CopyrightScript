# CopyrightScript
This tool was created to automate the process of adding copyright to the numerous files in the repositories. 

## To run this script
The script should operate without problems on Linux and MacOS. 
Run the script from outside of the folder on which you want to execute the script!

The script takes the following parameters:

./copyrightScript.sh $PATH-TO-FILES linc|conf|auto |all |r

The linc option allows to make all files contain a licensed copyright, regardless of the file extension.

The conf option allows to make all files contain a confidential copyright, regardless of the file extension.

The auto option is used when we want files with different extensions to have different copyrights. The current defaults are set to:

1. Licensed:        Makefile / YAML / Bash 
2. Confidential:    Go

The all option specifies whether we want to go inside the subfolders of the folder which we have given in our path. Removing the all option will mean that we only want to operate on the files that are located in the folder specified by the path.

Finally, the r option specifies whether we want to remove the copyright and overwrite with a new one. If we do not specify the r option, once we determine that a file already contains a copyright we simply skip it.
