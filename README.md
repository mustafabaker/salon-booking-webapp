# Salon Booking Web App

A bilingual salon booking and shopping demo with a polished landing page, an admin page, and a Django REST API for storing content locally.

## What is included

- Responsive salon landing page with English and Arabic support
- Admin page for editing salon content
- Local Django backend with SQLite storage
- Social links, WhatsApp contact, loyalty card, services, and products sections

## Project structure

- [salon-booking-system/frontend](salon-booking-system/frontend) - static frontend pages and assets
- [salon-booking-system/backend](salon-booking-system/backend) - Django backend and API

## Install and run locally

### 1) Clone the repository

```bash
git clone https://github.com/mustafabaker/salon-booking-webapp.git
cd salon-booking-webapp
```

### 2) Create a Python virtual environment

On Windows:

```bash
python -m venv .venv
.venv\Scripts\activate
```

### 3) Install Python dependencies

```bash
python -m pip install --upgrade pip
python -m pip install -r salon-booking-system/backend/requirements.txt
```

### 4) Start the backend

```bash
cd salon-booking-system/backend/salon_backend
python manage.py migrate
python manage.py runserver 0.0.0.0:8000
```

Keep that terminal open.

### 5) Start the frontend

Open a second terminal and run:

```bash
cd salon-booking-system/frontend
python -m http.server 3000
```

Then open:

- Frontend: http://127.0.0.1:3000/
- Admin page: http://127.0.0.1:3000/admin.html
- API: http://127.0.0.1:8000/api/settings/

## Optional: use the root npm scripts

From the project root, you can also use:

```bash
npm start
```

This serves the frontend from the project root.

## Notes

This project is currently a local demo and uses SQLite for easy setup. It is a strong starting point for a salon website, online booking flow, and future admin authentication.

## Next steps

- Add real appointment booking and customer records
- Add secure admin login
- Add logo upload support
- Prepare for deployment to a cloud host
