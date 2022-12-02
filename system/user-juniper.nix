{ pkgs, ... }:

{
  # Shell needs to be enabled here so user can set it as their default
  programs.zsh.enable = true;

  users.users.juniper = {
    isNormalUser = true;
    home = "/home/juniper";
    extraGroups = ["wheel" "networkmanager"];
    shell = pkgs.zsh;
  };

  users.users."juniper".openssh.authorizedKeys.keys = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDscWRwMVdsv3pgzwUnM1FiHkvwlIKV01ovTMSgExyJsPhoD2L1Hab4ecTetK8uMi6RJx6o55kI5R3gPaorwGCBq+INA6n59khFJWbASfC5jQFSoSoBmHHBr4z1KnUuPUOxR1AvO1oFF6CDgDLy2S3tMC+a7FJiyafyUSefdTY7waH5PHdbb7EsSJqjFUbgoUJYfWOckHdqOo2K1zPdf6ED+dOPl1fOn79E0T5C1spDJUo6Vxq74agnPMmRHYOPftDAf1kCIrplGTKnsmmIT09dkNEzNJnN++VN8nTVQRnhsT38M/S9J000hsb3eklb+GGWkbr39d+XVw0FHC7Vju1I3rYM1D75/QOhbhoTZy5+18PfOkN9ppMggD8oKYaxP4+SctO/733CzlhUIiioYji7KPAs0HmqiCqhYkEpyf9M3dwoz4Wd6+V5BcJeBJOtU1xYEce2l4JC072JqtimqF7RvpeB6P2WyYscPyPU+AHiIrk3ZWjsCo/yBh0hH+kMz6Udz8lUsp5Kep/qzqcALdpUja37bBATifRE2TG763G4d1vgtcoIAAbxADawFmOUcIjYm+akvTu0PQ41lg0cYjql8422t9riNRlKaO3a/wWie/aDBwGRDEXqpvMiSey3uVJSL0u67Xf3prTGhitrPar6Zv5hzlwCe2UKcix06EErzQ=="
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDQ4s1YabIsYY4kmkJqXrUayaZjuUpSiNlT/NH8FK3kY/aMqXKnw3F5oBo6Um+pQ0zpHMznnyZKVOc/AqLS+93RImjqZZmOkwQvamOvZG8noao04HV9EmY83gvd4Y7Mf/DamnpJSV7dj5HbLPDDADvkhSIBBxK5FGVPzG1mImrtFrQTY/a33wyXWe2q7M/IOiuWrlzrb6F7PjIP4OCu4RaxHSkgjdsMAcmsWYiKKVyw067VpBcFoHkKFWydzpS/J5SB7VLCe67Y+rTSokrOgbOKnUsXtNY8IcEGUG82p+Chfv7PAT8L6iw9EAl4FFiH5EMH+kCAPJiCQg5tEj6ep+LtDCxc6c7OhFd51RFpF4T1n+SZ1sTM5PCpVJ7WS3pS+mk99FjXoExNTFaKB5xlvCHV5+tWZ6KcuxJilPUXuMqBP7kWrWrv0KTBHdfUEi9Ie+UlvZAsoC0bNvy8HvNilVVs31ymCMINOzbmWG2WbXHo1ryuH7AkGXW5HXzVt6JIKnqivp+Cna21MZE757i3pkTJFNZhajypgJ+7w9+YExsG0toRvSQtuhiPzU/cpDM5WSodWdPGpt0egx9p+PMuhgidi2Ta701Y2o/DeBcJLw8Hx8vnzLJ+ly+sNdzlhLARw7Ava4pBoZh2OBL4/z5ez5scQdpo9LbHzlgJuP3KLrcVow=="
  ];

}
