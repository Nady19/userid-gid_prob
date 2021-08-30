# guide to create a docker(bocker) part-1(bocker run)

->>go to kloudlab, sign in

->>go to `cloud server`

->>select OS as `ubuntu 20.04` and `start server`

->>on the right download keypair where you want it 

->>go to terminal

->>`sudo chmod 400 shamefulGarlic3urRWZ9oD.pem`

->>`ssh -i shamefulGarlic3urRWZ9oD.pem ubuntu@3.109.201.208` ,`yes`

->>`sudo apt update`

->>trying out `shuf` command with `shuf --help` as the bocker run has something like this in it's codes

learn and read about uuid and gid

->>`sudo apt install docker`

->>`sudo apt install docker.io`

->>`sudo docker run -d ubuntu:latest sleep infinity`

->>ubuntu is running , to check

   `sudo docker ps`

->>`ps aux | grep sleep` to see the processes that are sleeping

->>`ps aux` to see all the processes

->>to see the uid of root `sudo su` and then inside root `echo $UID`

->> again `sudo docker ps`

->> `sudo docker exec -it bff sh`

->> `vi Dockerfile`

->> to create a group

FROM ubuntu:latest

RUN useradd -r -u 1001 -g appuser appuser

USER appuser

ENTRYPOINT [“sleep”, “infinity”]


:wq

->>`sudo docker build -t h .`

->>getting error `appuser group doesnt exist`

->> need to create group named 'appuser' first

->>to check `vi /etc/group` go to the bottom of the list -> no group as 'appuser' -> :qa to exit

->>man this is becoming pain ,already 3+hrs and still havent figured out how to create user.....or have i ? adding new group.............

->>`sudo groupadd appuser`

-->nice. appuser's id is 1001

->> trying to build the dockerfile again........

->> Nope, doesnt work........sigh........heavy sigh.....

->> trying a lot of ways randomly ..................

->>removing the appuser 

`sudo groupdel appuser`

just because i learned how to delete a group, no reasons except this...

->> now going to the real mission again.....

->>`vi Dockerfile` we will be just making change here from now on, lets try this method.....

->>lets add `RUN groupadd -g 2000 appuser` in the dockerfile before this line `RUN useradd -r -u 2001 -g appuser appuser` 

just to check i have also changed the uid from 1001 to 2001

->>yessssssssssssssssssssssssssssssssssssssssssssssss

yessssssssssssssssssssssssssssssssssssssss

yesssssssssssssssssssssssssssssssssss

it works........but the common question stands strong **WHY????**

so lets test again....

First possible reason could be with the ids

so lets `vi Dockerfile` again

and change the group id/gid to 1001

and user id/uid to 1001

->>**still works**

then the possible reason could be that for the first time i was creating a group and then building the dockerfile separately from the terminal...

to be sure if it is the case i once again check `vi /etc/group/` and go to bottom of the list....

->>to my utmost surprise there is still no group as appuser !!!!!!!

that means creating a group here in the terminal never meant anything neither did adding a user here in the terminal.

->>wondering why is that...........because of the container...we are building a dockerfile so the group ,the user everything should be inside there, not in the terminal of the server we created

