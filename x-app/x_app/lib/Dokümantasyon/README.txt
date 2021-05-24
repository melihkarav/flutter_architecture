

Dosya Yapısı;

A-	lib
	1-	internal
        I-   component 
        II-  controller
        III- model
        IV-  service
        V-   statics
        VI-  utils
        VII- view
    2-  navigation
        I-   navigation.dart
    3-  main.dart
B-
.
.
.

Açıklamalar;
A- Ana paket
    1-  Widget ve araçlar
        I-   Yardımcı Widgetlar  (Not: Tema için oluşturulacak widgetlar bu paket içerisinde bulunması önerilir.)
        II-  StatefulWidget'ların bulunduğu yapılandırıcılar
        III- modeller
        IV-  Post-Get-Push methodları
        V-   Uygulama çalışma anında ram'de bulunması gereken değerler
        VI-  Karmaşık yordamlar
        VII- State Widgetlar
    2-  Uygulama için yaşam döngüsünü ve navigasyon işlemleri (Not: Sesion entegrasyonu olduğunda sesion kontrolleri bu kısımda yapılacak)
    3-  Uygulama başlatıcısı (Not: Bu bölümde ileride güncelleme kontrolleri bu kısımda yapılacak. Kullanıcı uygulaması güncel değil ise bu katmandan diğer katmanlara geçiş izni bulunmayacak.)