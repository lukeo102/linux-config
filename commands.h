static const char *dmenucmd[] = { "dmenu_run", "-fn", dmenufont, "-nb", col_gray1, "-nf", col_gray3, "-sb", col_cyan, "-sf", col_gray4, NULL };
static const char *termcmd[]  = { "kitty", NULL };
static const char *browser[] = { "firefox", NULL };
static const char *slock[] = { "slock", NULL };
static const char *flameshot[] = { "flameshot", "gui", NULL };
static const char *brightness_inc[] = {"xbacklight", "-inc", "10", NULL};
static const char *brightness_dec[] = {"xbacklight", "-dec", "10", NULL}; 
static const char *increase_volume[] = {"pamixer", "-i", "1", "--allow-boost", "--set-limit", "200", NULL};
static const char *decrease_volume[] = {"pamixer", "-d", "1", "--allow-boost", "--set-limit", "200", NULL};
static const char *toggle_mute[] = {"pamixer", "-t", NULL};
static const char *audio_play[] = {"playerctl", "play-pause", NULL};
static const char *audio_next[] = {"playerctl", "next", NULL};
static const char *audio_prev[] = {"playerctl", "previous", NULL};
static const char *save_replay[] = {"replay", NULL};
static const char *clipboard_menu[] = {"clipcat-menu", "-f", "dmenu", NULL};

