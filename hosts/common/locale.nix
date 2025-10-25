# Pending review
{lib, ...}: let
  defaultLocale = "pt_BR.UTF-8";
  defaultLanguage = "en_GB.UTF-8";
in {
  time = {
    # NOTE: not needed when using localtimed.
    # timeZone = "America/Sao_Paulo";
    hardwareClockInLocalTime = true;
  };

  # Geolocation services
  services.geoclue2.enable = true;
  services.localtimed.enable = true;

  i18n = {
    defaultLocale = defaultLocale;
    extraLocaleSettings = {
      LC_CTYPE = defaultLocale;
      LC_NUMERIC = "C.UTF-8";
      LC_COLLATE = "C.UTF-8";
      LC_TIME = defaultLanguage;
      LC_MESSAGES = defaultLanguage;
      LC_MONETARY = defaultLocale;
      LC_ADDRESS = defaultLocale;
      LC_IDENTIFICATION = defaultLocale;
      LC_MEASUREMENT = defaultLocale;
      LC_PAPER = defaultLocale;
      LC_TELEPHONE = defaultLocale;
      LC_NAME = defaultLocale;
      LANG = defaultLanguage;
    };

    supportedLocales = [
      "${defaultLocale}/UTF-8"
      "${defaultLanguage}/UTF-8"
      "en_US.UTF-8/UTF-8"
      "C.UTF-8/UTF-8"
    ];
  };
}
