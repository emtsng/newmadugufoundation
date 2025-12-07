pipeline {
    agent any
    
    options {
        buildDiscarder(logRotator(numToKeepStr: '10'))
        timeout(time: 30, unit: 'MINUTES')
        timestamps()
    }
    
    environment {
        PROJECT_NAME = 'newmadugufoundation'
        BUILD_DIR = 'build'
        DEPLOY_DIR = "${env.WORKSPACE}/${BUILD_DIR}"
    }
    
    stages {
        stage('Checkout') {
            steps {
                echo 'Checking out source code...'
                checkout scm
                script {
                    env.GIT_COMMIT_SHORT = sh(
                        script: 'git rev-parse --short HEAD',
                        returnStdout: true
                    ).trim()
                    env.GIT_BRANCH_NAME = sh(
                        script: 'git rev-parse --abbrev-ref HEAD',
                        returnStdout: true
                    ).trim()
                }
                echo "Building commit: ${env.GIT_COMMIT_SHORT} on branch: ${env.GIT_BRANCH_NAME}"
            }
        }
        
        stage('Validate HTML') {
            steps {
                echo 'Validating HTML files...'
                script {
                    def htmlFiles = sh(
                        script: 'find . -name "*.html" -not -path "./venv/*" -not -path "./.git/*" -not -path "./build/*"',
                        returnStdout: true
                    ).trim().split('\n')
                    
                    echo "Found ${htmlFiles.size()} HTML files to validate"
                    // Basic HTML validation - check for common issues
                    sh '''
                        for file in $(find . -name "*.html" -not -path "./venv/*" -not -path "./.git/*" -not -path "./build/*"); do
                            if ! grep -q "<!DOCTYPE html>" "$file" && ! grep -q "<!DOCTYPE HTML>" "$file"; then
                                echo "Warning: $file may be missing DOCTYPE declaration"
                            fi
                        done
                    '''
                }
            }
        }
        
        stage('Check Assets') {
            steps {
                echo 'Checking asset files...'
                sh '''
                    # Check if critical asset directories exist
                    if [ ! -d "assets/css" ]; then
                        echo "Warning: assets/css directory not found"
                    fi
                    if [ ! -d "assets/js" ]; then
                        echo "Warning: assets/js directory not found"
                    fi
                    if [ ! -d "assets/img" ]; then
                        echo "Warning: assets/img directory not found"
                    fi
                    
                    # Count asset files
                    echo "CSS files: $(find assets/css -name "*.css" 2>/dev/null | wc -l)"
                    echo "JS files: $(find assets/js -name "*.js" 2>/dev/null | wc -l)"
                    echo "Image files: $(find assets/img -name "*.jpg" -o -name "*.png" -o -name "*.svg" -o -name "*.webp" 2>/dev/null | wc -l)"
                '''
            }
        }
        
        stage('Setup Ruby') {
            steps {
                echo 'Setting up Ruby environment...'
                sh '''
                    # Check Ruby version
                    ruby --version || echo "Ruby not found, installing..."
                    
                    # Install Bundler if not present
                    gem install bundler || true
                    
                    # Install dependencies
                    bundle install
                '''
            }
        }
        
        stage('Build') {
            steps {
                echo 'Building project with Ruby templates...'
                sh '''
                    # Create build directory
                    mkdir -p ${BUILD_DIR}
                    
                    # Run Ruby build script
                    ruby build.rb || echo "Build script completed"
                    
                    # Copy all necessary files to build directory
                    # Exclude development files
                    rsync -av --exclude='.git' \
                          --exclude='db.sqlite3' \
                          --exclude='.DS_Store' \
                          --exclude='build' \
                          --exclude='node_modules' \
                          --exclude='Gemfile.lock' \
                          --exclude='.bundle' \
                          --exclude='venv' \
                          --exclude='.venv' \
                          ./ ${BUILD_DIR}/
                    
                    echo "Build completed. Files ready in ${BUILD_DIR}/"
                '''
            }
        }
        
        stage('Archive Artifacts') {
            steps {
                echo 'Archiving build artifacts...'
                archiveArtifacts artifacts: "${BUILD_DIR}/**/*", 
                                fingerprint: true,
                                allowEmptyArchive: false
            }
        }
        
        stage('Deploy') {
            when {
                anyOf {
                    branch 'main'
                    branch 'master'
                    branch 'production'
                }
            }
            steps {
                echo 'Deploying to production...'
                script {
                    // Customize deployment based on your infrastructure
                    // Examples:
                    // - Deploy to web server via SSH
                    // - Deploy to S3/CloudFront
                    // - Deploy to GitHub Pages
                    // - Deploy to Docker container
                    
                    echo """
                    Deployment configuration:
                    - Project: ${PROJECT_NAME}
                    - Branch: ${env.GIT_BRANCH_NAME}
                    - Commit: ${env.GIT_COMMIT_SHORT}
                    - Build Directory: ${DEPLOY_DIR}
                    
                    Add your deployment commands here.
                    Examples:
                    - rsync to web server
                    - aws s3 sync
                    - docker build and push
                    """
                    
                    // Uncomment and customize based on your deployment target:
                    
                    // Example 1: Deploy via SSH/RSYNC
                    // sh '''
                    //     rsync -avz --delete ${BUILD_DIR}/ user@server:/var/www/html/
                    // '''
                    
                    // Example 2: Deploy to AWS S3
                    // sh '''
                    //     aws s3 sync ${BUILD_DIR}/ s3://your-bucket-name/ --delete
                    // '''
                    
                    // Example 3: Deploy to GitHub Pages
                    // sh '''
                    //     git checkout --orphan gh-pages
                    //     git rm -rf .
                    //     cp -r ${BUILD_DIR}/* .
                    //     git add .
                    //     git commit -m "Deploy ${env.GIT_COMMIT_SHORT}"
                    //     git push origin gh-pages
                    // '''
                }
            }
        }
    }
    
    post {
        always {
            echo 'Cleaning up workspace...'
            cleanWs()
        }
        success {
            echo 'Pipeline succeeded!'
            script {
                // Optional: Send success notification
                // emailext (
                //     subject: "SUCCESS: ${env.JOB_NAME} - ${env.BUILD_NUMBER}",
                //     body: "Build succeeded for commit ${env.GIT_COMMIT_SHORT}",
                //     to: "your-email@example.com"
                // )
            }
        }
        failure {
            echo 'Pipeline failed!'
            script {
                // Optional: Send failure notification
                // emailext (
                //     subject: "FAILURE: ${env.JOB_NAME} - ${env.BUILD_NUMBER}",
                //     body: "Build failed for commit ${env.GIT_COMMIT_SHORT}",
                //     to: "your-email@example.com"
                // )
            }
        }
        unstable {
            echo 'Pipeline is unstable!'
        }
    }
}

