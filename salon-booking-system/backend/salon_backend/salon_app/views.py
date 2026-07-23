from rest_framework import viewsets
from .models import SalonSetting, Service, Product, Customer
from .serializers import SalonSettingSerializer, ServiceSerializer, ProductSerializer, CustomerSerializer


class SalonSettingViewSet(viewsets.ModelViewSet):
    queryset = SalonSetting.objects.all()
    serializer_class = SalonSettingSerializer


class ServiceViewSet(viewsets.ModelViewSet):
    queryset = Service.objects.all()
    serializer_class = ServiceSerializer


class ProductViewSet(viewsets.ModelViewSet):
    queryset = Product.objects.all()
    serializer_class = ProductSerializer


class CustomerViewSet(viewsets.ModelViewSet):
    queryset = Customer.objects.all()
    serializer_class = CustomerSerializer
