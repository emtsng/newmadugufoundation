@echo off
echo ==========================================
echo Starting Local Web Server
echo ==========================================
echo.
echo Server will be available at:
echo   http://localhost:8000/index.html
echo   http://localhost:8000/about.html
echo   http://localhost:8000/contact.html
echo   (and other HTML files in root directory)
echo.
echo Press Ctrl+C to stop the server
echo ==========================================
echo.

cd /d "%~dp0"
REM Using Ruby's built-in WEBrick server
ruby -run -e httpd . -p 8000

