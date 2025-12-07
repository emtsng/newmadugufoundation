@echo off
REM Deployment script for Jenkins (Windows)
REM Customize this script based on your deployment target

setlocal enabledelayedexpansion

set PROJECT_NAME=newmadugufoundation
set BUILD_DIR=%~1
if "%BUILD_DIR%"=="" set BUILD_DIR=build
set DEPLOY_TARGET=%~2
if "%DEPLOY_TARGET%"=="" set DEPLOY_TARGET=production

echo ==========================================
echo Deploying %PROJECT_NAME%
echo Build Directory: %BUILD_DIR%
echo Deploy Target: %DEPLOY_TARGET%
echo ==========================================

REM Validate build directory exists
if not exist "%BUILD_DIR%" (
    echo Error: Build directory %BUILD_DIR% does not exist
    exit /b 1
)

REM Example deployment methods - uncomment and customize as needed

REM Method 1: Deploy via RSYNC to remote server (requires rsync for Windows)
REM set RSYNC_TARGET=user@your-server.com:/var/www/html/%PROJECT_NAME%/
REM echo Deploying via RSYNC to %RSYNC_TARGET%...
REM rsync -avz --delete "%BUILD_DIR%/" "%RSYNC_TARGET%"

REM Method 2: Deploy to AWS S3
REM set S3_BUCKET=your-bucket-name
REM echo Deploying to S3 bucket: %S3_BUCKET%...
REM aws s3 sync "%BUILD_DIR%/" "s3://%S3_BUCKET%/" --delete

REM Method 3: Deploy to local web server
REM set LOCAL_WEB_ROOT=C:\inetpub\wwwroot\%PROJECT_NAME%\
REM echo Deploying to local web server: %LOCAL_WEB_ROOT%...
REM xcopy /E /I /Y "%BUILD_DIR%\*" "%LOCAL_WEB_ROOT%"

REM Method 4: Create deployment package
REM for /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set mydate=%%c%%a%%b)
REM for /f "tokens=1-2 delims=/:" %%a in ('time /t') do (set mytime=%%a%%b)
REM set PACKAGE_NAME=%PROJECT_NAME%-%mydate%-%mytime%.zip
REM echo Creating deployment package: %PACKAGE_NAME%...
REM powershell -Command "Compress-Archive -Path '%BUILD_DIR%\*' -DestinationPath '%PACKAGE_NAME%'"
REM echo Package created: %PACKAGE_NAME%

echo Deployment completed successfully!

endlocal

