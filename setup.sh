#!/bin/bash

#Download codegniter
wget https://github.com/bcit-ci/CodeIgniter/archive/3.1.9.zip
unzip 3.1.9.zip
cp -a CodeIgniter-3.1.9/. app/
rm 3.1.9.zip
rm -R CodeIgniter-3.1.9

#Download mongodb library
wget https://github.com/intekhabrizvi/codeigniter-mongodb-library/archive/master.zip
unzip master.zip

cp -a codeigniter-mongodb-library-master/application/. app/application/
rm master.zip
rm -R codeigniter-mongodb-library-master
