#include <stdio.h>
#include <errno.h>
#include <pwd.h>
#include <stdlib.h>
#include <sys/syscall.h>
#include <unistd.h>

uid_t uid_by_name(const char *name);

int main(int argc, char *argv[]){
	uid_t uidn;
	int rc;
	uidn = uid_by_name(argv[2]);
	rc = syscall(SYS_chown,argv[1], uidn, uidn);
	if (rc == -1){
		fprintf(stderr, "Programm failed, Error Number :  = %d\n", errno);
	}
}
	uid_t uid_by_name(const char *name){
		if(name) {
			struct passwd *pwd = getpwnam(name);
			if(pwd)
				return pwd-> pw_uid;
		}
	return -1;
}
