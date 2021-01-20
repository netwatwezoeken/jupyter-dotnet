def withPod(body) {
  podTemplate(cloud: 'chainmapper', containers: [
      containerTemplate(name: 'kaniko', image: 'gcr.io/kaniko-project/executor:debug', command: '/busybox/cat', ttyEnabled: true)
    ],
    volumes: [
      secretVolume(secretName: 'netwatwezoeken', mountPath: '/cred')
    ]
 ) { body() }
}

withPod {
    node(POD_LABEL) {
        def tag = "${env.BRANCH_NAME.replaceAll('/', '-')}-${env.BUILD_NUMBER}"
        def registry = "packages.netwatwezoeken.nl/nwwz"
        def appname = "jupyter-dotnet"
        def service = "${registry}/${appname}:${tag}"
        checkout scm		
        container('kaniko') {
            stage('Build image') {
                sh("cp /cred/.dockerconfigjson /kaniko/.docker/config.json")
                sh("executor --context=`pwd` --dockerfile=`pwd`/Dockerfile --destination=${service} --single-snapshot")
            }    
        }        
    }
}