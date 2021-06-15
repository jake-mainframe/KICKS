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

To install first you need to edit the JCL located in the PDS `KICKS.KICKS.V1R5M0.INSTLIB`.

For each job change the jobcard to add `(JOB),'Demo',` and change the CLASS to `A`.

**Murach**

From: `//MURACH JOB  CLASS=C,MSGCLASS=A,MSGLEVEL=(1,1),REGION=1024K`

To: `//MURACH JOB (JOB),'Demo',CLASS=A,MSGCLASS=A,REGION=1024K`

**SDB**

From: `//LOADSDB JOB CLASS=C,MSGCLASS=A,MSGLEVEL=(1,1),REGION=1024K`

To: `//LOADSDB JOB (JOB),'Demo',CLASS=A,MSGCLASS=A,REGION=1024K`

**TAC**

From: `//TACDATA JOB  CLASS=C,MSGCLASS=A,MSGLEVEL=(1,1)`

To: `//TACDATA JOB (JOB),'Demo',CLASS=A,MSGCLASS=A,MSGLEVEL=(1,1)`

After changing the jobcard submit each job and the example KICKS transactions should be available.