def COMPONENTS = ["cart", "catalogue", "payment", "shipping", "user", "dispatch", "frontend"]

def SIZE =  COMPONENTS.size -1

for(i in 0..SIZE) {
  def j = COMPONENTS[i]
  pipelineJob("CI-Pipelines/${j}") {
    configure { flowdefinition ->
      flowdefinition << delegate.'definition'(class: 'org.jenkinsci.plugins.workflow.cps.CpsScmFlowDefinition', plugin: 'workflow-cps') {
        'scm'(class: 'hudson.plugins.git.GitSCM', plugin: 'git') {
          'userRemoteConfigs' {
            'hudson.plugins.git.UserRemoteConfig' {
              'url'("https://github.com/example/${j}.git")
            }
          }
          'branches' {
            'hudson.plugins.git.BranchSpec' {
              'name'('*/tags/*')
            }
            'hudson.plugins.git.BranchSpec' {
              'name'('*/main')
            }
          }
        }
        'scriptPath'('Jenkinsfile')
        'lightweight'(true)
      }
    }
  }
}

multibranchPipelineJob('example') {

  branchSources {
    git {
      id('123456789') // IMPORTANT: use a constant and unique identifier
      remote('https://github.com/example/example.git')
      includes('**')
    }
  }
  orphanedItemStrategy {
    discardOldItems {
      numToKeep(0)
    }
  }
}




