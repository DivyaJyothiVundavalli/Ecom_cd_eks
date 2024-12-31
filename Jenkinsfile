#!/usr/bin/env groovy
pipeline {
    agent any
    environment {
        // AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
        // AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        //
        AWS_ACCESS_KEY_ID = 'AKIAZI2LDTA2BAV2EHTI'
        AWS_SECRET_ACCESS_KEY = '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'
        AWS_DEFAULT_REGION = "ap-south-1"
    }
    stages {
        stage("Initializing Terraform'") {
            steps {
                script {
                    dir('terraform') {
                        sh "terraform init"
                    }
                }
            }
        }
        stage('Formating terraform code'){
            steps{
                script{
                    dir('terraform'){
                         sh 'terraform fmt'
                    }
                }
            }
        }
        stage('Validating Terraform'){
            steps{
                script{
                    dir('terraform'){
                         sh 'terraform validate'
                    }
                }
            }
        }
        stage('Previewing the infrastructure'){
            steps{
                script{
                    dir('terraform'){
                         sh 'terraform plan'
                    }
                    input(message: "Are you sure to proceed?", ok: "proceed")
                }
            }
        }
        stage('Creating/Destroying an EKS cluster'){
            steps{
                script{
                    dir('terraform'){
                         sh 'terraform $action --auto-approve'
                    }
                }
            }
        }
        
        stage("Deploy to EKS") {
            steps {
                script {
                    dir('kubernetes') {
                        sh "aws eks update-kubeconfig --name my-eks-cluster"
                        sh "kubectl apply -f nginx-deployment.yaml"
                        sh "kubectl apply -f nginx-service.yaml"
                      //  sh "kubectl apply -f deployment.yml"
                      // sh "kubectl apply -f service.yml"
                    }
                }
            }
        }
    }
}
