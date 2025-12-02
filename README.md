# Madugu Foundation - Django Website

A Django-based website for the Madugu Foundation, built from a charity/NGO HTML template.

## Features

- Modern, responsive design
- Multiple page layouts (Home, About, Services, Projects, Events, Donations, Blog, Team)
- Django static file management
- Admin panel for content management

## Technology Stack

- **Backend**: Django 4.2
- **Frontend**: HTML, CSS, JavaScript, Bootstrap
- **Database**: SQLite (development)

## Getting Started

### Prerequisites

- Python 3.8 or higher
- pip (Python package installer)

### Installation

1. Clone the repository:
```bash
git clone <repository-url>
cd newmadugufoundation
```

2. Create a virtual environment:
```bash
python -m venv venv
# On Windows:
venv\Scripts\activate
# On macOS/Linux:
source venv/bin/activate
```

3. Install dependencies:
```bash
pip install -r requirements.txt
```

4. Run migrations:
```bash
python manage.py migrate
```

5. Create a superuser (optional):
```bash
python manage.py createsuperuser
```

6. Start the development server:
```bash
python manage.py runserver
```

7. Open your browser and navigate to `http://127.0.0.1:8000/`

## Project Structure

```
newmadugufoundation/
├── config/              # Django project settings
├── foundation/          # Main Django app
├── templates/           # HTML templates
├── assets/              # Static files (CSS, JS, images)
├── manage.py           # Django management script
└── requirements.txt    # Python dependencies
```

## Available Pages

- Home: `/`
- About: `/about/`
- Contact: `/contact/`
- Services: `/services/`
- Projects: `/projects/`
- Events: `/events/`
- Donations: `/donations/`
- Blog: `/blog/`
- Team: `/team/`
- FAQ: `/faq/`
- Pricing: `/pricing/`
- Admin: `/admin/`

## Development

This project uses Django's static files system. All static assets are served from the `assets/` directory.

## License

[Add your license here]

## Contact

[Add contact information here]

