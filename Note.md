# Some Important Commands
## 1. Use to start a stopped node
docker-machine start node_name;                 
## 2. Use to stop a running node
 docker-machine stop node_name;                  
## 3. Use to check docker nodes
docker-machine ls;                                         
## 4. Use to check ip of a node
 docker-machine ip node_name;                      
## 5. Use to check node list
 docker node ls;                                                
## 6. Use to check running services;
 docker ps;                                                        
## 7. Use to scale a application
 docker service scale web=6;                           
## 8. Use to see the log of a service
 docker service logs -f service_name;              
## 9. Use to check node information
 docker node inspect self;                                
## 10. Use to check node information
 docker node inspect node_name                    
## 11. Use to check running services in a node
 docker node ps node_name;                           
## 12. Use to check node information 
 docker node inspect — pretty node_name;    
## 13. Use to check container list
 docker container ls                                         
## 14.  Use to remove a container
 docker container rm container_name;            
## 15.  Use to check image list
 docker image ls;                                            
## 16. Use to remove image
 docker image rm image_name;                     
## 17. Use to build images 
 docker-compose build                                   
## 18. Use to deploy images
 docker-compose up                                        
## 19. Use to deploy images after build
 docker-compose up --build                           
## 20. Use to shutdown container
 docker-compose down                                  
## 21. Use to access mysql container
 docker exec -it docker-mysql bash;              
## 22.  Use to check services under book_manager stack
 docker stack services  book_manager;         
## 23. Use to remove a service from stack
 docker stack rm service_name                     
## 24.  Use to check stack list
 docker stack ls                                              
