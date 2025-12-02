from django.urls import path
from . import views

urlpatterns = [
    path('', views.index, name='index'),
    path('index-2/', views.index_2, name='index-2'),
    path('index-3/', views.index_3, name='index-3'),
    path('about/', views.about, name='about'),
    path('contact/', views.contact, name='contact'),
    path('services/', views.services, name='services'),
    path('services/details/', views.service_details, name='service-details'),
    path('projects/', views.projects, name='projects'),
    path('projects/details/', views.project_details, name='project-details'),
    path('events/', views.events, name='events'),
    path('events/details/', views.event_details, name='event-details'),
    path('donations/', views.donations, name='donations'),
    path('donations/details/', views.donation_details, name='donation-details'),
    path('blog/', views.blog, name='blog'),
    path('blog-2/', views.blog_2, name='blog-2'),
    path('blog/details/', views.blog_details, name='blog-details'),
    path('team/', views.team, name='team'),
    path('team/details/', views.team_details, name='team-details'),
    path('faq/', views.faq, name='faq'),
    path('pricing/', views.pricing, name='pricing'),
]

