# KICKS by Mike Noel

KICKS is an enhancement for CMS & TSO on IBM mainframes (or emulators) that lets you run your CICS applications directly instead of having to 'install' those apps in CICS. You don't even need CICS itself installed on your mainframe.

## Install

On SYSGEN MVS clone this repository to the `SOFTWARE` folder and then in TSO run `INSTALL KICKS`.

All KICKS programs and files have the `KICKS.` high level qualifier (HLQ).

After the third job is complete you can run KICKS from the TSO `READY` prompt with `KICKS`.

To exit KICKS clear the screen with the `Clear` button then type `KSSF` and hit enter.

Read http://www.kicksfortso.com/ for more information about KICKS for TSO.

## Included Demos

KICKS comes with multiple different demo transactions. Installing these demo transactions is not required to run KICKS but provides an interesting examples.

These Demos are installed 

**Murach**

**SDB**

**TAC**
