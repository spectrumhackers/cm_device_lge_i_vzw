#include <stdlib.h>
#include <stdio.h>
#include <errno.h>

#include <unistd.h>
#include <sys/select.h>
#include <sys/time.h>
#include <sys/ioctl.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

#include <cutils/properties.h>

#define err printf

static int
writeline(int fd, const char* line)
{
    char buf[256];
    sprintf(buf, "%s\r\n", line);
    write(fd, buf, strlen(buf));
    return 0;
}

static char  modem_buf[256];
static char* modem_p = modem_buf;

static int
wait_readable(int fd, int sec)
{
    struct timeval tv;
    fd_set fds;
    int rc;

    memset(&tv, 0, sizeof(tv));
    tv.tv_sec = sec;

    FD_ZERO(&fds);
    FD_SET(fd, &fds);

    rc = select(fd+1, &fds, NULL, NULL, &tv);
    if (rc <= 0) {
        return -1;
    }
    if (!FD_ISSET(fd, &fds)) {
        return -1;
    }
    return 0;
}

static int
readline(int fd, char* line)
{
    int rc = -1;

    while (modem_p < &modem_buf[256]) {
        char* bol;
        char* eol;
        size_t remain;
        ssize_t len;
        /*
         * We send CRLF for line endings, but modem only echoes CR.
         * So we'll use CR to detect line endings and throw away any
         * LFs that we see.
         */
        eol = strchr(modem_buf, '\r');
        if (eol) {
            *eol = '\0';
            bol = modem_buf;
            if (*bol == '\n') {
                ++bol;
            }

            memcpy(line, bol, (eol-bol)+1); /* Copy the line */

            remain = modem_p - (eol+1);
            if (remain > 0) {
                memmove(modem_buf, eol+1, remain);
            }
            memset(modem_buf+remain, 0, sizeof(modem_buf)-remain);
            modem_p = modem_buf + remain;

            return 0;
        }

        if (wait_readable(fd, 2) != 0) {
            return -1;
        }
        len = read(fd, modem_p, sizeof(modem_buf) - (modem_p-modem_buf));
        if (len <= 0) {
            return -1;
        }
        modem_p += len;
    }
    return -1;
}

int
read_modem_props(void)
{
    int rc = -1;
    int fdspi;
    int fdmodem;
    int ldisc;
    char line[256];
    char model[256];
    char baseband[256];
    char* p;

    fdspi = open("/dev/ttyspi0", O_RDWR);
    if (fdspi < 0) {
        err("Cannot open spi: %s\n", strerror(errno));
        return -1;
    }

    sleep(3);

    ldisc = 19; /* N_TS2710 */
    if (ioctl(fdspi, TIOCSETD, &ldisc) != 0) {
        err("Cannot set ldisc\n");
        close(fdspi);
        return -1;
    }

    fdmodem = open("/dev/pts1", O_RDWR);
    if (fdmodem < 0) {
        err("Cannot open modem: %s\n", strerror(errno));
        close(fdspi);
        return -1;
    }

    writeline(fdmodem, "AT$LGMR");
    while (readline(fdmodem, line) == 0) {
        if (memcmp(line, "$LGMR:", 6) == 0) {
            p = line+6;
            while (*p == ' ') {
                ++p;
            }
            strcpy(baseband, p);
            memcpy(model, p, 5);
            model[5] = '\0';
            rc = 0;
            break;
        }
    }

    close(fdmodem);
    close(fdspi);
    if (rc == 0) {
        printf("Baseband: %s\nModel: %s\n", baseband, model);
        property_set("install.baseband", baseband);
        property_set("install.model", model);
    }
    else {
        err("Cannot find baseband\n");
    }
    return rc;
}

int
read_install_props(void)
{
    int fd;
    int rc;
    char buf[1024];
    char* nextline;
    char* key;
    char* val;

    fd = open("/sdcard/.install.prop", O_RDONLY);
    if (fd < 0) {
        return -1;
    }
    memset(buf, 0, sizeof(buf));
    rc = read(fd, buf, sizeof(buf)-1);
    close(fd);
    if (rc <= 0) {
        err("Cannot read install props\n");
        return -1;
    }

    nextline = buf;
    while (nextline != NULL) {
        key = nextline;
        nextline = strchr(key, '\n');
        if (nextline != NULL) {
            *nextline = '\0';
            ++nextline;
        }
        val = strchr(key, '=');
        if (val != NULL) {
            *val = '\0';
            ++val;
            printf("Install prop: %s=%s\n", key, val);
            property_set(key, val);
        }
    }

    return 0;
}

int
main(int argc, char** argv)
{
    read_modem_props();
    read_install_props();
    return 0;
}
