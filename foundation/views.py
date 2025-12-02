from django.shortcuts import render


def index(request):
    """Home page view"""
    return render(request, 'index.html')


def about(request):
    """About page view"""
    return render(request, 'about.html')


def contact(request):
    """Contact page view"""
    return render(request, 'contact.html')


def services(request):
    """Services page view"""
    return render(request, 'services.html')


def service_details(request):
    """Service details page view"""
    return render(request, 'service-details.html')


def projects(request):
    """Projects page view"""
    return render(request, 'projects.html')


def project_details(request):
    """Project details page view"""
    return render(request, 'project-details.html')


def events(request):
    """Events page view"""
    return render(request, 'events.html')


def event_details(request):
    """Event details page view"""
    return render(request, 'event-details.html')


def donations(request):
    """Donations page view"""
    return render(request, 'donations.html')


def donation_details(request):
    """Donation details page view"""
    return render(request, 'donation-details.html')


def blog(request):
    """Blog page view"""
    return render(request, 'blog.html')


def blog_details(request):
    """Blog details page view"""
    return render(request, 'blog-details.html')


def team(request):
    """Team page view"""
    return render(request, 'team.html')


def team_details(request):
    """Team details page view"""
    return render(request, 'team-details.html')


def faq(request):
    """FAQ page view"""
    return render(request, 'faq.html')


def pricing(request):
    """Pricing page view"""
    return render(request, 'pricing.html')


def blog_2(request):
    """Blog page 2 view"""
    return render(request, 'blog-2.html')


def page_not_found(request, exception):
    """404 page view"""
    return render(request, '404.html', status=404)

