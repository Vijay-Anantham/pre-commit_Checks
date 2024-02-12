pipeline {
  agent {
    kubernetes {
      cloud 'anthos-ci'
      defaultContainer 'kaniko'
      yaml """
        apiVersion: v1
        kind: Pod
        metadata:
          labels:
            name: jnlp
        spec:
          containers:
            - name: kaniko
              image: gcr.io/kaniko-project/executor:v1.6.0-debug
              imagePullPolicy: Always
              tty: true
              command:
                - /busybox/sleep
                - infinity
              volumeMounts:
                - name: jenkins-docker-cfg
                  mountPath: /kaniko/.docker
          volumes:
            - name: jenkins-docker-cfg
              projected:
                sources:
                  - secret:
                      name: regcred
                      items:
                        - key: .dockerconfigjson
                          path: config.json
"""
    }
  }
  stages {
    stage('Build with Kaniko') {
      steps {
        git 'https://github.com/jenkinsci/docker-inbound-agent.git'
        sh '/kaniko/executor -f `pwd`/Dockerfile -c `pwd` --insecure --skip-tls-verify --cache=true --destination=mydockerregistry:5000/myorg/myimage'
      }
    }
  }
}