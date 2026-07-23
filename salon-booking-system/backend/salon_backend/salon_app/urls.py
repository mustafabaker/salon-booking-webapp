from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import SalonSettingViewSet, ServiceViewSet, ProductViewSet, CustomerViewSet

router = DefaultRouter()
router.register(r'settings', SalonSettingViewSet)
router.register(r'services', ServiceViewSet)
router.register(r'products', ProductViewSet)
router.register(r'customers', CustomerViewSet)

urlpatterns = [
    path('', include(router.urls)),
]
