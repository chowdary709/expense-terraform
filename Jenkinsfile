pipeline {
    agent { label "workstation" }

    options {
        ansiColor('xterm')
    }

    parameters{
        choice(name: 'ENV', choices: ['dev', 'peod'], description: ' Choose environment')
        choice(name: 'ACTION', choices: ['apply', 'destroy'], description: ' Choose action')
    }

    stages {
        stage('Terraform plan') {
            steps {
                sh 'terraform init -backend-config=env-${ENV}/state.tfvars'
            }
        }

        stage('Terraform Action') {
            input {
                message "should be continue?"
            }
            steps {
                sh 'terraform ${ACTION} -var-file=env-${ENV}/inputs.tfvars -auto-approve'
            }
        }
    }
}
