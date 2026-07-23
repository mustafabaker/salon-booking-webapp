from rest_framework import serializers
from .models import SalonSetting, Service, Product, Customer


class SalonSettingSerializer(serializers.ModelSerializer):
    class Meta:
        model = SalonSetting
        fields = '__all__'


class ServiceSerializer(serializers.ModelSerializer):
    class Meta:
        model = Service
        fields = '__all__'


class ProductSerializer(serializers.ModelSerializer):
    class Meta:
        model = Product
        fields = '__all__'


class CustomerSerializer(serializers.ModelSerializer):
    class Meta:
        model = Customer
        fields = '__all__'
