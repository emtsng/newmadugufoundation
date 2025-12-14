# PowerShell script to run the local web server
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "Starting Local Web Server" -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Server will be available at:" -ForegroundColor Green
Write-Host "  http://localhost:8000/index.html" -ForegroundColor Yellow
Write-Host "  http://localhost:8000/about.html" -ForegroundColor Yellow
Write-Host "  http://localhost:8000/contact.html" -ForegroundColor Yellow
Write-Host "  (and other HTML files in root directory)" -ForegroundColor Yellow
Write-Host ""
Write-Host "Press Ctrl+C to stop the server" -ForegroundColor Red
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host ""

Set-Location $PSScriptRoot
# Using Ruby's built-in WEBrick server
ruby -run -e httpd . -p 8000

