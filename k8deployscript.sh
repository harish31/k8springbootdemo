#!/bin/bash
IMAGE_NAME=$1
PROJECT_NAME=$2

echo "[Task1] Building an application Package"
/usr/local/src/apache-maven/bin/mvn clean package clean package

echo "[Task2] Building an image"
sudo docker build -t $IMAGE_NAME .

echo "[Task3] Backing up image into tar"
sudo docker save -o $IMAGE_NAME.tar $IMAGE_NAME

echo "[Task4] Changing ownership of image"
sudo chown vagrant:vagrant $IMAGE_NAME.tar

echo "[Task5] Copying an image to worker node 1"
scp $IMAGE_NAME.tar kworker1:/tmp

echo "[Task6] Loading tar file into docker image on worker node 1"
echo "sudo docker load -i /tmp/$IMAGE_NAME.tar" | ssh kworker1

echo "[Task7] Removing tar file from worker node 1"
echo "sudo rm -rf /tmp/$IMAGE_NAME.tar" | ssh kworker1

echo "[Task8] Copying an image to worker node 2"
scp $IMAGE_NAME.tar kworker2:/tmp

echo "[Task9] Loading tar file into docker image on worker node 2"
echo "sudo docker load -i /tmp/$IMAGE_NAME.tar" | ssh kworker2

echo "[Task10] Removing tar file from worker node 2"
echo "sudo rm -rf /tmp/$IMAGE_NAME.tar" | ssh kworker2

echo "[Task11] Creating deployment of project"
kubectl run $PROJECT_NAME --image-pull-policy='Never' --image $IMAGE_NAME

echo "[Task12] Exposing port"
kubectl expose deployment $PROJECT_NAME --type NodePort --port 8080
