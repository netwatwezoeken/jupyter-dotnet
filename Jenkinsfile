def withPod(body) {
  podTemplate(cloud: 'chainmapper', label: 'build', containers: [
      containerTemplate(name: 'kaniko', image: 'gcr.io/kaniko-project/executor:debug', command: '/busybox/cat', ttyEnabled: true),
      containerTemplate(name: 'kubectl', image: 'joshendriks/kubectl:debug-v1.18', command: 'cat', ttyEnabled: true)
    ],
    volumes: [
	  secretVolume(secretName: 'netwatwezoeken', mountPath: '/cred')
    ]
 ) { body() }
}

withPod {
	node('build') {
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