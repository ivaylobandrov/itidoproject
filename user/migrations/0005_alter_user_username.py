# Generated by Django 4.0.3 on 2022-04-03 17:57

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ("user", "0004_user_username"),
    ]

    operations = [
        migrations.AlterField(
            model_name="user",
            name="username",
            field=models.CharField(blank=True, max_length=200, null=True),
        ),
    ]