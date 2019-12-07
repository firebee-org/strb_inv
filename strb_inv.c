#include <stdio.h>
#include <stdint.h>
#include <osbind.h>
#include <mint/ostruct.h>
#include <mint/sysvars.h>


void __main(void)
{
	;
}

volatile long *acp_config = (volatile long *) 0xff040000;

void inv_strb(void)
{
    (void) Cconws("ACP_CONFIG(0)=");
    (void) Cconws(*acp_config & 1 ? "1" : "0");
    (void) Cconws("\r\n");
    *acp_config ^= 1;
    (void) Cconws("ACP_CONFIG(0)=");
    (void) Cconws(*acp_config & 1 ? "1" : "0");
    (void) Cconws("\r\n");
}

int main(int argc, char *argv[])
{
    Supexec(inv_strb);
    Pterm0();
}
