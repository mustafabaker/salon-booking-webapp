from django.db import models


class SalonSetting(models.Model):
    key = models.CharField(max_length=100, unique=True)
    value = models.TextField()

    def __str__(self):
        return self.key


class Service(models.Model):
    title = models.CharField(max_length=200)
    description = models.TextField(blank=True)
    price = models.CharField(max_length=50, blank=True)
    category = models.CharField(max_length=100, default='service')

    def __str__(self):
        return self.title


class Product(models.Model):
    title = models.CharField(max_length=200)
    description = models.TextField(blank=True)
    price = models.CharField(max_length=50, blank=True)

    def __str__(self):
        return self.title


class Customer(models.Model):
    name = models.CharField(max_length=200)
    email = models.EmailField(blank=True)
    phone = models.CharField(max_length=50, blank=True)
    notes = models.TextField(blank=True)
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.name
