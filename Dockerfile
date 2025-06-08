
FROM php:8.1-apache

# تثبيت الإضافات الضرورية
RUN apt-get update && apt-get install -y \
    libonig-dev libzip-dev zip unzip git \
    && docker-php-ext-install mbstring zip bcmath

# نسخ ملفات المشروع إلى مجلد الويب
COPY . /var/www/html/

# ضبط صلاحيات المجلدات الضرورية
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache

# تفعيل mod_rewrite لعمل روابط Laravel بشكل صحيح
RUN a2enmod rewrite

# فتح المنفذ 80 (الافتراضي للويب)
EXPOSE 80

# تشغيل Apache في المقدمة عند بدء الحاوية
CMD ["apache2-foreground"]