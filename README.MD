# Technical Test Niagahoster Interview - Khisby Al Ghofari  
  
## Task 1
source code on forntend folder or you can acces http://khisoft.online for live preview  
  
## Task 2

### How to run Docker
Make sure you have change variable in file src/bb-config.php with your configuration,   especially url variable.  
if you runing on local change url variable in file src/bb-config.php to 'http://localhost:8004/'.   
if you do not change docker-compose.yml file don't touch other variable.  
  
run using command   
```docker-compose up -d --no-deps --build```
  
  
by default Boxbilling using port 8004 and frontend landingpage app using port 80.  
  
you can access phpmyadmin on port 8183 with credentials :   
host : db  
username : khisoft  
password : khisoft  
  
### Credentials BB-Admin  
url admin : http://khisoft.online:8004/bb-admin  
email : khisby@gmail.com  
password : khisby  