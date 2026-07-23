import mimetypes
from pathlib import Path

from django.contrib import admin
from django.http import FileResponse, Http404
from django.urls import path, include

FRONTEND_DIR = Path(__file__).resolve().parent.parent.parent / 'frontend'


def serve_frontend_file(request, path=''):
    relative_path = path or 'index.html'
    file_path = (FRONTEND_DIR / relative_path).resolve()
    if not str(file_path).startswith(str(FRONTEND_DIR)):
        raise Http404
    if not file_path.exists() or not file_path.is_file():
        raise Http404
    content_type, _ = mimetypes.guess_type(str(file_path))
    return FileResponse(open(file_path, 'rb'), content_type=content_type or 'application/octet-stream')


urlpatterns = [
    path('admin/', admin.site.urls),
    path('api/', include('salon_app.urls')),
    path('', serve_frontend_file, name='home'),
    path('index.html', serve_frontend_file, name='index'),
    path('admin.html', serve_frontend_file, name='admin'),
    path('<path:path>', serve_frontend_file, name='frontend-file'),
]
