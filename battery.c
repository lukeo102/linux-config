#include <stdio.h>

static const char *battery_error = "󱟤";
static const char *battery_icons[] = {"󰂃", "󰁺", "󰁻","󰁼","󰁽","󰁾","󰁿","󰂀","󰂁","󰁹","󰁹"};
static const char *battery_charging_icons[] = {"󰢟", "󰢜","󰂆","󰂇","󰂈","󰢝","󰂉","󰢞","󰂊","󰂅","󰂅"};
static char battery_percent_file_location[] = "/sys/class/power_supply/BAT0/capacity";
static char battery_state_file_location[] = "/sys/class/power_supply/BAT0/status";
static const char discharging_char = 'D';

const char* get_battery_icon() {
  char command[100];
  sprintf(command, "cat %s", battery_state_file_location);

  // Read first charachter from battery_charge_file 
  char charging_status[100];
  FILE *battery_state_file;
  if ((battery_state_file = popen(command, "r")) == NULL) {
    return battery_error;
  }
  if (fgets(charging_status, sizeof(charging_status), battery_state_file) == NULL) {
    return battery_error;
  }
  pclose(battery_state_file);

  sprintf(command, "cat %s", battery_percent_file_location);
  int battery_percent;
  FILE *percent_file;
  if ((percent_file = popen(command, "r")) == NULL) {
    return battery_error;
  }
  if (fscanf(percent_file, "%d", &battery_percent) == 0) {
    return battery_error;
  }
  pclose(percent_file);


  int index, num_icons;
  if (charging_status[0] == discharging_char) { // If discharging
    num_icons = (sizeof(battery_icons)/sizeof(battery_icons[0])) - 1;
    index = (int) battery_percent / num_icons;

    return battery_icons[index];
  } else { // If charging
    num_icons = (sizeof(battery_charging_icons)/sizeof(battery_charging_icons[0])) - 1;
    index = (int) battery_percent / num_icons;

    return battery_charging_icons[index];
  }

  //return return_icon;

}

