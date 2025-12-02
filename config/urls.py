"""
URL configuration for madugu foundation project.
"""
from django.contrib import admin
from django.urls import path, include
from django.conf import settings
from django.conf.urls.static import static
from foundation import views

urlpatterns = [
    path('admin/', admin.site.urls),
    path('', include('foundation.urls')),
]

# Serve media files in development
if settings.DEBUG:
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
    urlpatterns += static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)

# 404 handler
handler404 = views.page_not_found

