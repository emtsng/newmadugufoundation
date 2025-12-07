#!/bin/bash

# Deployment script for Jenkins
# Customize this script based on your deployment target

set -e  # Exit on error

PROJECT_NAME="newmadugufoundation"
BUILD_DIR="${1:-build}"
DEPLOY_TARGET="${2:-production}"

echo "=========================================="
echo "Deploying ${PROJECT_NAME}"
echo "Build Directory: ${BUILD_DIR}"
echo "Deploy Target: ${DEPLOY_TARGET}"
echo "=========================================="

# Validate build directory exists
if [ ! -d "${BUILD_DIR}" ]; then
    echo "Error: Build directory ${BUILD_DIR} does not exist"
    exit 1
fi

# Example deployment methods - uncomment and customize as needed

# Method 1: Deploy via RSYNC to remote server
# RSYNC_TARGET="user@your-server.com:/var/www/html/${PROJECT_NAME}/"
# echo "Deploying via RSYNC to ${RSYNC_TARGET}..."
# rsync -avz --delete "${BUILD_DIR}/" "${RSYNC_TARGET}"

# Method 2: Deploy to AWS S3
# S3_BUCKET="your-bucket-name"
# echo "Deploying to S3 bucket: ${S3_BUCKET}..."
# aws s3 sync "${BUILD_DIR}/" "s3://${S3_BUCKET}/" --delete

# Method 3: Deploy to local web server
# LOCAL_WEB_ROOT="/var/www/html/${PROJECT_NAME}/"
# echo "Deploying to local web server: ${LOCAL_WEB_ROOT}..."
# sudo cp -r "${BUILD_DIR}"/* "${LOCAL_WEB_ROOT}/"

# Method 4: Create deployment package
# PACKAGE_NAME="${PROJECT_NAME}-$(date +%Y%m%d-%H%M%S).tar.gz"
# echo "Creating deployment package: ${PACKAGE_NAME}..."
# tar -czf "${PACKAGE_NAME}" -C "${BUILD_DIR}" .
# echo "Package created: ${PACKAGE_NAME}"

echo "Deployment completed successfully!"

