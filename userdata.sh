#! /bin/bash
sudo yum update -y
sudo yum install -y httpd
sudo systemctl enable httpd
sudo service httpd start
echo "hi terraform NV" | sudo tee /var/www/html/index.html