READ.md

###steps to use script to use Terraform and provision your EKS Cluster

1. Install patches
    sudo apt update -y

2. Ensure you have configured your AWS credentials already
    a. sudo apt install awscli
    b. aws configure
        - access_keys=$xxxxxxxxxxxxx
        - secret_keys=$xxxxxxxxxxxxx
        NB: notice when you do git clone inside the maintest.sh file, it pulls from my repo instead because i added * profile = "default" in the providers.tf file inside Terraform-EKS directory to use your credentials stored in the ~/.aws/credentials files when you configured your awscli

3. download and open the files with visual code or sublime text

4. In your home directory create:
    a. sudo vi maintest.sh      #copy content of maintest.sh and paste. Can also use vim editor
    b. sudo vi configtest.sh    #copy content of configtest.sh and paste.
    c. sudo vi master.sh        #copy content of master.sh and paste.

5. make all the the 3 scripts executable
    sudo chmod +x *.sh

6. run your master.sh script, seat back and watch the magic

7. To destroy your cluster
    - cd Terraform-EKS
    - terraform destroy --auto-approve 

7. ENJOY!!!
