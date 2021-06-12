//COPYCLST JOB (TSO),                                                
//             'COPY KICKS CLISTS',                                     
//             CLASS=A,                                              
//             MSGCLASS=A,                                           
//             MSGLEVEL=(1,1),                                       
//             USER=IBMUSER,PASSWORD=SYS1                            
//*                          
//STEP1 EXEC PGM=IEBGENER
//SYSPRINT DD SYSOUT=*
//SYSIN DD DUMMY
//SYSUT1 DD *,DLM=@@
PROC 0 VER(V1R5M0) U(KICKS) S(KICKSSYS) UPDATE(UPDATE) DUMMY(.NU.)      00010000
 /* */                                                                  00020000
 /* CLIST TO MAKE JCL (ETAL) CHANGES      */                            00030000
 /* */                                                                  00040000
 /* TO RUN THIS TYPE                      */                            00050000
 /* EXEC KICKSSYS.V1R5M0.CLIST(KFIX)      */                            00060000
 /* */                                                                  00070000
 /* */                                                                  00080000
 /* FIRST GENERATE PDSUPDTE CONTROL CARDS */                            00090000
 /*            AKA IPOUPDTE               */                            00100000
 /* */                                                                  00110000
CONTROL NOMSG NOFLUSH                                                   00120000
FREE  FI(SYSTERM)                                                       00130000
FREE  FI(SYSPRINT)                                                      00140000
ALLOC FI(SYSTERM)  DA(*)                                                00150000
ALLOC FI(SYSPRINT) DA(*)                                                00160000
 /* */                                                                  00170000
SET &UU1 = SYSGEN                                                       00180000
 /* */                                                                  00210000
SET &NM  = 1                                                            00220000
SET &UU  = &UU1  
 /* */                                                                  00240000
WRITE KICKS &VER CUSTOMIZATION                                          00260000
WRITE THE KICKS INSTALL HLQ (HIGH LEVEL QUALIFIER) WILL BE &NM  &UU     00330000
ITSYES: SET &UU = &UU                                                   00550000
 /* */                                                                  00560000
ERROR GOTO ERRDONE1                                                     00570000
 SET &ZOS = 0                                                           00580000
 SYSCALL TESTSUB ZOS                                                    00590000
ERRDONE1: +                                                             00600000
  ERROR OFF                                                             00610000
 IF &ZOS > 0 THEN DO                                                    00620000
  WRITE LOOKS LIKE ZOS                                                  00630000
  END                                                                   00640000
 ELSE DO                                                                00650000
  WRITE LOOKS LIKE TURNKEY MVS                                          00660000
  END                                                                   00670000
 /* */                                                                  00680000
DELETE ZFIX.SYSIN                                                       00690000
FREE  FI(SYSIN)                                                         00700000
CONTROL   MSG   FLUSH                                                   00710000
ALLOC FI(SYSIN) DA(ZFIX.SYSIN) NEW CATALOG +                            00720000
 UNIT(SYSDA) SPACE(5) TRACKS                                            00730000
OPENFILE SYSIN OUTPUT                                                   00740000
IF &ZOS > 0 THEN DO                                                     00750000
 /* ZJOBCARD - USE JOB CLASS=A FOR Z/OS */                              00760000
 WRITE -- WILL CHANGE JOB CLASS                                         00770000
 SET &SYSIN = &STR(CLASS=C<CLASS=A<&STR( )JOB&STR( )<)                  00780000
 PUTFILE SYSIN                                                          00790000
 /* ZJOBCARD - USE REGION=64M FOR Z/OS */                               00800000
 WRITE -- WILL CHANGE REGION SIZES                                      00810000
 SET &SYSIN = &STR(REGION=5000K<REGION=64M<&STR( )JOB&STR( )<)          00820000
 PUTFILE SYSIN                                                          00830000
 SET &SYSIN = &STR(REGION=6000K<REGION=64M<&STR( )JOB&STR( )<)          00840000
 PUTFILE SYSIN                                                          00850000
 SET &SYSIN = &STR(REGION=7000K<REGION=64M<&STR( )JOB&STR( )<)          00860000
 PUTFILE SYSIN                                                          00870000
 END                                                                    00880000
 /* ZUSRID - MATCH HLQ'S TO CURRENT USER ID */                          00890000
SET &SYSIN = &STR(HERC01<&UU<                                           00900000
PUTFILE SYSIN                                                           00910000
SET &SYSIN = &STR(K.S.<&UU&STR(.)S.<                                    00920000
PUTFILE SYSIN                                                           00930000
SET &SYSIN = &STR(K.U.<&UU&STR(.)U.<                                    00940000
PUTFILE SYSIN                                                           00950000
SET &SYSIN = &STR(&STR(')K.<&STR(')&UU&STR(.)<                          00960000
PUTFILE SYSIN                                                           00970000
SET &SYSIN = &STR(&STR(=)K.<&STR(=)&UU&STR(.)<                          00980000
PUTFILE SYSIN                                                           00990000
SET &SYSIN = &STR(&STR((K.<&STR((&UU&STR(.)<                            01000000
PUTFILE SYSIN                                                           01010000
SET &SYSIN = &STR(.S.<.&S..<)                                           01020000
PUTFILE SYSIN                                                           01030000
SET &SYSIN = &STR(.U.<.&U..<)                                           01040000
PUTFILE SYSIN                                                           01050000
IF &ZOS = 0 THEN DO                                                     01060000
 /* WRITE LOOKS LIKE TURNKEY */                                         01070000
 /* DEFAULT TCP 2$ IN CASE BAD (OLD) ZP60009 */                         01080000
 WRITE -- WILL CHANGE TCP TO 2$                                         01090000
 SET &SYSIN = &STR(TCP&STR((1$&STR())<TCP&STR((2$&STR())<               01100000
 PUTFILE SYSIN                                                          01110000
 END                                                                    01120000
IF &ZOS > 0 THEN DO                                                     01130000
 /* ZASM - USE ASMA90 ASSEMBLER IN Z/OS */                              01140000
 WRITE -- WILL CHANGE ASSEMBLER NAME                                    01150000
 SET &SYSIN = &STR(IFOX00<ASMA90<)                                      01160000
 PUTFILE SYSIN                                                          01170000
 /* ZCOB - USE COBOL2 PROCS IN Z/OS */                                  01180000
 WRITE -- WILL CHANGE PROC NAMES TO USE COBOL2                          01190000
 SET &SYSIN = &STR(KIKCOBCL<KIKCB2CL<)                                  01200000
 PUTFILE SYSIN                                                          01210000
 SET &SYSIN = &STR(K2KCOBCL<KIKCB2CL<)                                  01220000
 PUTFILE SYSIN                                                          01230000
 SET &SYSIN = &STR(KIKCOBCS<KIKCB2CS<)                                  01240000
 PUTFILE SYSIN                                                          01250000
 SET &SYSIN = &STR(K2KCOBCS<KIKCB2CS<)                                  01260000
 PUTFILE SYSIN                                                          01270000
 /* ZJCLLIB - USE Z/OS JCL PROCLIB IN Z/OS */                           01280000
 WRITE -- WILL CHANGE JOBPROC TO JCLLIB                                 01290000
 SET &SYSIN = &STR(&STR( )DD&STR( )<&STR( )JCLLIB&STR( )<               01300000
 SET &SYSIN = &STR(&SYSIN.JOBPROC&STR( )<                               01310000
 PUTFILE SYSIN                                                          01320000
 SET &SYSIN = &STR(&STR( )DSN=<&STR( )ORDER=(<JOBPROC&STR( )<           01330000
 PUTFILE SYSIN                                                          01340000
 SET &SYSIN = &STR(&STR(,)DISP=SHR<Z&STR()))<JOBPROC&STR( )<            01350000
 PUTFILE SYSIN                                                          01360000
 END                                                                    01370000
CLOSFILE SYSIN                                                          01380000
FREE FI(SYSIN)                                                          01390000
 /* */                                                                  01400000
 /* THEN RUN PDSUPDTE WITH THOSE CONTROL CARDS */                       01410000
 /* */                                                                  01420000
CONTROL NOMSG   FLUSH                                                   01430000
 /* WOULD BE NICE TO DO THE FREE'S IN A SUBROUTINE, */                  01440000
 /* BUT MVS38J CLISTS DO NOT HAVE 'SYSCALL'...      */                  01450000
FREE  FI(SYSTERM)                                                       01460000
FREE  FI(SYSPRINT)                                                      01470000
FREE  FI(@UCB2)                                                         01480000
FREE  FI(@UCOB)                                                         01490000
FREE  FI(@UCOBCPY)                                                      01500000
FREE  FI(@UGCC)                                                         01510000
FREE  FI(@UINST)                                                        01520000
FREE  FI(@UMAPS)                                                        01530000
FREE  FI(@UOPIDS)                                                       01540000
FREE  FI(@USPUFI)                                                       01550000
FREE  FI(@SCMD)                                                         01560000
FREE  FI(@SCOB)                                                         01570000
FREE  FI(@SCOBCPY)                                                      01580000
FREE  FI(@SDOC)                                                         01590000
FREE  FI(@SGCC)                                                         01600000
FREE  FI(@SINST)                                                        01610000
FREE  FI(@SMACS)                                                        01620000
FREE  FI(@SMAPS)                                                        01630000
FREE  FI(@SPROC)                                                        01640000
FREE  FI(@SPROCZ)                                                       01650000
FREE  FI(@STESTC)                                                       01660000
FREE  FI(@STESTG)                                                       01670000
FREE  FI(@STESTF)                                                       01680000
CONTROL   MSG   FLUSH                                                   01690000
ALLOC FI(SYSIN) DA(ZFIX.SYSIN) OLD                                      01700000
ALLOC FI(SYSTERM)  DA(*)                                                01710000
ALLOC FI(SYSPRINT) DUMMY                                                01720000
 /* */                                                                  01730000
ALLOC FI(@UCB2)    DA('&UU..&U..&VER..CB2')      SHR                    01740000
ALLOC FI(@UCOB)    DA('&UU..&U..&VER..COB')      SHR                    01750000
ALLOC FI(@UCOBCPY) DA('&UU..&U..&VER..COBCOPY')  SHR                    01760000
ALLOC FI(@UGCC)    DA('&UU..&U..&VER..GCC')      SHR                    01770000
 /*   FI(@UGCCCPY) DA('&UU..&U..&VER..GCCCOPY')  S*/                    01780000
ALLOC FI(@UINST)   DA('&UU..&U..&VER..INSTLIB')  SHR                    01790000
ALLOC FI(@UMAPS)   DA('&UU..&U..&VER..MAPSRC')   SHR                    01800000
ALLOC FI(@UOPIDS)  DA('&UU..&U..&VER..OPIDS')    SHR                    01810000
ALLOC FI(@USPUFI)  DA('&UU..&U..&VER..SPUFI.IN') SHR                    01820000
ALLOC FI(@SCMD)    DA('SYS1.CMDPROC')            SHR                    01830000
ALLOC FI(@SCOB)    DA('&UU..&S..&VER..COB')      SHR                    01840000
ALLOC FI(@SCOBCPY) DA('&UU..&S..&VER..COBCOPY')  SHR                    01850000
ALLOC FI(@SDOC)    DA('&UU..&S..&VER..DOC')      SHR                    01860000
ALLOC FI(@SGCC)    DA('&UU..&S..&VER..GCC')      SHR                    01870000
 /*   FI(@SGCCCPY) DA('&UU..&S..&VER..GCCCOPY')  S*/                    01880000
ALLOC FI(@SINST)   DA('&UU..&S..&VER..INSTLIB')  SHR                    01890000
ALLOC FI(@SMACS)   DA('&UU..&S..&VER..MACLIB')   SHR                    01900000
ALLOC FI(@SMAPS)   DA('&UU..&S..&VER..MAPSRC')   SHR                    01910000
ALLOC FI(@SPROC)   DA('&UU..&S..&VER..PROCLIB')  SHR                    01920000
ALLOC FI(@SPROCZ)  DA('&UU..&S..&VER..PROCLIBZ') SHR                    01930000
ALLOC FI(@STESTC)  DA('&UU..&S..&VER..TESTCOB')  SHR                    01940000
ALLOC FI(@STESTG)  DA('&UU..&S..&VER..TESTGCC')  SHR                    01950000
ALLOC FI(@STESTF)  DA('&UU..&S..&VER..TESTFILE') SHR                    01960000
 /* */                                                                  01970000
CALL '&UU..&S..&VER..SKIKLOAD(PDSUPDTE)' '&UPDATE'                      01980000
 /* */                                                                  01990000
 /* THEN GET RID OF THE SYSIN FILE */                                   02000000
 /*  AND FREE ALL THE OTHER ALLOCS */                                   02010000
 /* */                                                                  02020000
CONTROL NOMSG NOFLUSH                                                   02030000
FREE  FI(SYSIN)                                                         02040000
FREE  FI(SYSTERM)                                                       02050000
FREE  FI(SYSPRINT)                                                      02060000
DELETE ZFIX.SYSIN                                                       02070000
FREE  FI(@UCB2)                                                         02080000
FREE  FI(@UCOB)                                                         02090000
FREE  FI(@UCOBCPY)                                                      02100000
FREE  FI(@UGCC)                                                         02110000
 /*   FI(@UGCC)                            */                           02120000
FREE  FI(@UINST)                                                        02130000
FREE  FI(@UMAPS)                                                        02140000
FREE  FI(@UOPIDS)                                                       02150000
FREE  FI(@USPUFI)                                                       02160000
FREE  FI(@SCMD)                                                         02170000
FREE  FI(@SCOB)                                                         02180000
FREE  FI(@SCOBCPY)                                                      02190000
FREE  FI(@SDOC)                                                         02200000
FREE  FI(@SGCC)                                                         02210000
 /*   FI(@SGCC)                            */                           02220000
FREE  FI(@SINST)                                                        02230000
FREE  FI(@SMACS)                                                        02240000
FREE  FI(@SMAPS)                                                        02250000
FREE  FI(@SPROC)                                                        02260000
FREE  FI(@SPROCZ)                                                       02270000
FREE  FI(@STESTC)                                                       02280000
FREE  FI(@STESTG)                                                       02290000
FREE  FI(@STESTF)                                                       02300000
WRITE DONE!                                                             02310000
EXIT                                                                    02320000
 /* */                                                                  02330000
TESTSUB: PROC 1 TEST                                                    02340000
 SYSREF &TEST                                                           02350000
 SET &TEST = &TEST + 1                                                  02360000
 END                                                                    02370000
@@
//SYSUT2   DD  DSN=SYS1.CMDPROC(KFIX),DISP=SHR
//STEP2  EXEC PGM=IEBCOPY
//SYSPRINT DD  SYSOUT=*
//SYSUT1   DD  DSN=SYSGEN.KICKSSYS.V1R5M0.CLIST,DISP=SHR
//SYSUT2   DD  DSN=SYS1.CMDPROC,DISP=SHR
//SYSIN    DD  *
  COPY INDD=((SYSUT1,R)),OUTDD=SYSUT2
  SELECT MEMBER=KICKS
//*      
