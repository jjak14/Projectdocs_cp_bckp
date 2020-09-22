# Copy and Backup

**New scripting project.**
I wrote some batch scripting to automate a repetive task in my daily job.

I handle multiple projects all througout the year.\
Each project generate sensitive data that needs to be copied and backup in different location on a remote server.\
Manual copy and watching over the job can become a very annoying task.\
Thus, this series of script to automate this process.

**The scripts are Batch scripts.**
I call all other scripts from the main script where selections are handled.\
Obviously bacth is the quickest option I can implement giving internal IT restrictions I will face on my work computer.

I would like to accomplish the same in the near future in my python learning journey.\
*I actually started this project on python*


Few changes I'm planning to handle in the near future.

1. Handle the run number 
the run number could be 2 in that case all T and R in paths should be T2, R2

2. Add a 2 options to the main script and create corresponding scripts
first option will handle all pre-survey copies (copy T1 and all resources documents)
second option will handle all post survey copies:
    - MRK, DHA and statistics folder to Houfile5
    - RAW data to Houfile1

**Note:** 
    1. I checked how to create hashfile (SHA1) in batch file and I need to install a tool to successfully handle it.
    2. I use robocopy with the flag "/z" to handle error and retry copy until it succeed. obviously there should better way
    to get this done; I will research around better options.