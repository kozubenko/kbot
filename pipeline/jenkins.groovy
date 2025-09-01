pipeline {
  agent any
  parameters {
      choice(
          name: 'OS',
          choices: "linux\ndarwin\nwindows",
          description: 'Target operating system'
      )
      choice(
          name: 'ARCH',
          choices: "amd64\narm64",
          description: 'Target architecture'
      )
  }
  stages {
      stage("Build") {
          steps {
              echo "Hi from here"
              echo "Building for OS=${params.OS}, ARCH=${params.ARCH}"

              script {
                  if (params.OS == 'windows') {
                      bat "make build TARGETOS=${params.OS} TARGETARCH=${params.ARCH}"
                  } else {
                      sh "make build TARGETOS=${params.OS} TARGETARCH=${params.ARCH}"
                  }
              }
          }
      }
  }
}
